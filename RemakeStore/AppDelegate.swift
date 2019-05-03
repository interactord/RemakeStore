//
//  Created by Scott Moon on 01/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCServiceKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  lazy var rootFlow = RootFlow()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow()

    guard let window = window else {
      return false
    }

    rootFlow.onDebugNavigate()
    rootFlow.start(with: window)

    return true
  }

}
