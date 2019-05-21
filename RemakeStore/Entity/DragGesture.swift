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

  let began: Observable<UIPanGestureRecognizer>
  let moved: Observable<UIPanGestureRecognizer>
  let ended: Observable<UIPanGestureRecognizer>

  private var offset: CGFloat
  private let gesture: Observable<UIPanGestureRecognizer>

  init(withBaseView view: UIView) {
    self.gesture = view.rx.panGesture {
      $1.simultaneousRecognitionPolicy = .never
    }.asObservable()

    self.began = gesture.when(.began)
    self.moved = gesture.when(.changed)
    self.ended = gesture.when(.ended)
    self.offset = 0
  }

  mutating func insertOffset(offset: CGFloat) {
    self.offset = offset
  }

  func getOffset() -> CGFloat {
    return self.offset
  }
}
