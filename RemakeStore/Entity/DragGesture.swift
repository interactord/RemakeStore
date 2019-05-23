//
//  DragGesture.swift
//  RemakeStore
//
//  Created by Scott Moon on 21/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

struct DragGesture {

  // MARK: - Public

  let began: Observable<UIPanGestureRecognizer>
  let moved: Observable<UIPanGestureRecognizer>
  let ended: Observable<UIPanGestureRecognizer>
  var offset: CGFloat

  // MARK: - Private

  private let gesture: Observable<UIPanGestureRecognizer>

  // MARK: - Initializing

  init(withBaseView view: UIView) {
    self.gesture = view.rx.panGesture {
      $1.simultaneousRecognitionPolicy = .always
    }.asObservable()

    self.began = gesture.when(.began)
    self.moved = gesture.when(.changed)
    self.ended = gesture.when(.ended)
    self.offset = 0
  }
}
