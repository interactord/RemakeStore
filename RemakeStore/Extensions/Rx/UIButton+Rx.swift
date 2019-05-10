//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {

  internal var updateNormalStateTitle: Binder<String> {
    return Binder(self.base) { base, result in
      base.setTitle(result, for: .normal)
    }
  }

}
