//
//  CollectionViewController.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/14/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation
import IGListKit

class CollectionListViewController: UIViewController, CollectionViewController {

    var state: CollectionControllerState = .initialFetch
    var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false,
                                                                                                           scrollDirection: .vertical,
                                                                                                           topContentInset: 0,
                                                                                                           stretchToEdge: false))
    func reloadListData(with models: [ListDiffable]) {}
    func showNoNetworkErrorController(error: Error) {}
}
