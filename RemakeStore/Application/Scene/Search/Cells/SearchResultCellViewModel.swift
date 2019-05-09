//
//  SearchResultCellViewModel.swift
//  RemakeStore
//
//  Created by Scott Moon on 09/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

class SearchResultCellViewModel {

  private let appInfo: SearchResult.AppInformation
  let appInfomation: Observable<SearchResult.AppInformation>

  init(withResult result: SearchResult.AppInformation) {
    self.appInfomation = Observable.just(result).observeOn(MainScheduler.asyncInstance)
    self.appInfo = result
  }

  lazy var appId: Int = {
    self.appInfo.trackId
  }()
}
