//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

final class SearchRepository {

	// MARK: - Private

	private let httpClient: HTTPClient

	// MARK: - Initializing

	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}

}

extension SearchRepository: Repository {

	// MARK: - functions for protocol

	public func create(with parameter: RepositoryParameter?) -> Observable<ResultContent<Lookup>> {
		fatalError("create(with:) has not been implemented")
	}

	public func read(with parameter: RepositoryParameter?) -> Observable<ResultContent<Lookup>> {
    guard let parameter = parameter as? SearchReadParameter else {
			fatalError("Should be not nil")
		}
		return httpClient.request(endpoint: SearchEndpoint.read(with: parameter))
	}

	public func update(with parameter: RepositoryParameter?) -> Observable<ResultContent<Lookup>> {
		fatalError("update(with:) has not been implemented")
	}

	public func delete(with parameter: RepositoryParameter?) -> Observable<ResultContent<Lookup>> {
		fatalError("delete(with:) has not been implemented")
	}
}
