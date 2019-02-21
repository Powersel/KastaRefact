//
//  LS.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/14/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation

enum LS {

}

// MARK: - CollectionCell
//UICollectionViewCell localization keys - values
extension LS {

    enum CollectionCell {

        // NextCampaings collectionView cell
        enum NextCampaings {
            static let Title = "LS.CollectionCell.NextCampaings.Title".localized()
            static let ButtonTitle = "LS.CollectionCell.NextCampaings.Button.Title".localized()
        }
    }
}

// MARK: - Views
//Views outlets localization keys - values
extension LS {

    enum View {

        // Campaings general error view
        enum CampaingsGeneralError {
            static let RetryButtonTitle = "LS.View.CampaingsGeneralError.RetryButton.Title".localized()
        }
    }
}

// MARK: - Error states
//Error states localization keys - values
extension LS {

    enum ErrorStates {

        // Network errors
        enum Network {
            static let LostConnection = "LS.ErrorStates.Network.Connection".localized()
            static let ModelsMapping = "LS.ErrorStates.Network.ModelsMapping".localized()
            static let General = "LS.ErrorStates.Network.General".localized()
        }
    }
}
