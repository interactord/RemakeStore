//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit
import RxCocoa
import RxSwift
import RxFlow

protocol TodayMultipleAppListViewBinadle {
  func bind(to rootStepper: PublishRelay<Step>)
}

class TodayMultipleAppListView: BaseCollectionView {

  // MARK: - Public

  enum Mode {
    case thumbnail
    case fullScreen
  }

  var mode: Mode = .thumbnail
  var feedResultViewModels: [FeedResultViewModeling]?

  // MARK: - Private

  private let cellSpacing: CGFloat = 12
  private let cellHeight: CGFloat = 68
  private let fullScreenCellPadding: CGFloat = 48
  private let fullScreenContentPadding: UIEdgeInsets = .init(top: 12, left: 24, bottom: 12, right: 24)
  private var rootStepper: PublishRelay<Step>?

  override func setupView() {
    super.setupView()
    showsVerticalScrollIndicator = false
  }

  override func setupDelegate() {
    super.setupDelegate()
    self.dataSource = self
    self.delegate = self
  }

  override func registerCell() {
    super.registerCell()
    register(cellType: MultipleAppCell.self)
  }

  func changed(to mode: Mode) {
    self.mode = mode
    switch mode {
    case .thumbnail:
      isUserInteractionEnabled = false
    case .fullScreen:
      isUserInteractionEnabled = true
    }
    reloadData()
  }
}

extension TodayMultipleAppListView: TodayMultipleAppListViewBinadle {
  func bind(to rootStepper: PublishRelay<Step>) {
    self.rootStepper = rootStepper
    self.reloadData()
  }
}

// MARK: - UICollectionViewDataSource

extension TodayMultipleAppListView: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let count = feedResultViewModels?.count ?? 0
    switch mode {
    case .thumbnail:
      return min(4, count)
    case .fullScreen:
      return count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MultipleAppCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    if let viewModel = feedResultViewModels?[indexPath.item] {
      cell.bind(to: viewModel)
    }
    return cell
  }
}

extension TodayMultipleAppListView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: frame.width, height: cellHeight)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
}

// MARK: - RX Binder

extension Reactive where Base: TodayMultipleAppListView {
  internal var updateFeedResultViewModels: Binder<[FeedResultViewModeling]> {
    return Binder(self.base) { base, result in
      base.feedResultViewModels = result
      base.reloadData()
    }
  }
}
