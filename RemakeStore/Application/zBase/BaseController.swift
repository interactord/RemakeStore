//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow
import RxSwift
import RxCocoa

class BaseController: UIViewController {

  // MARK: - Private

  private var didSetupConstraints = false

  // MARK: - Public

  let disposeBag = DisposeBag()

  // MARK: - Initializing

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigation()
    self.setupViews()
    self.view.setNeedsUpdateConstraints()
    self.view.backgroundColor = .white
  }

  override func updateViewConstraints() {
    if false == self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }

  // MARK: Overriding functions

  func setupViews() {
    /// view.addSubview()
  }

  func setupConstraints() {
    /// Autolayout
  }

  func setupNavigation() {
    /// navigation.title = "TITLE"
  }

}

extension BaseController: Stepper {

  public var steps: PublishRelay<Step> {
    return PublishRelay<Step>()
  }

}
