//
//  CampaingsSceneError.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/19/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import UIKit
import Moya

final class CampaingsGeneralErrorView: UIView {

    private let label = UILabel()
    private let button = UIButton(type: .system)

    var delegate: ErrorableViewDelegate?

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

    //MARK: Public
    func configureUI(with error: Error) {
        if let moyaError = error as? MoyaError {
            switch moyaError.errorDescription  {
            case LocalConstants.OfflineMoyaError:
                label.text = LS.ErrorStates.Network.LostConnection
            default:
                label.text = LS.ErrorStates.Network.ModelsMapping
            }
        } else {
            label.text = LS.ErrorStates.Network.General
        }
    }

    //MARK: Private
    private func configureOutlets() {

        label.frame = CGRect(x: 16,
                             y: 0,
                             width: self.bounds.width,
                             height: LocalConstants.LabelFrameHeight)
        label.center = self.center
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .mediumWeight17
        label.textColor = .greyText

        button.frame = CGRect(x: label.frame.origin.x,
                              y: label.frame.maxY + 5,
                              width: label.frame.width,
                              height: label.frame.height)
        button.contentHorizontalAlignment = .center
        button.setTitle(LS.View.CampaingsGeneralError.RetryButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(retry), for: UIControlEvents.touchUpInside)

        addSubview(label)
        addSubview(button)
    }

    @objc private func retry() {
        delegate?.callRetry()
    }

    private enum LocalConstants {
        static let OfflineMoyaError = "The Internet connection appears to be offline."
        static let LabelFrameHeight: CGFloat = 70
    }
}
