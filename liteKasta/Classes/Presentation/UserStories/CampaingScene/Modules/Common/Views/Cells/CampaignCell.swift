//
//  CampaignCell.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/3/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import UIKit

final class CampaignCell: UICollectionViewCell {

    private let title = UILabel()
    private let desc = UILabel()
    private let picture = UIImageView()
    private let cornersOverlay = UIImageView(image: UIImage(named: LocalConstants.CornersImageName))

    //MARK: Class methods
    class func desiredHeightFor(columnWidth: CGFloat) -> CGFloat {
        return floor(columnWidth / LocalConstants.PictureAspect) + LocalConstants.CaptionBlockHeight
    }

    //MARK: Initialisation and Dealoccation
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .campaignCellBackground
        isOpaque = true

        configureOutlets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func prepareForReuse() {
        picture.image = nil
        title.text = nil
        desc.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        picture.frame = CGRect(x: 0,
                               y: 0,
                               width: bounds.width,
                               height: floor(bounds.width / LocalConstants.PictureAspect))
        title.frame = CGRect(x: LocalConstants.PointPositionX16,
                             y: picture.frame.maxY + LocalConstants.PointPositionY16,
                             width: bounds.width - LocalConstants.WidthInset * 2,
                             height: LocalConstants.FrameHeight24)
        desc.frame = CGRect(x: title.frame.minX,
                            y: title.frame.maxY + LocalConstants.PointPositionY4,
                            width: title.frame.width,
                            height: LocalConstants.FrameHeight16)
        
        cornersOverlay.frame = bounds
    }

    func configure(with viewModel: CampaignViewModel) {
        title.text = viewModel.title
        desc.text = viewModel.desc
        if let url = URL(string: "https://modnakasta.ua/imgw/loc/0x0/\(viewModel.bannerPath)") {
            picture.af_setImage(withURL: url,
                                placeholderImage: UIImage(named: LocalConstants.BrokenImageName))
        }
        
    }

    //MARK: Private
    private func configureOutlets() {
        title.font =  .mediumWeight17
        title.textColor = .normalText
        addSubview(title)

        desc.font = .regularWeight13
        title.textColor = .normalText
        addSubview(desc)

        addSubview(picture)
        addSubview(cornersOverlay)
    }

    private enum LocalConstants {
        static let CornersImageName = "CampaignCell/4ptClipCorners"
        static let BrokenImageName = "brokenImage"
        static let PictureAspect: CGFloat = 1.0 / 0.5602
        static let CaptionBlockHeight: CGFloat = 76
        static let FrameHeight16: CGFloat = 16
        static let FrameHeight24: CGFloat = 24
        static let PointPositionX16: CGFloat = 16
        static let PointPositionY4: CGFloat = 4
        static let PointPositionY16: CGFloat = 16
        static let WidthInset: CGFloat = 16
    }
}
