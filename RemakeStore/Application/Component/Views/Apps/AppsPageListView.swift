//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxFlow

class AppsPageListView: BaseCollectionView {

  // MARK: - Private

  private let cellHeight: CGFloat = 300
  private let padding = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)

  // MARK: Public

  var feedViewModels: [FeedViewModeling]?
  var socialAppViewModels: [SocialAppViewModeling]?
  var rootStepper: PublishRelay<Step>?

  override func setupView() {
    super.setupView()
    backgroundColor = .white
  }

  override func setupDelegate() {
    super.setupDelegate()
    self.dataSource = self
    self.delegate = self
  }

  override func registerCell() {
    super.registerCell()

    register(cellType: AppsGroupCell.self)
    register(kind: UICollectionView.elementKindSectionHeader, cellType: AppsPageHeader.self)
  }
}

// MARK: - UICollectionViewDataSource

extension AppsPageListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return feedViewModels?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: AppsGroupCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    if let viewModel = feedViewModels?[indexPath.item] {
      cell.bind(to: viewModel)
    }
    if let stepper = rootStepper {
      cell.bind(to: stepper)
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header: AppsPageHeader = collectionView.dequeueReusableCell(kind: kind, indexPath: indexPath)
    if let viewModel = socialAppViewModels {
      header.bind(to: viewModel)
    }
    return header
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppsPageListView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: frame.width, height: cellHeight)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: frame.width, height: cellHeight)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return padding
  }
}

extension AppsPageListView: RootStepperBindable {
  func bind(to stepper: PublishRelay<Step>) {
    self.rootStepper = stepper
    reloadData()
  }
}

// MARK: - RX Binder

extension Reactive where Base: AppsPageListView {
  internal var updateFeedViewModels: Binder<[FeedViewModeling]> {
    return Binder(self.base) { base, result in
      base.feedViewModels = result
      base.reloadData()
    }
  }

  internal var updateSocialAppViewModels: Binder<[SocialAppViewModeling]> {
    return Binder(self.base) { base, result in
      base.socialAppViewModels = result
      base.reloadData()
    }
  }
}
