//
//  KastaAPI.swift
//  ikasta
//
//  Created by Zoreslav Khimich on 10/18/17.
//  Copyright © 2017 modnakasta. All rights reserved.
//

import Moya

enum KastaAPI {
    /// Active and scheduled campaigns
    case campaigns
}

extension KastaAPI: TargetType {

    var baseURL: URL {
        return URL(string: LocalConstants.CampaingsURL)!
    }
    
    var path: String {
        switch self {
        case .campaigns:
            return LocalConstants.Campaings
        }
    }
        
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .campaigns:
            return Stubs.campaigns.data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .campaigns:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    private enum LocalConstants {
        static let Campaings = "campaigns"
        static let CampaingsURL = LocalConstants.BaseAddress + LocalConstants.APIVersion
        static private let BaseAddress = "https://modnakasta.ua"
        static private let APIVersion = "/api/v2/"
    }
}
