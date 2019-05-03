//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct AnyTransformer<Input, Output>: Transformer {

	// MARK: - Private

	private let transform: (Input) throws -> Output

	// MARK: - Initializing
	public init<T: Transformer>(base: T) where T.Input == Input, T.Output == Output {
		self.transform = base.transform
	}

	// MARK: - functions for protocol
	public func transform(object: Input) throws -> Output {
		return try transform(object)
	}

}
