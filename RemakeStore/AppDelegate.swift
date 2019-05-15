//
//  Created by Scott Moon on 01/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCServiceKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var rootFlow: RootFlow?
  var serviceDIContainer: ServiceDIContainer?
  var isUnitTesting: Bool {
    return ProcessInfo.processInfo.environment["UNITTEST"] == "1"
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow()

    guard let window = window else {
      return false
    }

    if false == isUnitTesting {
      serviceDIContainer = ServiceDIContainer()

      guard let service = serviceDIContainer?.service else {
        fatalError("Should not be nil")
      }

      rootFlow = RootFlow(with: service)
      rootFlow?.onDebugNavigate()
      rootFlow?.start(with: window)
    }
    return true
  }

}
