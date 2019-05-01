//
//  Created by Scott Moon on 01/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation
import Swifter

struct StubServerInfo {
  let url, htmlString: String
}

class StubServer {

  // MARK: - Private

  private let server = HttpServer()

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

  func getUrl() -> String {
    return "http://localhost:7000"
  }

  func getLogin() -> URL {
    guard let url = URL(string: getUrl() + "/login") else {
      fatalError("Should be not nil")
    }
    return url
  }

  func getDefault() -> URL {
    guard let url = URL(string: getUrl() + "/default") else {
      fatalError("Should be not nil")
    }
    return url
  }

  func getUpdate() -> URL {
    guard let url = URL(string: getUrl() + "/update") else {
      fatalError("Should be not nil")
    }
    return url
  }

  func getNotFoundURL() -> URL {
    guard let url = URL(string: getUrl() + "/notFound") else {
      fatalError("Should be not nil")
    }
    return url
  }

}

extension StubServer {

  private func stubSetup() {

    let successResponse: ((HttpRequest) -> HttpResponse) = { _ in
      return HttpResponse.ok(.data(self.getTestMockData()))
    }

    let successNoContentResponse: ((HttpRequest) -> HttpResponse) = { _ in
      return HttpResponse.created
    }

    let notFoundResponse: ((HttpRequest) -> HttpResponse) = { _ in
      return HttpResponse.notFound
    }

    let notMatedSuccessResponse: ((HttpRequest) -> HttpResponse) = { _ in
      return HttpResponse.ok(.data(self.getTestMockErrorData()))
    }

    server.GET["/default"] = successResponse
    server.PUT["/default"] = successNoContentResponse
    server.DELETE["/default"] = notFoundResponse
    server.POST["/default"] = notMatedSuccessResponse
    server.PATCH["/default"] = successNoContentResponse

    let failResponse: ((HttpRequest) -> HttpResponse) = { _ in
      return HttpResponse.unauthorized
    }
    server.GET["/login"] = failResponse

    let noContentResponse: ((HttpRequest) -> HttpResponse) = { _ in
      return HttpResponse.created
    }
    server.PUT["/update"] = noContentResponse

  }

  private func getTestMockData() -> Data {
    guard let data = "{\"args\":{\"name\": \"test name\", \"surname\": \"test surname\", \"age\": \"34\"}}".data(using: .utf8) else {
      fatalError("Should be not nil")
    }
    return data
  }

  private func getTestMockErrorData() -> Data {
    guard let data = "{\"arg\":{\"name\": \"test\", \"surname\": \"test surname\", \"age\": \"34\"}}".data(using: .utf8) else {
      fatalError("Should be not nil")
    }
    return data
  }

}
