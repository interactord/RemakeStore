//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

@testable import RemakeStore

class ViewModelBasedCollectionViewCellMock: UICollectionViewCell, ViewModelBased {

  var viewModel: ServiceViewModelMock!

  func bindViewModel() {
  }
}
