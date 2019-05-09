//
//  SearchRegultView.swift
//  RemakeStore
//
//  Created by Scott Moon on 08/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class SearchResultView: BaseCollectionView {

  override func setupDelegate() {
    super.setupDelegate()
    self.dataSource = self
    self.delegate = self
  }

  override func registerCell() {
    super.registerCell()
    self.register(cellType: SearchResultCell.self)
  }
}

// MARK: - UICollectionViewDataSource

extension SearchResultView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 30
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: SearchResultCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchResultView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = frame.width
    return .init(width: width, height: 350)
  }
}
