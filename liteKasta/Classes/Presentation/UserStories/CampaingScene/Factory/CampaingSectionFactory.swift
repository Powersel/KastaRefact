//
//  SectionFabric.swift
//  liteKasta
//
//  Created by Bogachov on 17.05.2018.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import UIKit
import IGListKit

struct CampaingSectionFactory {

    static func createSoonSectionController(viewController: CollectionViewController,
                                            object: Any) -> ListSingleSectionController {
        
        let controller = ListSingleSectionController(cellClass: NextCampaingsCell.self,
                                                     configureBlock: { (item, cell) in
                                                        guard let soonCell = cell as? NextCampaingsCell,
                                                            let soonCampaigns = item as? NextCampaignViewModel else { return }
                                                        soonCell.configureCell(with: soonCampaigns)
        }, sizeBlock: { (item, context) -> CGSize in
            
            let width = context!.insetContainerSize.width - LocalConstants.Insets.left * 2
            let height = CampaignCell.desiredHeightFor(columnWidth: width)
            
            return CGSize(width: width, height: height)
        })
        
        guard case .success(let items) = viewController.state else {
            fatalError(LocalConstants.ErrorText)
        }
        
        if let singleSelectionDelegate = viewController as? ListSingleSectionControllerDelegate {
            controller.selectionDelegate = singleSelectionDelegate
        }
        
        guard let currentItem = object as? ListDiffable else { return controller }
        let isFirstItem = currentItem.isEqual(toDiffableObject: items.first)
        controller.inset = UIEdgeInsets(top: isFirstItem ? LocalConstants.Insets.top : 0,
                                        left: LocalConstants.Insets.left,
                                        bottom: LocalConstants.Insets.bottom,
                                        right: LocalConstants.Insets.right)
        
        return controller
    }
    
    static func createCampaignSectionController(viewController: CollectionViewController,
                                                object: Any) -> ListSingleSectionController {
        let controller = ListSingleSectionController(cellClass: CampaignCell.self,
                                                     configureBlock: { (item, cell) in
                                                        guard let campaignCell = cell as? CampaignCell,
                                                            let viewModel = item as? CampaignViewModel else { return }
                                                        campaignCell.configure(with: viewModel)
        }, sizeBlock: { (item, context) -> CGSize in
            let width = context!.insetContainerSize.width - LocalConstants.Insets.left * 2
            let height = CampaignCell.desiredHeightFor(columnWidth: width)
            
            return CGSize(width: width, height: height)
        })
        
        guard case .success(let items) = viewController.state else {
            fatalError(LocalConstants.ErrorText)
        }
        
        if let singleSelectionDelegate = viewController as? ListSingleSectionControllerDelegate {
            controller.selectionDelegate = singleSelectionDelegate
        }
        
        guard let currentItem = object as? ListDiffable else { return controller }
        let isFirstItem = currentItem.isEqual(toDiffableObject: items.first)
        controller.inset = UIEdgeInsets(top: isFirstItem ? LocalConstants.Insets.top : 0,
                                        left: LocalConstants.Insets.left,
                                        bottom: LocalConstants.Insets.bottom,
                                        right: LocalConstants.Insets.right)
        
        return controller
    }
    
    private enum LocalConstants {
        static let Insets: UIEdgeInsets = UIEdgeInsets(top: 32,
                                                       left: 16,
                                                       bottom: 16,
                                                       right: 16)
        static let ErrorText = "Fetch state != .success, the collection should have no sections, yet the adapter requests one, wtf?"
    }
}
