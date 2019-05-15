//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UICollectionView {

  func register<C: UICollectionViewCell>(cellType: C.Type) where C: CellContentClassIdentifiable {
    register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
  }

  func register<V: UICollectionReusableView>(kind: String, reusableViewType: V.Type) where V: CellContentClassIdentifiable {
    register(reusableViewType.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: reusableViewType.reuseId)
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

  func dequeueReusableCell<V: UICollectionReusableView>(
    with type: V.Type = V.self,
    kind: String,
    indexPath: IndexPath
  ) -> V where V: CellContentClassIdentifiable {
    guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.reuseId, for: indexPath) as? V else {
      fatalError("Couldn't dequeue a UICollectionReusableView with identifier: \(type.reuseId)")
    }
    return view
  }
}
