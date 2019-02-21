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

    private let firstInfoView = CampaingTextInfoView()
    private let secondInfoView = CampaingTextInfoView()
    private let thirdInfoView = CampaingTextInfoView()

    private let cornersOverlay = UIImageView(image: UIImage(named: LocalConstants.CornersImageName))

    //MARK: Class methods
    class func desiredHeightFor(with viewModel: NextCampaignViewModel) -> CGFloat {
        var height = LocalConstants.CellBaseHeigth

        if let _ = viewModel.firstTitle {
            height += LocalConstants.TextInfoBaseHeight
        }

        if let _ = viewModel.secondTitle {
            height += LocalConstants.TextInfoBaseHeight
        }

        if let _ = viewModel.thirdTitle {
            height += LocalConstants.TextInfoBaseHeight
        }

        return height
    }

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
        super.prepareForReuse()

        titleLabel.text = nil
        nextCampaingsButton.text = nil

        firstInfoView.prepareForCollectionReuse()
        secondInfoView.prepareForCollectionReuse()
        thirdInfoView.prepareForCollectionReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureSubviews()
    }

    //MARK: Public
    func configureCell(with viewModel: NextCampaignViewModel) {
        titleLabel.text = LS.CollectionCell.NextCampaings.Title.uppercased()
        nextCampaingsButton.text = LS.CollectionCell.NextCampaings.ButtonTitle

        if let firstTitle = viewModel.firstTitle {
            firstInfoView.configure(with: firstTitle, description: viewModel.firstDescr ?? "")
        }

        if let secondTitle = viewModel.secondTitle {
            secondInfoView.configure(with: secondTitle, description: viewModel.secondDescr ?? "")
        }

        if let thirdTitle = viewModel.thirdTitle {
            thirdInfoView.configure(with: thirdTitle, description: viewModel.thirdDescr ?? "")
        }
    }

    //MARK: Private
    private func configureOutlets() {
        titleLabel.font = .mediumWeight13
        titleLabel.textColor = .greyText
        addSubview(titleLabel)

        nextCampaingsButton.font = .regularWeight15
        nextCampaingsButton.textColor = .greenText

        addSubview(nextCampaingsButton)
        addSubview(cornersOverlay)
        addSubview(firstInfoView)
        addSubview(secondInfoView)
        addSubview(thirdInfoView)
    }

    private func configureSubviews() {
        titleLabel.frame = CGRect(x: LocalConstants.PointPositionX16,
                                  y: LocalConstants.PointPositionY16,
                                  width: bounds.width - 12,
                                  height: LocalConstants.TitleLabelHeight)

        firstInfoView.frame = CGRect(x: 0,
                                     y: LocalConstants.FirstTextInfoViewPointPositionY,
                                     width: frame.size.width - 16,
                                     height: LocalConstants.TextInfoBaseHeight)

        secondInfoView.frame = CGRect(x: 0,
                                      y: LocalConstants.FirstTextInfoViewPointPositionY + LocalConstants.TextInfoBaseHeight,
                                      width: frame.size.width - 16,
                                      height: LocalConstants.TextInfoBaseHeight)

        thirdInfoView.frame = CGRect(x: 0,
                                     y: LocalConstants.FirstTextInfoViewPointPositionY + LocalConstants.TextInfoBaseHeight * 2,
                                     width: frame.size.width - 16,
                                     height: LocalConstants.TextInfoBaseHeight)

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
        static let TopInset: CGFloat = 16
        static let BottomInset: CGFloat = 16
        static let TitleLabelBottomX: CGFloat = 32
        static let TitleLabelBottomInset: CGFloat = 12
        static let FirstTextInfoViewPointPositionY = LocalConstants.TitleLabelBottomX + LocalConstants.TitleLabelBottomInset
        static let TextInfoBaseHeight: CGFloat = 64
        static let NextCampaingsButtonHeight: CGFloat = 16
        static let TitleLabelHeight: CGFloat = 16
        static let CellBaseHeigth: CGFloat = 16 + 16 + 12 + 16 + 16
    }
}
