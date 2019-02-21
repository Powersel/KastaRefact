//
//  CampaingTextInfoView.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/21/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import UIKit

final class CampaingTextInfoView: UIView, ReusableView {

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    //MARK: Initialisation and Dealoccation
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .campaignCellBackground
        isOpaque = true

        configureOutlets()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }

    //MARK: Private
    private func configureOutlets() {

        titleLabel.frame = CGRect(x: 16,
                             y: 0,
                             width: self.bounds.width,
                             height: LocalConstants.TitleLabelFrameHeight)

        titleLabel.font = .mediumWeight17
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)

        descriptionLabel.frame = CGRect(x: 16,
                                        y: titleLabel.frame.height + LocalConstants.LabelsVerticalInset,
                                        width: self.bounds.width,
                                        height: LocalConstants.DescLabelFrameHeight)
        descriptionLabel.font = .regularWeight14
        descriptionLabel.textColor = .descriptionGreyText
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
    }

    func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
    }

    private enum LocalConstants {
        static let TitleLabelFrameHeight: CGFloat = 18
        static let DescLabelFrameHeight: CGFloat = 14
        static let LabelsVerticalInset: CGFloat = 6
    }
}
