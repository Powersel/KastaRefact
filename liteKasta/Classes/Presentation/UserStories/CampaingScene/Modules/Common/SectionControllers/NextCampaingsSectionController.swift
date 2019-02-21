
//
//  NextCampaignListController.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/20/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation
import IGListKit

protocol NextCampaingsSectionDelegate: class {
    func userDidNextCampaingsButton()
}

final class NextCampaingsSectionController: ListSectionController {

    var viewModel: NextCampaignViewModel!
    weak var delegate: NextCampaingsSectionDelegate?

    override init() {
        super.init()

        inset = LocalConstants.Insets
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = self.collectionContext?.containerSize.width else {
            return CGSize.zero
        }

        let size = calculateDynamicHeight(with: viewModel, maxWidth: width)
        return size
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
      if let cell: NextCampaingsCell = collectionContext?.dequeueReusableCell(of: NextCampaingsCell.self,
                                                                    for: self,
                                                                    at: index) as? NextCampaingsCell {
        cell.configureCell(with: viewModel)
        return cell
        }

        return UICollectionViewCell()
    }

    override func didUpdate(to object: Any) {
        viewModel = object as? NextCampaignViewModel
    }

    override func didSelectItem(at index: Int) {
        super.didSelectItem(at: index)

        delegate?.userDidNextCampaingsButton()
    }

    private func calculateDynamicHeight(with viewModel: NextCampaignViewModel,
                                       maxWidth: CGFloat) -> CGSize {
        let width = maxWidth - LocalConstants.Insets.left * 2
        var height = LocalConstants.CellBaseHeigth

        if let _ = viewModel.firstTitle {
            height += LocalConstants.TextInfoViewBaseHeight
        }

        if let _ = viewModel.secondDescr {
            height += LocalConstants.TextInfoViewBaseHeight
        }

        if let _ = viewModel.thirdDescr {
            height += LocalConstants.TextInfoViewBaseHeight
        }

        return CGSize(width: width, height: height)
    }

    private enum LocalConstants {
        static let Insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        static let CellBaseHeigth: CGFloat = 16 + 16 + 12 + 16 + 16
        static let TextInfoViewBaseHeight: CGFloat = 64
    }
}
