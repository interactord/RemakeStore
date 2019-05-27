//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SCLayoutKit

class AppDetailController: BaseController {

  // MARK: - ViewModel

  var viewModel: AppDetailViewModeling!

  // MARK: Public

  var appId: Int!

  private(set) lazy var appDetailNavigationItem = AppDetailNavigationItem()

  private lazy var appDetailResultView: AppDetailResultView = {
    let resultView = AppDetailResultView()
    view.addSubview(resultView)
    return resultView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func setupConstraints() {
    super.setupConstraints()

    appDetailResultView.fillSuperView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    appDetailNavigationItem.insertRIghtBarItem(from: navigationController)
    appDetailNavigationItem.showItem(show: false)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    appDetailNavigationItem.remoteRIghtBarItem(form: navigationController)
  }

  override func setupNavigation() {
    super.setupNavigation()
    navigationItem.largeTitleDisplayMode = .never
  }
}

extension AppDetailController: ViewModelBased {

  func bindViewModel() {

    let appId = self.appId

    viewWillAppearAction
      .asObservable()
      .map { appId }
      .ignoreNil()
      .bind(to: viewModel.inputs.appId)
      .disposed(by: disposeBag)

    appDetailResultView.rx.didScroll
      .map { [weak self] _ -> CGFloat? in
        self?.appDetailResultView.contentOffset.y
      }
      .bind(to: viewModel.inputs.contentOffsetY)
      .disposed(by: disposeBag)

    viewModel.outputs.lookupViewModel
      .bind(to: appDetailResultView.rx.updateLookupViewModel)
      .disposed(by: disposeBag)

    viewModel.outputs.screenshotViewModels
      .bind(to: appDetailResultView.rx.updateScreenshotViewModels)
      .disposed(by: disposeBag)

    viewModel.outputs.reviewsEntryModels
      .bind(to: appDetailResultView.rx.updateReviewsEntryViewModels)
      .disposed(by: disposeBag)

    viewModel.outputs.appIconPath
      .bind(to: appDetailNavigationItem.titleView.rx.loadImage)
      .disposed(by: disposeBag)

    viewModel.outputs.appPrice
      .bind(to: appDetailNavigationItem.getButton.rx.updateNormalStateTitle)
      .disposed(by: disposeBag)

    viewModel.outputs.visibility
      .bind(to: appDetailNavigationItem.rx.updateAlphaAnimation)
      .disposed(by: disposeBag)

    viewModel.outputs.visibility
      .bind(to: appDetailResultView.rx.showLookupCell)
      .disposed(by: disposeBag)
  }
}
