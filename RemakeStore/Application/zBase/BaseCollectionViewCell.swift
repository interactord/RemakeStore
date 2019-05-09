//
// Created by Scott Moon on 2019-05-08.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubView()
		setupConstant()
	}

  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
  }

	func setupConstant() {
	}

	func setupSubView() {
	}
}
