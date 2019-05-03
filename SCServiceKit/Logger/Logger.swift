//
//  Created by Scott Moon on 01/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

protocol Logger {
  func log(level: LoggerLevel, message: Any)
}
