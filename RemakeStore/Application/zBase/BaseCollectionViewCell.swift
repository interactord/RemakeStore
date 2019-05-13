//
// Created by Scott Moon on 2019-05-08.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {

  var disposeBag = DisposeBag()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubView()
    setupConstant()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    reset()
    disposeBag = DisposeBag()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
  }

  func setupConstant() {
  }

  func setupSubView() {
  }

  func reset() {
  }
}
