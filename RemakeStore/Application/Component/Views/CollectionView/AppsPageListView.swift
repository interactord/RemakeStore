//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class AppsPageListView: BaseCollectionView {

  private let cellHeight: CGFloat = 300
  private let padding = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)

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
    register(kind: UICollectionView.elementKindSectionHeader, reusableViewType: AppsPageHeader.self)
  }
}

// MARK: - UICollectionViewDataSource

extension AppsPageListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: AppsGroupCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header: AppsPageHeader = collectionView.dequeueReusableCell(kind: kind, indexPath: indexPath)
    header.backgroundColor = .red
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
