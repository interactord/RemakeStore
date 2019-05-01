//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

final class URLSessionNetworkAdapter {

  // MARK: - Private

  private let networkActivity: NetworkActivity
  private let session: URLSession

  // MARK: - Initializing

  init(networkActivity: NetworkActivity, session: URLSession) {
    self.networkActivity = networkActivity
    self.session = session
  }

  deinit {
    print("\(type(of: self)): \(#function)")
  }

}

extension URLSessionNetworkAdapter: NetworkAdapter {
  func rx_send(request: URLRequest) -> Observable<Response> {
    networkActivity.show()

    return Observable.create { [weak self] observer in
      var didHideNetworkActivity = false

      let task = self?.session.dataTask(with: request) { data, response, err in
        didHideNetworkActivity = true
        self?.networkActivity.hide()

        if let err = err {
          observer.onError(NetworkError(error: err))
          observer.onCompleted()
          return
        }

        observer.onNext(AppResponse(request: request, data: data, httpResponse: response, error: err))
        observer.onCompleted()
      }

      task?.resume()

      return Disposables.create {
        if didHideNetworkActivity == false {
          self?.networkActivity.hide()
        }
        task?.cancel()
      }
    }
  }
}
