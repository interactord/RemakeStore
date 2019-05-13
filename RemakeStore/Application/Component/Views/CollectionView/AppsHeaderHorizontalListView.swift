//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalListView: BaseCollectionView {

  private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  private let cellSpacing: CGFloat = 48

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
    self.register(cellType: AppsHeaderCell.self)
  }
}

// MARK: - UICollectionViewDataSource

extension AppsHeaderHorizontalListView: UICollectionViewDataSource {

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: AppsHeaderCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    cell.backgroundColor = .yellow
    return cell
  }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppsHeaderHorizontalListView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return padding
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: frame.width - cellSpacing, height: frame.height)
  }
}
