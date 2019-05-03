//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

struct AnyInterceptor<Input>: Interceptor {

	// MARK: - Private

	private let intercept: (InterceptorChain<Input>) -> Observable<Input>

	// MARK: - Initializing
	init<I: Interceptor>(base: I) where I.Input == Input {
		self.intercept = base.intercept
	}

	func intercept(chain: InterceptorChain<Input>) -> Observable<Input> {
		return self.intercept(chain)
	}
}
