//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

final class NSLocalizedStringTranslator: Translator {
	func translation(for key: String) -> String {
		return NSLocalizedString(key, comment: key)
	}
}
