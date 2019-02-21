//
//  NextCampaingsCell.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/20/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation
import UIKit

final class NextCampaingsCell: UICollectionViewCell {

    private let titleLabel = UILabel()
    private let nextCampaingsButton = UILabel()
    private var textInfoViews: [ReusableView] = []
    private let cornersOverlay = UIImageView(image: UIImage(named: LocalConstants.CornersImageName))

    //MARK: Initializations and Dealoccation
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .campaignCellBackground
        isOpaque = true

        configureOutlets()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }

    //MARK: Overrided functions
    override func prepareForReuse() {
        titleLabel.text = nil
        nextCampaingsButton.text = nil

        for infoView in textInfoViews {
            infoView.prepareForReuse()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureSubviews()
    }

    //MARK: Public
    func configureCell(with viewModel: NextCampaignViewModel) {

        if let firstTitle = viewModel.firstTitle {
            let textFrame = CGRect(x: 0,
                                   y: LocalConstants.FirstTextInfoViewPointPositionY,
                                   width: frame.size.width - 12,
                                   height: LocalConstants.TextInfoBaseHeight)
            let firstInfoView = CampaingTextInfoView(frame: textFrame)
            firstInfoView.configure(with: firstTitle, description: viewModel.firstDescr ?? "")
            addSubview(firstInfoView)
            textInfoViews.append(firstInfoView)
        }

        if let secondTitle = viewModel.secondTitle {
            let textFrame = CGRect(x: 0,
                                   y: LocalConstants.FirstTextInfoViewPointPositionY + LocalConstants.TextInfoBaseHeight,
                                   width: frame.size.width - 12,
                                   height: LocalConstants.TextInfoBaseHeight)
            let secondInfoView = CampaingTextInfoView(frame: textFrame)
            secondInfoView.configure(with: secondTitle, description: viewModel.secondDescr ?? "")
            addSubview(secondInfoView)
            textInfoViews.append(secondInfoView)
        }

        if let thirdTitle = viewModel.thirdTitle {
            let textFrame = CGRect(x: 0,
                                   y: LocalConstants.FirstTextInfoViewPointPositionY + LocalConstants.TextInfoBaseHeight * 2,
                                   width: frame.size.width - 12,
                                   height: LocalConstants.TextInfoBaseHeight)
            let thirdInfoView = CampaingTextInfoView(frame: textFrame)
            thirdInfoView.configure(with: thirdTitle, description: viewModel.thirdDescr ?? "")
            addSubview(thirdInfoView)
            textInfoViews.append(thirdInfoView)
        }
    }

    //MARK: Private
    private func configureOutlets() {
        titleLabel.font = .mediumWeight13
        titleLabel.textColor = .greyText
        titleLabel.text = LS.CollectionCell.NextCampaings.Title.uppercased()
        addSubview(titleLabel)

        nextCampaingsButton.font = .regularWeight15
        nextCampaingsButton.textColor = .greenText
        nextCampaingsButton.text = LS.CollectionCell.NextCampaings.ButtonTitle
        addSubview(nextCampaingsButton)

        addSubview(cornersOverlay)
    }

    private func configureSubviews() {

        titleLabel.frame = CGRect(x: LocalConstants.PointPositionX16,
                                  y: LocalConstants.PointPositionY16,
                                  width: bounds.width - 12,
                                  height: LocalConstants.TitleLabelHeight)

        nextCampaingsButton.frame = CGRect(x: LocalConstants.PointPositionX16,
                                           y: frame.size.height - (LocalConstants.BottomInset + LocalConstants.NextCampaingsButtonHeight),
                                           width: bounds.width - 12,
                                           height: LocalConstants.NextCampaingsButtonHeight)

        cornersOverlay.frame = bounds
    }

    //Private
    private enum LocalConstants {
        static let CornersImageName = "CampaignCell/4ptClipCorners"
        static let PointPositionX16: CGFloat = 16
        static let PointPositionY16: CGFloat = 16
        static let BottomInset: CGFloat = 16
        static let TitleLabelBottomX: CGFloat = 32
        static let TitleLabelBottomInset: CGFloat = 12
        static let FirstTextInfoViewPointPositionY = LocalConstants.TitleLabelBottomX + LocalConstants.TitleLabelBottomInset
        static let TextInfoBaseHeight: CGFloat = 64
        static let NextCampaingsButtonHeight: CGFloat = 16
        static let TitleLabelHeight: CGFloat = 16
    }
}
