//
// Created by Scott Moon on 2019-05-15.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

final class RssRepository {

	// MARK: - Private

	private let httpClient: HTTPClient
	private let baseUrl: String

	// MARK: - Initializing

	init(httpClient: HTTPClient, baseURL: String) {
		self.httpClient = httpClient
		self.baseUrl = baseURL
	}
}

extension RssRepository {

	func topGrossing() -> Observable<ResultContent<AppGroup>> {
		let endpoint = RssEndpoint(baseUrl: baseUrl, route: .topFree)
		return httpClient.request(endpoint: endpoint)
	}

	func newGames() -> Observable<ResultContent<AppGroup>> {
		let endpoint = RssEndpoint(baseUrl: baseUrl, route: .newGames)
		return httpClient.request(endpoint: endpoint)
	}

	func topFree() -> Observable<ResultContent<AppGroup>> {
		let endpoint = RssEndpoint(baseUrl: baseUrl, route: .topFree)
		return httpClient.request(endpoint: endpoint)
	}

}
