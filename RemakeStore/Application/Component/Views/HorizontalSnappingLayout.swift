//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class HorizontalSnappingLayout: UICollectionViewFlowLayout {

	override init() {
		super.init()
		scrollDirection = .horizontal
		self.collectionView?.isPagingEnabled = true
		self.collectionView?.decelerationRate = .fast
	}

	required convenience init?(coder aDecoder: NSCoder) {
		self.init()
	}

	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

		guard let collectionView = collectionView else {
			return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
		}

		let nextX: CGFloat

		if proposedContentOffset.x <= 0 || collectionView.contentOffset == proposedContentOffset {
			nextX = proposedContentOffset.x
		} else {
			let width = collectionView.bounds.width
			nextX = collectionView.contentOffset.x + (
				velocity.x > 0 ? width : -width
			)
		}

		let targetRect = CGRect(x: nextX, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
		var offsetAdjustment = CGFloat.greatestFiniteMagnitude
		let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
		let layoutAttributes = super.layoutAttributesForElements(in: targetRect)

		layoutAttributes?.forEach { attribute in
			let itemOffsetX = attribute.frame.origin.x
			if fabsf(Float(itemOffsetX - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
				offsetAdjustment = itemOffsetX - horizontalOffset
			}
		}

		return .init(
			x: proposedContentOffset.x + offsetAdjustment,
			y: proposedContentOffset.y
		)
	}
}
