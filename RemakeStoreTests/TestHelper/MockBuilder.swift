//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

@testable import RemakeStore

struct MockBuilder {

	static func makeNetworkAdapter() -> URLSessionNetworkAdapter {
		let networkActivityMock = NetworkActivityMock()
		let sessionConfig = URLSessionConfiguration.default
		sessionConfig.timeoutIntervalForRequest = 30
		sessionConfig.timeoutIntervalForResource = 30

		let session = URLSession(configuration: sessionConfig)
		return URLSessionNetworkAdapter(networkActivity: networkActivityMock, session: session)
	}

	static func makeTransformer() -> AnyTransformer<Endpoint, URLRequest> {
		let transformer = EndPointToURLRequestTransformer()
		return AnyTransformer(base: transformer)
	}

	static func makeEndpointNoContentsMock() -> EndpointMock {
		return EndpointMock(
			baseURL: "http://localhost:7000",
			path: "/update",
			httpMethod: .PUT
		)
	}

}
