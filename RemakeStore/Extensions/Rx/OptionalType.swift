//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import RxSwift

public protocol OptionalType {
  associatedtype Wrapped
  var optional: Wrapped? { get }
}

extension Optional: OptionalType {
  public var optional: Wrapped? {
    return self
  }
}

extension Observable where Element: OptionalType {
  func ignoreNil() -> Observable<Element.Wrapped> {
    return flatMap {
      $0.optional.map {
        Observable<Element.Wrapped>.just($0)
      } ?? Observable<Element.Wrapped>.empty()
    }
  }
}
