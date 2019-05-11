//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import Swifter

class StubServer {

  // MARK: - Private

  private let server = HttpServer()

  // MARK: Public

  func setup() {
    stubSetup()
    do {
      _ = try server.start(7_000)
    } catch {
      fatalError(error.localizedDescription)
    }
  }

  func tearDown() {
    server.stop()
  }
}

extension StubServer {

  // MARK: - Private

  private func stubSetup() {
    setSearchManyObject()
  }

  private func setSearchManyObject() {
    let urlPath = "search?term=facebook&entity=software"
    let response: ((HttpRequest) -> HttpResponse) = { _ in

      guard
        let url = Bundle.main.url(forResource: "searchDummy", withExtension: "json"),
        let data = try? Data(contentsOf: url)
        else {
          fatalError("Should be not nil")
      }

      return HttpResponse.ok(.data(data))
    }

    server.GET[urlPath] = response
  }

}
