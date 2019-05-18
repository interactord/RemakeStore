//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UIView {
	func animated(transform: CGAffineTransform) {
		UIView.animate(
			withDuration: 0.5,
			delay: 0,
			usingSpringWithDamping: 1,
			initialSpringVelocity: 1,
			options: .curveEaseOut,
			animations: {
				self.transform = transform
			}
		)
	}
}