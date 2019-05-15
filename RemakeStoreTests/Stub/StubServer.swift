//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import Swifter

@testable import RemakeStore

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
    setSearcht()
    setLookup()
    setReviews()
    setApps()
    setSocialApps()
  }

  private func setSearcht() {
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

  private func setLookup() {
    let urlPath = "lookup?id=1209489068"
    let response: ((HttpRequest) -> HttpResponse) = { _ in

      guard
        let url = Bundle.main.url(forResource: "lookupDummy", withExtension: "json"),
        let data = try? Data(contentsOf: url)
        else {
        fatalError("Should be not nil")
      }

      return HttpResponse.ok(.data(data))
    }

    server.GET[urlPath] = response
  }

  private func setReviews() {
    let urlPath = "rss/customerreviews/page=1/id=1209489068/sortby=mostrecent/json?l=en&cc=us"
    let response: ((HttpRequest) -> HttpResponse) = { _ in

      guard
        let url = Bundle.main.url(forResource: "reviewsDummy", withExtension: "json"),
        let data = try? Data(contentsOf: url)
        else {
        fatalError("Should be not nil")
      }

      return HttpResponse.ok(.data(data))
    }

    server.GET[urlPath] = response
  }

  private func setApps() {
     let response: ((HttpRequest) -> HttpResponse) = { _ in

      guard
        let url = Bundle.main.url(forResource: "explicitDummy", withExtension: "json"),
        let data = try? Data(contentsOf: url)
        else {
        fatalError("Should be not nil")
      }

      return HttpResponse.ok(.data(data))
    }

    server.GET[RssEndpointRouter.newGames.rawValue] = response
    server.GET[RssEndpointRouter.topGrossing.rawValue] = response
    server.GET[RssEndpointRouter.topFree.rawValue] = response
  }

  private func setSocialApps() {
     let response: ((HttpRequest) -> HttpResponse) = { _ in

      guard
        let url = Bundle.main.url(forResource: "appHeadBannerDummy", withExtension: "json"),
        let data = try? Data(contentsOf: url)
        else {
        fatalError("Should be not nil")
      }

      return HttpResponse.ok(.data(data))
    }

    server.GET[InteractordEndpointRouter.socialApps.rawValue] = response
  }

}
