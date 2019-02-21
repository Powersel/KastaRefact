//
//  CollectionControllerState.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/12/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation
import IGListKit

enum CollectionControllerState {
    case initialFetch
    case failure(error: Error)
    case success(items: [ListDiffable])
}
