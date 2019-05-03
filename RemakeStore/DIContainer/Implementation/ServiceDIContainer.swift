//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject
import SCServiceKit

struct ServiceDIContainer: DIContainer {
  var container: Container

  private lazy var networkActivity: NetworkActivity = {
    container.register(NetworkActivity.self) { _ in
      UIApplicationNetworkActivity(application: UIApplication.shared)
    }.inObjectScope(.container)

    guard let networkActivity = self.container.resolve(NetworkActivity.self) else {
      fatalError("Should be not nil")
    }
    return networkActivity
  }()

  private lazy var translator: Translator = {
    container.register(Translator.self) { _ in
      NSLocalizedStringTranslator()
    }.inObjectScope(.container)

    guard let translator = self.container.resolve(Translator.self) else {
      fatalError("Should be not nil")
    }
    return translator
  }()

  private lazy var logger: Logger = {
    let envUrl = Bundle.main.url(forResource: "env", withExtension: "plist")
    var envConfigModel: EnvConfigModel? = PropertyListDecoder().deserialize(with: envUrl)

    container.register(Logger.self) { _ in
      AppLogger(with: envConfigModel?.logger)
    }.inObjectScope(.container)

    guard let logger = self.container.resolve(Logger.self) else {
      fatalError("Should be not nil")
    }
    return logger
  }()

  private lazy var networkAdapter: NetworkAdapter = {
    let networkActivity = self.networkActivity
    container.register(NetworkAdapter.self) { _ in
      URLSessionNetworkAdapter(
        networkActivity: networkActivity,
        session: URLSession(configuration: .ephemeral)
      )
    }.inObjectScope(.container)

    guard let networkAdapter = self.container.resolve(NetworkAdapter.self) else {
      fatalError("Should be not nil")
    }
    return networkAdapter
  }()

  private lazy var interceptorChain: InterceptorChain<URLRequest> = {
    let loggerInterceptor = LoggerInterceptorURLRequest(logger: self.logger)
    container.register(InterceptorChain<URLRequest>.self) { _ -> InterceptorChain<URLRequest> in
      let anyInterceptor = AnyInterceptor(base: loggerInterceptor)
      return InterceptorChain<URLRequest>()
        .add(interceptor: anyInterceptor)
    }.inObjectScope(.container)

    guard let interceptorChain = container.resolve(InterceptorChain<URLRequest>.self) else {
      fatalError("Should be not nil")
    }
    return interceptorChain
  }()

  private lazy var httpClient: HTTPClient = {

    let networkAdapter = self.networkAdapter
    let interceptorChain = self.interceptorChain

    container.register(HTTPClient.self) { _ in
      AppHTTPClient(
        transformer: AnyTransformer(base: EndPointToURLRequestTransformer()),
        networkAdapter: networkAdapter,
        requestChain: interceptorChain,
        responseChain: InterceptorChain<Response>(),
        httpErrorHandler: AppHTTPErrorHandler()
      )
    }

    guard let httpClient = container.resolve(HTTPClient.self) else {
      fatalError("Should be not nil")
    }
    return httpClient
  }()

  // MARK: - Public

  lazy var service: Service = {

    let logger = self.logger
    let translator = self.translator
    let httpClient = self.httpClient

    container.register(Service.self) { _ in
      AppService(
        httpClient: httpClient,
        translator: translator,
        logger: logger
      )
    }

    guard let service = container.resolve(Service.self) else {
      fatalError("Should be not nil")
    }
    return service
  }()

  // MARK: - Initializing

  init() {
    self.container = Container()
  }
}
