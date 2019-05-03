//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

final class AnyRepository<T> {

  // MARK: - Private

  private let _create: (RepositoryParameter?) -> Observable<ResultContent<T>>
  private let _read: (RepositoryParameter?) -> Observable<ResultContent<T>>
  private let _update: (RepositoryParameter?) -> Observable<ResultContent<T>>
  private let _delete: (RepositoryParameter?) -> Observable<ResultContent<T>>

  // MARK: - Initializing
  init<R: Repository>(base: R) where R.Resource == T {
    _create = base.create
    _read = base.read
    _update = base.update
    _delete = base.delete
  }
}

extension AnyRepository: Repository {

  // MARK: - functions for protocol

  func create(with parameter: RepositoryParameter?) -> Observable<ResultContent<T>> {
    return _create(checkParameter(parameter))
  }

  func read(with parameter: RepositoryParameter?) -> Observable<ResultContent<T>> {
    return _read(checkParameter(parameter))
  }

  func update(with parameter: RepositoryParameter?) -> Observable<ResultContent<T>> {
    return _update(checkParameter(parameter))
  }

  func delete(with parameter: RepositoryParameter?) -> Observable<ResultContent<T>> {
    return _delete(checkParameter(parameter))
  }

  private func checkParameter(_ parameter: RepositoryParameter?) -> RepositoryParameter {
    if let parameter = parameter {
      return parameter
    }
    return NoRepositoryParameter()
  }

}
