//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

public class UIApplicationNetworkActivity {

	// MARK: - Private

  var application: UIApplication
	var counter: Int

	// MARK: - Initializing
	public init(application: UIApplication) {
		self.application = application
		counter = 0
	}

}

extension UIApplicationNetworkActivity: NetworkActivity {

	// MARK: - functions for protocol

	public func show() {
		counter = counter.increase(1)

		if false == application.isNetworkActivityIndicatorVisible {
			application.isNetworkActivityIndicatorVisible = true
		}
	}

	public func hide() {
		counter = counter.decrease(1, min: 0)

		if counter == 0 && application.isNetworkActivityIndicatorVisible {
			application.isNetworkActivityIndicatorVisible = false
		}
	}
}
