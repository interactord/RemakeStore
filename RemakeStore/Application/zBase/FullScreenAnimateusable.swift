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

protocol FullScreenAnimatable {
  var blurVisualEffectView: UIVisualEffectView { get }
  var targetFullScreenController: FullScreenViewControllerAnimatable? { get }
  var fullScreenStatus: ScreenStatus { get }
  func setupFullscreenView(_ targetFullScreenController: FullScreenViewControllerAnimatable, info: FullScreenAnimatedInfo)
  func startFullScreenAnimation()
  func dismissFullScreenAnimation()
}

protocol FullScreenViewControllerAnimatable where Self: UIViewController {
  var view: UIView! { get }
  var startingFrame: CGRect? { get set }
  var beginningAnimateConstraints: AnchoredConstraints? { get set }
  func setupFullScreenLayout(startingFrame: CGRect)
  func startFullScreenAnimation()
  func dismissFullScreenAnimation()
}

protocol FullScreenDragAnimateable where Self: FullScreenViewControllerAnimatable {
  var dragGesture: DragGesture { get }
  func startDragGesture()
}

protocol FullScreenLayoutCellAnimatedable where Self: UICollectionViewCell {
  var thumbnailHeight: CGFloat { get }
  var fullScreenHeight: CGFloat { get }
  var topConstraint: NSLayoutConstraint! { get }
  var thumbnailPaddingTop: CGFloat { get }
  var fullScreenPaddingTop: CGFloat { get }
}

protocol FullScreenLayoutCollectionViewAnimatedable where Self: UICollectionView {
  func startAnimation(cell: FullScreenLayoutCellAnimatedable)
  func dismissAnimation(cell: FullScreenLayoutCellAnimatedable, startingFrame: CGRect)
}
