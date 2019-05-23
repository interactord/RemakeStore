//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit

class LookupCell: BaseCollectionViewCell {

  // MARK: - Views

  var sizeViewModel: LookupViewModeling? {
    didSet {
      guard let viewModel = sizeViewModel else {
        return
      }
      releaseNotesLabel.text = viewModel.outputs.result.releaseNotes
    }
  }

  lazy var appIconImageView: UIImageView = {
    return ImageViewBuilder()
      .setBackgroundColor(DefaultTheme.Color.placeHolderColor)
      .setCornerRadius(16)
      .setClipToBounds(true)
      .setContentMode(.scaleAspectFill)
      .setWidthAnchor(140)
      .setHeightAnchor(140)
      .build()
  }()

  lazy var nameLabel: UILabel = { return LabelBuilder()
      .setText("APP NAME")
      .setFont(DefaultTheme.Font.title3)
      .setNumberOfLines(2)
      .build()
  }()

  lazy var priceButton: UIButton = {
    return ButtonBuilder()
      .setTitle("$4.99")
      .setFont(DefaultTheme.Font.headline)
      .setBackgroundColor(DefaultTheme.Color.primaryColor)
      .setTitleColor(.white)
      .setCornerRadius(16)
      .setWidthAnchor(80)
      .setHeightAnchor(32)
      .build()
  }()

  lazy var whatsNewLabel: UILabel = {
    return LabelBuilder()
      .setText("What's New")
      .setFont(DefaultTheme.Font.title3)
      .build()
  }()

  lazy var releaseNotesLabel: UILabel = {
    return LabelBuilder()
      .setText("Release Notes")
      .setFont(DefaultTheme.Font.body)
      .setNumberOfLines(0)
      .build()
  }()

  lazy var stackView: UIStackView = {

    /// -----------------------
    /// [priceButton]
    ///      | 0
    /// [UIView]
    /// ------------------------
    let priceWrapper = StackViewBuilder(
      arrangedSubViews: [self.priceButton, UIView()]
    ).build()

    /// --------------------------------
    /// [nameLabel] -12- | [priceButton]
    ///                   |    | 0
    ///                  | [UIView]
    /// -------------------------------
    let namePriceWrapper = StackViewBuilder(
      arrangedSubViews: [self.nameLabel, priceWrapper, UIView()
      ]).setAxis(.vertical).setSpacing(12).build()

    /// -----------------------------------------------------------
    ///  [appIconImageView]   -16-  |  [nameLabel] -12- | [priceButton
    ///                            | -------------------------------
    ///                            |
    ///                            |
    /// -----------------------------------------------------------

    let topInfoWrapper = StackViewBuilder(
      arrangedSubViews: [self.appIconImageView, namePriceWrapper]
    ).setSpacing(20).build()

    /// -----------------------------------------------------------
    ///  [appIconImageView]   -16-  |  [nameLabel] -12- | [priceButton
    ///                            | -------------------------------
    ///                            |
    ///                            |
    /// -----------------------------------------------------------
    /// [whatsNewLabel]--------------------------------------------
    ///   | 16
    /// [releaseNotesLabel]----------------------------------------

    return StackViewBuilder(
      arrangedSubViews: [topInfoWrapper, self.whatsNewLabel, self.releaseNotesLabel]
    ).setAxis(.vertical).setSpacing(16).build()
  }()

  override func setupSubView() {
    super.setupSubView()
    self.backgroundColor = .white

    addSubview(stackView)
    stackView.fillSuperView(
      padding: .init(top: 20, left: 20, bottom: 20, right: 20)
    )
  }

  override func reset() {
    super.reset()
    sizeViewModel = nil
    nameLabel.text = ""
    releaseNotesLabel.text = ""
    appIconImageView.image = nil
    priceButton.setTitle("", for: .normal)
  }
}

extension LookupCell: LookupViewModelBindable {

  // MARK: - functions for protocol

  func bind(to viewModel: LookupViewModeling) {

    viewModel.outputs.name
      .asDriverJustComplete()
      .drive(nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.releaseNote
      .asDriverJustComplete()
      .drive(releaseNotesLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.appIconImageUrlPath
      .asDriverJustComplete()
      .drive(appIconImageView.rx.loadImage)
      .disposed(by: disposeBag)

    viewModel.outputs.priceFormat
      .asDriverJustComplete()
      .drive(priceButton.rx.updateNormalStateTitle)
      .disposed(by: disposeBag)
  }

}

extension LookupCell: CellContentClassIdentifiable {
}
