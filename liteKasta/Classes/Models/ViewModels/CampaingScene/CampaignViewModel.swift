//
//  CampaignViewModel.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/3/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import IGListKit

final class CampaignViewModel: NSObject {
    
    let identifier: Int
    let title: String
    let desc: String
    let countdownToDate: Date
    let bannerPath: String
    let codename: String

    init(with model: CampaignModel) {
        identifier = model.id
        title = model.name
        desc = model.description
        countdownToDate = model.finishesAt
        bannerPath = model.nowImage
        codename = model.codename
    }
}

extension CampaignViewModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let model = object as? CampaignViewModel else { return false }
        return title == model.title
            && desc == model.desc
            && countdownToDate == model.countdownToDate
            && bannerPath == model.bannerPath
    }
}

