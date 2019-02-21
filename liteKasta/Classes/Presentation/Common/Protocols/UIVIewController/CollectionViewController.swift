//
//  CollectionViewControllerProtocol.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/14/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewController: ReloadableList, ErrorableController {
    var state: CollectionControllerState { get set }
    var collectionView: UICollectionView { get set }
}

