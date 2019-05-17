//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit
import RxCocoa
import RxSwift
import RxFlow

protocol TodayMultipleAppListViewBinadle {
  func bind(to rootStepper: PublishRelay<Step>)
}

class TodayMultipleAppListView: BaseCollectionView {

  enum Mode {
    case small, fullScreen
  }

  // MARK: - Private

  private var mode: Mode = .small
  private let cellSpacing: CGFloat = 12
  private let cellHeight: CGFloat = 68
  private let fullScreenCellPadding: CGFloat = 48
  private let fullScreenContentPadding: UIEdgeInsets = .init(top: 12, left: 24, bottom: 12, right: 24)
  private var rootStepper: PublishRelay<Step>?

  private lazy var dismissButton: UIButton = {
    return ButtonBuilder(type: .custom)
      .setImage(#imageLiteral(resourceName: "Close-button"))
      .setImage(#imageLiteral(resourceName: "Close-button").transformedAlpha(0.5), state: .highlighted)
      .setWidthAnchor(44)
      .setHeightAnchor(44)
      .build()
  }()

  override func setupView() {
    super.setupView()

    addSubview(dismissButton)
    dismissButton
      .setTopAnchor(topAnchor, padding: 28)
      .setTrailingAnchor(trailingAnchor, padding: 16)
  }

  override func setupDelegate() {
    super.setupDelegate()
    self.dataSource = self
    self.delegate = self
  }

  override func registerCell() {
    super.registerCell()
    register(cellType: MultipleAppCell.self)
  }
}

extension TodayMultipleAppListView {

  func viewMode(to mode: Mode) {

    switch mode {
    case .fullScreen:
      self.isScrollEnabled = true
      dismissButton.isHidden = false
    default:
      self.isScrollEnabled = true
      dismissButton.isHidden = true
    }

    self.mode = mode
    self.reloadData()
  }
}

extension TodayMultipleAppListView: TodayMultipleAppListViewBinadle {
  func bind(to rootStepper: PublishRelay<Step>) {
    self.rootStepper = rootStepper
    self.reloadData()
  }
}

// MARK: - UICollectionViewDataSource

extension TodayMultipleAppListView: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch mode {
    case .small:
      return 10
    default:
      return min(4, 6)
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MultipleAppCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    cell.backgroundColor = .red
    return cell
  }
}

extension TodayMultipleAppListView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch mode {
    case .fullScreen:
      return .init(width: frame.width - fullScreenCellPadding, height: cellHeight)
    default:
      return .init(width: frame.width, height: cellHeight)
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    switch mode {
    case .fullScreen:
      return fullScreenContentPadding
    default:
      return .zero
    }
  }
}
