//
//  CampaignsViewController.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/14/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation
import IGListKit
import Moya

final class CampaignsViewController: CollectionListViewController {

    let presenter: ListPresenter
    private lazy var adapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    // MARK: - Initialisation and Dealoccation
    init(presenter: ListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported.")
    }

    // MARK: - UIViewController Life Cycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .appBackground

        collectionView.backgroundColor = view.backgroundColor
        view.addSubview(collectionView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.collectionView = collectionView
        adapter.dataSource = self

        presenter.fetch()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let statusBarFrame = UIApplication.shared.statusBarFrame.height
        collectionView.frame = CGRect(x: 0,
                                      y: statusBarFrame,
                                      width: view.frame.width,
                                      height: view.frame.height - statusBarFrame)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func reloadListData(with models: [ListDiffable]) {
        super.reloadListData(with: models)

        state = .success(items: models)
        adapter.performUpdates(animated: true, completion: nil)
    }

    override func showNoNetworkErrorController(error: Error) {
        super.showNoNetworkErrorController(error: error)

        state = .failure(error: error)
        adapter.performUpdates(animated: true, completion: nil)
    }

    enum LocalConstants {
        static let ErrorViewHeight: CGFloat = 100
        static let ErrorViewWidthInset: CGFloat = 16
    }
}

// MARK: - ListAdapterDataSource
extension CampaignsViewController: ListAdapterDataSource {

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        switch self.state {
        case .success(items: let items):
            return items
        case .initialFetch, .failure(error: _):
            return []
        }
    }

    func listAdapter(_ listAdapter: ListAdapter,
                     sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is NextCampaignViewModel:
            let controller =  NextCampaingsSectionController()
            controller.delegate = self
            return controller
        case is CampaignViewModel:
            let controller = CampaignSectionController()
            controller.delegate = self
            return controller
        default:
            fatalError("Not supported.")
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch state {
        case .initialFetch:
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.startAnimating()
            return activityIndicator

        case .failure(error: let error):
            return makeErrorView(with: error)

        case .success(items: _):
            return nil
        }
    }

    private func makeErrorView(with error: Error) -> UIView {
        let errorView = CampaingsGeneralErrorView(frame: CGRect(x: 16,
                                                                y: view.frame.midY/2,
                                                                width: view.frame.width - LocalConstants.ErrorViewWidthInset * 2,
                                                                height: LocalConstants.ErrorViewHeight))
        errorView.delegate = self
        errorView.configureUI(with: error)

        return errorView
    }
}

// MARK: – CampaignSectionDelegate
extension CampaignsViewController: CampaignSectionDelegate {
    func userDidSelectViewModel(viewModel: CampaignViewModel) {
        presenter.openCampaingWebURL(with: viewModel.codename)
    }
}

// MARK: – NextCampaingsSectionDelegate
extension CampaignsViewController: NextCampaingsSectionDelegate {
    func userDidNextCampaingsButton() {
        presenter.openSoonCampaingsWebURL()
    }
}

extension CampaignsViewController: ErrorableViewDelegate {
    func callRetry() {
        retry()
    }
}

// MARK: - Actions
extension CampaignsViewController {
    
    @objc private func retry() {
        state = .initialFetch
        presenter.fetch()
    }
}
