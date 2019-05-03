//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public enum HTTPStatusCode: Int {
	case ok = 200
	case created = 201
	case noContent = 204
	case badRequest = 400
	case unauthorized = 401
	case forbidden = 403
	case notFound = 404
	case internalServerError = 500
	case serverUnavailable = 503
}
