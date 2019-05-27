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

  lazy var nameLabel: UILabel = {
    return LabelBuilder()
      .setText("APP NAME")
      .setFont(DefaultTheme.Font.title3)
      .setNumberOfLines(2)
      .build()
  }()

  lazy var companyLabel: UILabel = {
    return LabelBuilder()
      .setText("COMPANY")
      .setFont(DefaultTheme.Font.body)
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

  lazy var moreButton: UIButton = {
    return ButtonBuilder(type: .custom)
      .setImage(#imageLiteral(resourceName: "moreIcon"))
      .setImage(#imageLiteral(resourceName: "moreIcon").mergedAlpha(0.8), state: .selected)
      .setBackgroundColor(DefaultTheme.Color.primaryColor)
      .setCornerRadius(16)
      .setWidthAnchor(32)
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
    /// [priceButton] - [UIView]
    /// ------------------------
    let priceWrapper = StackViewBuilder(
      arrangedSubViews: [
        self.priceButton,
        UIView(),
        self.moreButton
      ]).build()

    /// --------------------------------
    /// [nameLabel]
    ///  | 4
    /// [companyLabel]
    ///  | 4
    /// [UIView]
    ///  | 4
    /// [priceWrapper]
    /// -------------------------------
    let namePriceWrapper = StackViewBuilder(
      arrangedSubViews: [
        self.nameLabel,
        self.companyLabel,
        UIView(),
        priceWrapper
      ]).setAxis(.vertical).setSpacing(4).build()

    /// --------------------------------------------
    ///  [appIconImageView] -20- [namePriceWrapper]
    /// --------------------------------------------

    let topInfoWrapper = StackViewBuilder(
      arrangedSubViews: [
        self.appIconImageView,
        namePriceWrapper
      ]).setSpacing(20).build()

    /// ----------------------
    /// [appIconImageView]
    ///   | 16
    /// [whatsNewLabel]
    ///   | 16
    /// [releaseNotesLabel]
    /// ----------------------

    return StackViewBuilder(
      arrangedSubViews: [
        topInfoWrapper,
        self.whatsNewLabel,
        self.releaseNotesLabel
      ]).setAxis(.vertical).setSpacing(16).build()
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

  func showItem(_ show: Bool) {
    UIView.animate(withDuration: 0.2) {
      self.nameLabel.alpha = show ? 1.0 : 0.0
      self.appIconImageView.alpha = show ? 1.0 : 0.0
      self.priceButton.alpha = show ? 1.0 : 0.0
    }
  }
}

extension LookupCell: LookupViewModelBindable {

  // MARK: - functions for protocol

  func bind(to viewModel: LookupViewModeling) {

    viewModel.outputs.name
      .asDriverJustComplete()
      .drive(nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.company
      .asDriverJustComplete()
      .drive(companyLabel.rx.text)
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
