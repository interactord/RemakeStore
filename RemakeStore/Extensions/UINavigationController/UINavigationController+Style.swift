//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UINavigationController {
  func makeTabBarStyle(with title: String, imageName: String) {
    self.navigationBar.prefersLargeTitles = true
    self.view.backgroundColor = .white
    self.viewControllers.first?.title = title
    self.tabBarItem.title = title
    self.tabBarItem.image = UIImage(named: imageName)
  }
}
