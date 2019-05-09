//
//  SearchResultRepository.swift
//  RemakeStore
//
//  Created by Scott Moon on 09/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

final class SearchResultRepository {

	// MARK: - Private

	private let httpClient: HTTPClient

	// MARK: - Initializing

	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}

}

extension SearchResultRepository: Repository {

	// MARK: - functions for protocol

	public func create(with parameter: RepositoryParameter?) -> Observable<ResultContent<AppResult>> {
		fatalError("create(with:) has not been implemented")
	}

	public func read(with parameter: RepositoryParameter?) -> Observable<ResultContent<AppResult>> {
    guard let parameter = parameter as? SearchResultReadParameter else {
			fatalError("Should be not nil")
		}
		return httpClient.request(endpoint: SearchResultEndpoint.read(with: parameter))
	}

	public func update(with parameter: RepositoryParameter?) -> Observable<ResultContent<AppResult>> {
		fatalError("update(with:) has not been implemented")
	}

	public func delete(with parameter: RepositoryParameter?) -> Observable<ResultContent<AppResult>> {
		fatalError("delete(with:) has not been implemented")
	}
}
