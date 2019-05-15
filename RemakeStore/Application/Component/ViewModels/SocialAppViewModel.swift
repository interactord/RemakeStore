//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol SocialAppViewModelOutput {
  var name: Observable<String> { get }
  var imageUrlPath: Observable<String> { get }
  var tagLine: Observable<String> { get }
}

protocol SocialAppViewModeling {
  var outputs: SocialAppViewModelOutput { get }
}

protocol SocialAppViewModelBindable {
  func bind(to viewModel: SocialAppViewModeling)
}

typealias SocialAppViewModelType =
  SocialAppViewModelOutput & SocialAppViewModeling

class SocialAppViewModel: SocialAppViewModelType {

  // MARK: - Inputs & Outputs

  var outputs: SocialAppViewModelOutput {
    return self
  }

  // MARK: - Outputs
  private(set) var name: Observable<String>
  private(set) var imageUrlPath: Observable<String>
  private(set) var tagLine: Observable<String>

  init(withSocialApp socialApp: SocialApp) {
    let socialAppAction = Observable.just(socialApp).observeOn(MainScheduler.asyncInstance)

    name = socialAppAction.map { $0.name }
    imageUrlPath = socialAppAction.map { $0.imageUrl }
    tagLine = socialAppAction.map { $0.tagLine }
  }
}
