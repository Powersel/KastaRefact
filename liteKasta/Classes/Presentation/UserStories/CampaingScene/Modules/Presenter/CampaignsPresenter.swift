//
//  CampaignsPresenter.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/14/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation
import Moya
import AlamofireImage
import IGListKit

final class CampaingPresenter: ListPresenter {

    weak var view: CollectionViewController?

    private let provider: MoyaProvider<KastaAPI>
    private let router: CampaignsRouterProtocol

    init(provider: MoyaProvider<KastaAPI>, router: CampaignsRouterProtocol) {
        self.provider = provider
        self.router = router
    }

    //MARK: Public
    func openCampaingWebURL(with campaingID: String) {
        router.openCampaingWebURL(with: campaingID)
    }

    func openSoonCampaingsWebURL() {
        router.openSoonCampaingsWebURL()
    }

    func fetch() {
            provider.request(.campaigns) { result in
                do {
                    switch result {

                    case .success(let response):
                        let response = try response.filterSuccessfulStatusAndRedirectCodes()
                        var campaigns = try response.map([CampaignModel].self,
                                                         atKeyPath: LocalConstants.CampaingsKeyPath,
                                                         using: JSONDecoder.kastaStandardDecoder)
                        campaigns = self.removeVirtualCampaings(campaigns: campaigns)
                        let (activeCampaigns, soonCampaigns, _) = campaigns.filterActiveWithSoon(for: Date())
                        var viewModels = activeCampaigns.map() { return CampaignViewModel(with: $0) } as [ListDiffable]
                        let nextCampaignViewModel = NextCampaignViewModel(with: soonCampaigns)
                        if viewModels.count > 6 {
                            let randomIndex = Int.random(in: 3 ... 6)
                            viewModels.insert(nextCampaignViewModel, at: randomIndex)
                        } else {
                            viewModels.append(nextCampaignViewModel)
                        }

                        self.view?.reloadListData(with: viewModels)

                    case .failure(let error):
                        throw error
                    }
                }

                catch let error {
                    self.view?.showNoNetworkErrorController(error: error)
                }
            }
    }

    // MARK: Private
    func removeVirtualCampaings(campaigns: [CampaignModel]) -> [CampaignModel] {
        return campaigns.filter{
            if let mods = $0.mods  {
                for mod in mods {
                    return mod[LocalConstants.VirtualCampaingsNameKeyPath] != LocalConstants.VirtualCampaingsKeyPath
                }
            }
            return true
        }
    }

    enum LocalConstants {
        static let CampaingsKeyPath = "items"
        static let VirtualCampaingsKeyPath = "virtual"
        static let VirtualCampaingsNameKeyPath = "name"
    }
}
