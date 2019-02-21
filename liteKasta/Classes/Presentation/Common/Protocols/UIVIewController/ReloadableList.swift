//
//  ReloadableListControllerProtocol.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/14/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import IGListKit

protocol ReloadableList: AnyObject {
    func reloadListData(with models: [ListDiffable])
}

protocol ErrorableController: AnyObject {
    func showNoNetworkErrorController(error: Error)
}
