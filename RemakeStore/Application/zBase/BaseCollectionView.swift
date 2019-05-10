//
// Created by Scott Moon on 2019-05-07.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

class BaseCollectionView: UICollectionView {

	// MARK: Public

	enum LayoutStyle {
		case horizontalSnapping
		case `default`
	}

	// MARK: - Private

	lazy private(set) public var disposeBag = DisposeBag()

	// MARK: - Initializing

	convenience init() {
		let layout = UICollectionViewFlowLayout()
		self.init(frame: .zero, collectionViewLayout: layout)
		loadView()
	}

	convenience init(withLayoutStyle style: LayoutStyle = .default) {
		let layout: UICollectionViewFlowLayout

		switch style {
		case .default:
			layout = UICollectionViewFlowLayout()
		case .horizontalSnapping:
      layout = HorizontalSnappingLayout()
		}

		self.init(frame: .zero, collectionViewLayout: layout)
		loadView()
	}

	deinit {
		print("\(type(of: self)): \(#function)")
	}

	private func loadView() {
		setupView()
		registerCell()
		setupDelegate()
	}

	func setupDelegate() {
	}

	func registerCell() {
	}

	func setupView() {
		self.backgroundColor = .white
	}
}
