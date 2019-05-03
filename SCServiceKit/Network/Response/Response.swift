//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public protocol Response {
	var succeed: Bool { get }
	var data: Data? { get }
	var error: Error? { get }
	var statusCode: HTTPStatusCode? { get }
	var request: URLRequest { get }
	var headers: [String: Any]? { get }
}
