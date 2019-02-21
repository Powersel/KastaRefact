//
//  AppDelegate.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/2/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window!.rootViewController = makeHomeViewController()
        window!.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {

    func makeHomeViewController() -> UIViewController {
        let provider = MoyaProvider<KastaAPI>()
        let router = CampaignsRouter()
        let presenter = CampaingPresenter(provider: provider, router: router)
        let controller = CampaignsViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }
}
