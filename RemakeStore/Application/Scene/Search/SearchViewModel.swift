//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

class SearchViewModel: ServiceViewModel {
	let service: Service

 let searchText: BehaviorSubject<String> = .init(value: "")

	required init(with service: Service) {
		self.service = service
	}
}
