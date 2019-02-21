//
//  NextCampaingModel.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/20/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import IGListKit

final class NextCampaignViewModel: NSObject {

    let identifier: Int
    var firstTitle: String?
    var firstDescr: String?
    var secondTitle: String?
    var secondDescr: String?
    var thirdTitle: String?
    var thirdDescr: String?

    init(with nextCampaings: [CampaignModel]) {

        firstTitle = nextCampaings.item(at: 0)?.name
        firstDescr = nextCampaings.item(at: 0)?.description

        secondTitle = nextCampaings.item(at: 1)?.name
        secondDescr = nextCampaings.item(at: 1)?.description

        thirdTitle = nextCampaings.item(at: 2)?.name
        thirdDescr = nextCampaings.item(at: 2)?.description

        identifier = UUID().hashValue

        super.init()
    }
}

extension NextCampaignViewModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSNumber
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let model = object as? NextCampaignViewModel else {
            return false
        }
        return firstTitle == model.firstTitle
            && secondTitle == model.secondTitle
            && thirdTitle == model.thirdTitle
            && firstDescr == model.firstDescr
            && secondDescr == model.secondDescr
            && thirdDescr == model.thirdDescr
    }
}
