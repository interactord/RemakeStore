//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

public protocol NetworkAdapter {
	func rx_send(request: URLRequest) -> Observable<Response>
}
