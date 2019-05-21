//
//  FullScreenAnimateusable.swift
//  RemakeStore
//
//  Created by Scott Moon on 21/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SCLayoutKit

enum ScreenStatus {
  case thumbnail
  case fullScreen
}

protocol FullScreenAnimatable where Self: UIViewController {
  var targetFullScreenController: BaseFullScreenAnimatable? { get }
  var fullScreenStatus: ScreenStatus { get }
  func setupFullscreenView(_ targetFullScreenController: BaseFullScreenAnimatable, info: FullScreenAnimatedInfo)
  func startFullScreenAnimation()
}

protocol BaseFullScreenAnimatable where Self: UIViewController {
  var baseView: UIView { get }
  var startingFrame: CGRect? { get set }
  var beginningAnimateConstraints: AnchoredConstraints? { get set }
  func setupFullScreenLayout(startingFrame: CGRect)
  func startFullScreenAnimation()
}
