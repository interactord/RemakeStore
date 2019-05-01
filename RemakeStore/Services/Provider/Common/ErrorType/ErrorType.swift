//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

protocol ErrorType: Error {
	var raw: Error? { get }
	var messageKey: String { get }
}
