//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit
import RxSwift
import RxCocoa

class TodayController: BaseController {

  // MARK: - ViewModel

  var viewModel: TodayViewModel!
  var todayDetailController: TodayDetailController?
  var todayDetailControllerViewLayout: AnchoredConstraints?

  // MARK: - Private

  private lazy var todayListView: TodayListView = {
    let listView = TodayListView()
    view.addSubview(listView)
    return listView
  }()

  private lazy var capView: UIView = {
    let capView = ViewBuilder()
      .setBackgroundColor(DefaultTheme.Color.secondaryColor)
      .setHeightAnchor(UIApplication.shared.statusBarFrame.height)
      .build()

    view.addSubview(capView)
    return capView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  override func setupConstraints() {
    super.setupConstraints()

    capView
      .setTopAnchor(view.topAnchor)
      .setLeadingAnchor(view.leadingAnchor)
      .setTrailingAnchor(view.trailingAnchor)

    todayListView
      .setTopAnchor(capView.bottomAnchor)
      .setLeadingAnchor(view.leadingAnchor)
      .setBottomAnchor(view.bottomAnchor)
      .setTrailingAnchor(view.trailingAnchor)
  }
}

extension TodayController {
  func setupTodayDetailController(withTodayDetailInfo info: TodayDetailViewInfo) {
    let controller = TodayDetailController()
    todayDetailController = controller
    guard let todayDetailController = todayDetailController else {
      return
    }

    todayDetailController.todayItemViewModel = info.todayItemVIewModel
    todayDetailController.view.backgroundColor = .red
    todayDetailController.viewWillAnimated()
    view.addSubview(todayDetailController.view)
    addChild(todayDetailController)

    todayDetailControllerViewLayout = todayDetailController.view.anchor(
      top: view.topAnchor,
      leading: view.leadingAnchor,
      bottom: nil,
      trailing: nil,
      padding: .init(top: info.startingFrame.origin.y, left: info.startingFrame.origin.x, bottom: 0, right: 0),
      size: info.startingFrame.size
    )

    self.view.layoutIfNeeded()
  }
}

extension TodayController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    viewWillAppearAction
      .asDriverJustComplete()
      .drive(viewModel.inputs.fetchToday)
      .disposed(by: disposeBag)

    viewModel.outputs.todayItemViewModels
      .asDriverJustComplete()
      .drive(todayListView.rx.updateTodayItemViewModels)
      .disposed(by: disposeBag)

    todayListView.rx.itemSelected
      .asObservable()
      .map { [unowned self] indexPath -> TodayDetailViewInfo? in

        guard
          let viewModel = self.todayListView.todayItemViewModels?[safe: indexPath.item],
          let selectedCell = self.todayListView.cellForItem(at: indexPath),
          let staringFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil)
          else { return nil }

        return TodayDetailViewInfo(
          indexItem: indexPath.item,
          todayItemVIewModel: viewModel,
          startingFrame: staringFrame
        )
      }
      .ignoreNil()
      .map { item in
        print(item)
        return item
      }
      .asDriverJustComplete()
      .drive(self.rx.setupTodayDetailController)
      .disposed(by: disposeBag)
  }
}

extension Reactive where Base: TodayController {
  internal var setupTodayDetailController: Binder<TodayDetailViewInfo> {
    return Binder(self.base) { base, result in
      base.setupTodayDetailController(withTodayDetailInfo: result)
    }
  }
}
