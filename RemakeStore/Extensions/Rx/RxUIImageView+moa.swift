//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
	internal var loadImage: Binder<String> {
		return Binder(self.base) { base, result in
			base.moa.url = result
		}
	}
}
