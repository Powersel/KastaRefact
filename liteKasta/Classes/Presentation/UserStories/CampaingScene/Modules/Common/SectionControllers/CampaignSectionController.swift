//
//  CampaignListController.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/20/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation
import IGListKit

protocol CampaignSectionDelegate: class {
    func userDidSelectViewModel(viewModel: CampaignViewModel)
}

final class CampaignSectionController: ListSectionController {

    var viewModel: CampaignViewModel!
    weak var delegate: CampaignSectionDelegate?

    override init() {
        super.init()

        inset = LocalConstants.Insets
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = self.collectionContext?.containerSize.width else {
            return CGSize.zero
        }
        let sectionWidth = width - LocalConstants.Insets.left * 2
        let seсtionHeight = CampaignCell.desiredHeightFor(columnWidth: sectionWidth)
        return CGSize(width: sectionWidth, height: seсtionHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if let cell: CampaignCell = collectionContext?.dequeueReusableCell(of: CampaignCell.self,
                                                                       for: self,
                                                                       at: index) as? CampaignCell {
            cell.configure(with: viewModel)
            return cell
        }

        return UICollectionViewCell()
    }

    override func didUpdate(to object: Any) {
        viewModel = object as? CampaignViewModel
    }

    override func didSelectItem(at index: Int) {
        super.didSelectItem(at: index)

        delegate?.userDidSelectViewModel(viewModel: viewModel)
    }

    private enum LocalConstants {
        static let Insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }
}
