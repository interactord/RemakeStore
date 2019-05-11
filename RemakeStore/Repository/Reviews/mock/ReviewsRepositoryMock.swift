//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

@testable import RemakeStore

final class ReviewsRepositoryMock {

	// MARK: - Private

	private let httpClient: HTTPClient

	// MARK: - Initializing

	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}

}

extension ReviewsRepositoryMock: Repository {

	// MARK: - functions for protocol

	public func create(with parameter: RepositoryParameter?) -> Observable<ResultContent<Reviews>> {
		fatalError("create(with:) has not been implemented")
	}

	public func read(with parameter: RepositoryParameter?) -> Observable<ResultContent<Reviews>> {
		guard let parameter = parameter as? ReviewsReadParameter else {
			fatalError("Should be not nil")
		}
		return httpClient.request(endpoint: ReviewsEndpointMock.read(with: parameter))
	}

	public func update(with parameter: RepositoryParameter?) -> Observable<ResultContent<Reviews>> {
		fatalError("update(with:) has not been implemented")
	}

	public func delete(with parameter: RepositoryParameter?) -> Observable<ResultContent<Reviews>> {
		fatalError("delete(with:) has not been implemented")
	}
}
