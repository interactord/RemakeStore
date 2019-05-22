//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit
import RxGesture
import RxSwift
import RxCocoa

class TodayDetailController: BaseController {

  // MARK: Public
  var viewModel: TodayDetailViewModel!
  var startingFrame: CGRect?
  var beginningAnimateConstraints: AnchoredConstraints?
  var beginningOffset: CGFloat = 0

  lazy var dismissButton: UIButton = {
    return ButtonBuilder(type: .custom)
      .setImage(#imageLiteral(resourceName: "Close-button"))
      .setImage(#imageLiteral(resourceName: "Close-button").transformedAlpha(0.5), state: .highlighted)
      .setWidthAnchor(44)
      .setHeightAnchor(44)
      .build()
  }()

  lazy var dragGesture: DragGesture = {
    return DragGesture(withBaseView: self.view)
  }()

  // MARK: - Private

  private(set) lazy var detailListView = TodayDetailListView()

  override func setupViews() {
    super.setupViews()
    view.clipsToBounds = true
    view.addSubview(detailListView)
    view.addSubview(dismissButton)
  }

  override func setupConstraints() {
    super.setupConstraints()

    detailListView.fillSuperView()
    dismissButton
      .setTopAnchor(view.topAnchor, padding: 15)
      .setTrailingAnchor(view.trailingAnchor, padding: 15)
  }

  deinit {
    print("\(type(of: self)): \(#function)")
  }
}

extension TodayDetailController: FullScreenViewControllerAnimatable {

  func setupFullScreenLayout(startingFrame: CGRect) {
    self.startingFrame = startingFrame
    self.beginningAnimateConstraints = view.anchor(
      top: view.superview?.topAnchor,
      leading: view.superview?.leadingAnchor,
      bottom: nil,
      trailing: nil,
      padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0),
      size: startingFrame.size
    )
    self.view.layoutIfNeeded()

  }

  func startFullScreenAnimation() {

    guard let superView = self.view.superview else {
      return
    }
    self.view.layer.cornerRadius = 16

    if let fullScreenHeaderCell = self.detailListView.cellForItem(at: [0, 0]) as? FullScreenLayoutCellAnimatedable {
      self.detailListView.startAnimation(cell: fullScreenHeaderCell)
    }

    UIView.defaultAnimated(
      animations: {
        self.view.layer.cornerRadius = 0
        self.beginningAnimateConstraints?.top?.constant = 0
        self.beginningAnimateConstraints?.leading?.constant = 0
        self.beginningAnimateConstraints?.width?.constant = superView.frame.width
        self.beginningAnimateConstraints?.height?.constant = superView.frame.height
        self.view.layoutIfNeeded()
      },
      completion: {
        if !$0 { return }
        self.startDragGesture()
      })
  }

  func dismissFullScreenAnimation() {
    guard let startingFrame = self.startingFrame else {
      return
    }

    if let fullScreenHeaderCell = self.detailListView.cellForItem(at: [0, 0]) as? FullScreenLayoutCellAnimatedable {
      self.detailListView.dismissAnimation(cell: fullScreenHeaderCell, startingFrame: startingFrame)
    }

    UIView.defaultAnimated(
      animations: {
        self.view.layer.cornerRadius = 16
        self.view.transform = .identity
        self.beginningAnimateConstraints?.top?.constant = startingFrame.origin.y
        self.beginningAnimateConstraints?.leading?.constant = startingFrame.origin.x
        self.beginningAnimateConstraints?.width?.constant = startingFrame.width
        self.beginningAnimateConstraints?.height?.constant = startingFrame.height
        self.dismissButton.alpha = 0
        self.view.layoutIfNeeded()
      })
  }
}

extension TodayDetailController: FullScreenDragAnimateable {
  func startDragGesture() {
    var dragGesture = self.dragGesture
    let baseView = self.view
    let contentOffsetY = self.detailListView.contentOffset.y

    dragGesture.began
      .map { _ in
        dragGesture.insertOffset(offset: contentOffsetY)
      }.subscribe().disposed(by: disposeBag)

    dragGesture.moved
      .map { $0.translation(in: baseView).y.convertDragScaleTranform(withOffset: dragGesture.getOffset()) }
      .ignoreNil()
      .map { baseView?.transform = $0 }
      .subscribe().disposed(by: disposeBag)

    dragGesture.ended
      .filter { $0.translation(in: baseView).y > 0 }
      .map { _ in AppStep.todayDetailIsComplete }
      .bind(to: steps)
      .disposed(by: disposeBag)
  }
}

extension TodayDetailController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    dismissButton.rx.tap
      .map { AppStep.todayDetailIsComplete }
      .bind(to: steps)
      .disposed(by: disposeBag)

    viewModel.outputs.todayItemViewModel
      .asDriverJustComplete()
      .drive(detailListView.rx.updateHeaderViewModel)
      .disposed(by: disposeBag)
  }
}
