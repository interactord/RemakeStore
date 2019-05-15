//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

protocol AppsViewModelInput {
	var fetchApps: BehaviorSubject<Void?> { get }
}

protocol AppsViewModelOutput {
}

protocol AppsViewModeling {
	var inputs: AppsViewModelInput { get }
	var outputs: AppsViewModelOutput { get }
}

typealias AppsViewModelType =
	AppsViewModelInput & AppsViewModelOutput & AppsViewModeling

class AppsViewModel: ServiceViewModel, AppsViewModelType {

	// MARK: - Inputs & Outputs

	var inputs: AppsViewModelInput {
		return self
	}

	var outputs: AppsViewModelOutput {
		return self
	}

	// MARK: - Inputs
	var fetchApps: BehaviorSubject<Void?> = .init(value: nil)

	// MARK: - Outputs

	// MARK: - Private

	let rssRepository: RssRepository

	// MARK: - Protocol Variables

	let service: Service

	// MARK: - Initializing

	init(with service: Service, rssRepository: RssRepository) {
		self.service = service
		self.rssRepository = rssRepository
	}
}
