//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UINavigationController {
  func makeTabBarStyle(with title: String, imageName: String) {
    self.navigationBar.prefersLargeTitles = true
    self.view.backgroundColor = .white
    self.tabBarItem.title = title
    self.tabBarItem.image = UIImage(named: imageName)
  }

  func cleanStyleTheme() {
    let image = UIImage()
    self.navigationBar.shadowImage = image
    self.navigationBar.isTranslucent = false
    self.navigationBar.backgroundColor = .white
    self.navigationBar.barTintColor = .white
  }
}
