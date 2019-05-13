//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class AppsHorizontalListView: BaseCollectionView {

  private let topButtomPadding: CGFloat = 12
  private let lineSpacing: CGFloat = 10

  override func setupView() {
    super.setupView()
    backgroundColor = .white
    contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  }

  override func setupDelegate() {
    super.setupDelegate()
    self.dataSource = self
    self.delegate = self
  }

  override func registerCell() {
    super.registerCell()

    register(cellType: AppRowCell.self)
  }
}

// MARK: - UICollectionViewDataSource

extension AppsHorizontalListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: AppRowCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    cell.backgroundColor = .cyan
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppsHorizontalListView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = frame.height.divider(padding: topButtomPadding, lineSpacing: lineSpacing, divider: 3)
    return .init(width: frame.width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topButtomPadding, left: 0, bottom: topButtomPadding, right: 0)
  }
}
