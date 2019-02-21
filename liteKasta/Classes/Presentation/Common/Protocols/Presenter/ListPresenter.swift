//
//  FetchingPresenterProtocol.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/14/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation

protocol ListPresenter: FetchingPresenter {
    func openCampaingWebURL(with campaingID: String)
    func openSoonCampaingsWebURL()
}

protocol FetchingPresenter {
    func fetch()
}
