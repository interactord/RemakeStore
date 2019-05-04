//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UITableView {

  func register<C: UITableViewCell>(cellType: C.Type) where C: CellContentClassIdentifiable {
    register(cellType.self, forCellReuseIdentifier: cellType.reuseId)
  }

  func dequeueReusableCell<C: UITableViewCell>(
    with type: C.Type = C.self,
    indexPath: IndexPath
  ) -> C where C: CellContentClassIdentifiable {
    guard let cell = dequeueReusableCell(withIdentifier: type.reuseId, for: indexPath) as? C else {
      fatalError("Couldn't dequeue a UITableViewCell with identifier: \(type.reuseId)")
    }
    return cell
  }
}
