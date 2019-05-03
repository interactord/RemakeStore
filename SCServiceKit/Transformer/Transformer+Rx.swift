//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

extension Transformer {

	func rx_transform(object: Input) -> Observable<Output> {

		return Observable.create { observer in
			do {
				observer.onNext(try self.transform(object: object))
				observer.onCompleted()
			} catch {
				observer.onError(error)
			}

			return Disposables.create()
		}
	}
}
