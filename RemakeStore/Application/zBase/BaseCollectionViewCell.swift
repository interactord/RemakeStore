//
// Created by Scott Moon on 2019-05-08.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {

  var disposeBag = DisposeBag()

  convenience init() {
    self.init(frame: .zero)
    setupSubView()
    setupConstant()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    reset()
    disposeBag = DisposeBag()
  }

  func setupConstant() {
  }

  func setupSubView() {
  }

  func reset() {
  }
}
