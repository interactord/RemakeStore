//
//  SearchRegultView.swift
//  RemakeStore
//
//  Created by Scott Moon on 08/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class SearchResultView: BaseCollectionView {

  // MARK: Public

  var items: [SearchResultCellViewModel]?

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
    return items?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: SearchResultCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    if let viewModel = items?[indexPath.item] {
      cell.bind(to: viewModel)
    }
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

extension Reactive where Base: SearchResultView {
  internal var updateItems: Binder<[SearchResultCellViewModel]> {
    return Binder(self.base) { base, result in
      base.items = result
      base.reloadData()
    }
  }
}
