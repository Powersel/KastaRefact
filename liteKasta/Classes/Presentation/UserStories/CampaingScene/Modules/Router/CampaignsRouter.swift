//
//  CampaignsRouter.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/19/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import UIKit

protocol CampaignsRouterProtocol {
    func openCampaingWebURL(with campaingID: String)
    func openSoonCampaingsWebURL()
}

struct CampaignsRouter: CampaignsRouterProtocol {

    func openCampaingWebURL(with campaingID: String) {
        let url = constructCampaingWebURL(with: campaingID)
        if let webURL = URL(string: url) {
            UIApplication.shared.openURL(webURL)
        }
    }

    func openSoonCampaingsWebURL() {
        if let webURL = URL(string: LocalConstants.SoonWebURLPath) {
            UIApplication.shared.openURL(webURL)
        }
    }

    private func constructCampaingWebURL(with campaingName: String) -> String {
        return LocalConstants.CampaingsMainURL + campaingName + ")/"
    }

    enum LocalConstants {
        static let SoonWebURLPath = "https://modnakasta.ua/#soon"
        static let CampaingsMainURL = "https://modnakasta.ua/campaign/("
    }
}
