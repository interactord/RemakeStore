//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol Repository {
	associatedtype Resource

	func create(with parameter: RepositoryParameter?) -> Observable<ResultContent<Resource>>
	func read(with parameter: RepositoryParameter?) -> Observable<ResultContent<Resource>>
	func update(with parameter: RepositoryParameter?) -> Observable<ResultContent<Resource>>
	func delete(with parameter: RepositoryParameter?) -> Observable<ResultContent<Resource>>
}
