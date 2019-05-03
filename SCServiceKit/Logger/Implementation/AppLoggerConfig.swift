//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct AppLoggerConfig: Decodable {
	let appId: String
	let appSecret: String
	let encryptionKey: String
}
