//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public class NSLocalizedStringTranslator: Translator {

  public init() { }

  public func translation(for key: String) -> String {
    return NSLocalizedString(key, comment: key)
  }
}
