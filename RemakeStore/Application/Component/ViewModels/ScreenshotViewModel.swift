//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol ScreenshotViewModelInput {
}

protocol ScreenshotViewModelOutput {
  var screenshot: Observable<String> { get }
}

protocol ScreenshotViewModeling {
  var inputs: ScreenshotViewModelInput { get }
  var outputs: ScreenshotViewModelOutput { get }
}

protocol ScreenshotViewModelBindable {
  func bind(to viewModel: ScreenshotViewModeling)
}

typealias ScreenshotViewModelType =
  ScreenshotViewModelInput & ScreenshotViewModelOutput & ScreenshotViewModeling

class ScreenshotViewModel: ScreenshotViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: ScreenshotViewModelInput {
    return self
  }

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
