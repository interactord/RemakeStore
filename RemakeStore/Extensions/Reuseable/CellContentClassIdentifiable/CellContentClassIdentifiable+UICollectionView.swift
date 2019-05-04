//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UICollectionView {

  func register<C: UICollectionViewCell>(cellType: C.Type) where C: CellContentClassIdentifiable {
    register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
  }

  func dequeueReusableCell<C: UICollectionViewCell>(
    with type: C.Type = C.self,
    indexPath: IndexPath
  ) -> C where C: CellContentClassIdentifiable {
    guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? C else {
      fatalError("Couldn't dequeue a UICollectionViewCell with identifier: \(type.reuseId)")
    }
    return cell
  }

}
