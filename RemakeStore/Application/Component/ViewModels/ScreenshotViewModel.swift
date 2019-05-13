//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol ScreenshotViewModelOutput {
  var screenshot: Observable<String> { get }
}

protocol ScreenshotViewModeling {
  var outputs: ScreenshotViewModelOutput { get }
}

protocol ScreenshotViewModelBindable {
  func bind(to viewModel: ScreenshotViewModeling)
}

typealias ScreenshotViewModelType =
  ScreenshotViewModelOutput & ScreenshotViewModeling

class ScreenshotViewModel: ScreenshotViewModelType {

  // MARK: - Outputs

  var outputs: ScreenshotViewModelOutput {
    return self
  }

  // MARK: - Outputs

  var screenshot: Observable<String>

  // MARK: - Initializing

  init(withScreenshot screenshotUrl: String) {
    self.screenshot = Observable.just(screenshotUrl).observeOn(MainScheduler.asyncInstance)
  }

}
