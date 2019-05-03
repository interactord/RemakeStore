//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

protocol ServiceViewModel {
	associatedtype ServiceType
	var service: ServiceType { get }
}
