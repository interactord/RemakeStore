//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

public protocol Interceptor {
	associatedtype Input

	func intercept(chain: InterceptorChain<Input>) -> Observable<Input>
}
