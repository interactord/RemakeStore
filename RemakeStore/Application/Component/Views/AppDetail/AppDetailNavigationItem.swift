//
//  AppDetailNavigationItem.swift
//  RemakeStore
//
//  Created by Scott Moon on 26/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit
import RxSwift
import RxCocoa

class AppDetailNavigationItem: NSObject {

  let itemTag: Int = 1_000

  private(set) lazy var titleView: UIImageView = {
    return ImageViewBuilder()
      .setContentMode(.scaleAspectFit)
      .setClipToBounds(true)
      .setBackgroundColor(.red)
      .setBorderColor(DefaultTheme.Color.lightGrayColor.cgColor)
      .setBorderWidth(0.5)
      .setCornerRadius(5)
      .setWidthAnchor(28)
      .setHeightAnchor(28)
      .setTag(itemTag)
      .setAlpha(0.0)
      .build()
  }()

  private(set) lazy var getButton: UIButton = {
    let button = ButtonBuilder()
      .setTitle("GET")
      .setTitleColor(.white)
      .setBackgroundColor(DefaultTheme.Color.primaryColor)
      .setCornerRadius(14)
      .setContentEdgeInsets(.init(top: 0, left: 16, bottom: 0, right: 16))
      .setFont(DefaultTheme.Font.bodyBold)
      .setHeightAnchor(28)
      .setTag(itemTag)
      .setAlpha(0.0)
      .build()

    return button
  }()

  func insertRIghtBarItem(from navigationController: UINavigationController?) {
    guard let navigationBar = navigationController?.navigationBar else {
      return
    }

    navigationBar.subviews.forEach {
      if $0.tag == itemTag {
        return
      }
    }

    navigationBar.addSubview(getButton)
    getButton
      .setTrailingAnchor(navigationBar.trailingAnchor, padding: 12)
      .setBottomAnchor(navigationBar.bottomAnchor, padding: 12)

    navigationBar.addSubview(titleView)
    titleView
      .setCenterXAnchor(navigationBar.centerXAnchor)
      .setBottomAnchor(navigationBar.bottomAnchor, padding: 12)

  }

  func remoteRIghtBarItem(form navigationController: UINavigationController?) {
    guard let navigationBar = navigationController?.navigationBar else {
      return
    }
    UIView.animate(withDuration: 0.2, animations: {
      self.titleView.alpha = 0.0
      self.getButton.alpha = 0.0
    }, completion: { _ in
      navigationBar.subviews.forEach {
        if $0.tag == self.itemTag {
          $0.removeFromSuperview()
        }
      }
    })
  }

  func showItem(show: Bool) {
    UIView.animate(withDuration: 0.2) {
      self.titleView.alpha = show ? 1.0 : 0.0
      self.getButton.alpha = show ? 1.0 : 0.0
    }
  }
}

extension Reactive where Base: AppDetailNavigationItem {
  internal var updateAlphaAnimation: Binder<Bool> {
    return Binder(self.base) { base, result in
      base.showItem(show: result)
    }
  }
}
