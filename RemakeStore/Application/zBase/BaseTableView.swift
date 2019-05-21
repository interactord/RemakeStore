//
// Created by Scott Moon on 2019-05-22.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

class BaseTableView: UITableView {

  // MARK: Public

  // MARK: Private

  private(set) lazy var disposeBag = DisposeBag()

  // MARK: Initializing
  convenience init() {
    self.init()
    loadView()
  }

  deinit {
    print("\(type(of: self)): \(#function)")
  }

  private func loadView() {
    setupView()
    registerCell()
    setupDelegate()
  }

  func setupDelegate() {
  }

  func registerCell() {
  }

  func setupView() {
    self.backgroundColor = .white
  }

}
