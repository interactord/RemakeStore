//
// Created by Scott Moon on 2019-05-07.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

class BaseCollectionView: UICollectionView {

  lazy private(set) public var disposeBag = DisposeBag()

  // MARK: - Initializing

  convenience init() {
    let layout = UICollectionViewFlowLayout()
    self.init(frame: .zero, collectionViewLayout: layout)
    setupView()
    registerCell()
    setupDelegate()
  }

  deinit {
    print("\(type(of: self)): \(#function)")
  }

  func setupDelegate() { }

  func registerCell() { }

  func setupView() {
    self.backgroundColor = .white
  }
}
