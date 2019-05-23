//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UICollectionView {

  func register<C: UICollectionViewCell>(cellType: C.Type) where C: CellContentClassIdentifiable {
    register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
  }

  func register<C: UICollectionViewCell>(kind: String, cellType: C.Type) where C: CellContentClassIdentifiable {
    register(cellType.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellType.reuseId)
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

  func dequeueReusableCell<C: UICollectionViewCell>(
    with type: C.Type = C.self,
    kind: String,
    indexPath: IndexPath
  ) -> C where C: CellContentClassIdentifiable {
    guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.reuseId, for: indexPath) as? C else {
      fatalError("Couldn't dequeue a UICollectionReusableView with identifier: \(type.reuseId)")
    }
    return view
  }
}
