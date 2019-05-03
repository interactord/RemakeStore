//
//  Created by Scott Moon on 01/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

extension PropertyListDecoder {

  func deserialize<D: Decodable>(with url: URL? = nil) -> D? {
    guard let url = url else {
      return nil
    }

    guard
      let data = try? Data(contentsOf: url, options: .mappedIfSafe),
      let object = try? self.decode(D.self, from: data)
      else {
      return nil
    }
    return object
  }
}
