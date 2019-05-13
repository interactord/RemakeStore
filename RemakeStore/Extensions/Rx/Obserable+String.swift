//
// Created by Scott Moon on 2019-05-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

extension Observable where Element == String {
  func ignoreEmpty() -> Observable<String> {
    return flatMap {
      $0.isEmpty
        ? Observable.empty()
        : Observable.just($0)
    }
  }
}
