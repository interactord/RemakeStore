//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct AppResponse {

	// MARK: - Private

	private let _request: URLRequest
	private let _data: Data?
	private let httpResponse: URLResponse?
	private let _error: Error?

	// MARK: - Initializing
	init(request: URLRequest, data: Data? = nil, httpResponse: URLResponse? = nil, error: Error? = nil) {
		_request = request
		_data = data
		self.httpResponse = httpResponse
		_error = error
	}
}

extension AppResponse: Response {

	var succeed: Bool {
		guard let httpResponse = httpResponse as? HTTPURLResponse else {
			return false
		}

		return httpResponse.statusCode >= HttpStatusCode.ok.rawValue
			&& httpResponse.statusCode < HttpStatusCode.badRequest.rawValue
	}

	var data: Data? {
		return  _data
	}

	var error: Error? {
		return _error
	}

	var statusCode: HttpStatusCode? {
		guard let httpResponse = httpResponse as? HTTPURLResponse else {
			return nil
		}
		return HttpStatusCode(rawValue: httpResponse.statusCode)
	}

	var request: URLRequest {
		return _request
	}

	var headers: [String: Any]? {
		guard let httpResponse = httpResponse as? HTTPURLResponse else {
			return nil
		}
		return httpResponse.allHeaderFields as? [String: Any]
	}
}