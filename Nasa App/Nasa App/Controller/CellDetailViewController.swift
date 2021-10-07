//
//  CellDetailViewController.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 24/08/2021.
//

import Foundation
import UIKit
import SwiftUI

class CellDetailViewController: UIViewController {
    var addFavButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: CellDetailConstants.favHeart), style: .done, target: self, action: #selector(addFavorite))
    var href: String?
    var thumbnailUrl: String?
    var nasaData: NasaData?
    var assetUrl: String?
    let networkManager = NetworkManager()
    private lazy var swiftView = makeSwiftUIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        guard let href = href else { return }
        networkManager.retrieveAssets(assetsUrl: href) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let urls):
                guard let data = strongSelf.nasaData else { return }
                guard let url = strongSelf.findUrl(array: urls, mediaType: data.mediaType) else {
                    return
                }
                strongSelf.assetUrl = NetworkManager.encodeURL(urlString: url)
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.addSwiftUIView()
                    strongSelf.setupNavButtons()
                    strongSelf.hideBars(size: UIScreen.main.bounds.size)
                            }
            case .failure(_):
                return
            }
        }
    }
    
    private func findUrl (array: [String], mediaType: MediaType) -> String? {
        let targetSubstring = mediaType == MediaType.image ? "small.jpg" : "mobile.mp4"
        guard let index = array.firstIndex(where: {$0.contains(targetSubstring)}) else { return thumbnailUrl }
        return array[index].replacingOccurrences(of: "http:", with: "https:")
    }
    
    private func addSwiftUIView() {
        addChild(swiftView)
        view.addSubview(swiftView.view)
        swiftView.didMove(toParent: self)
        let constraints = [
            swiftView.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftView.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            swiftView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftView.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func makeSwiftUIView() -> UIHostingController<CellDetailView> {
        guard let data = nasaData, let url = assetUrl else { return UIHostingController() }
        let nasaDate = convertDate(data: data)
        let swiftDetailView = CellDetailView(nasaData: data, assetUrl: url, nasaDateString: nasaDate)
        let headerVC = UIHostingController(rootView: swiftDetailView)
        headerVC.view.translatesAutoresizingMaskIntoConstraints = false
        return headerVC
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        hideBars(size: size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let nasaType = nasaData?.mediaType else { return }
        nasaType == .video ? RotationHelper.lockOrientation(.allButUpsideDown) : RotationHelper.lockOrientation(.portrait)
        
        
    }
    func convertDate(data: NasaData) -> String {
        let dateString: String = DateFormat.formatDate(dateString: data.dateCreated)
        return dateString

    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showBars()
        RotationHelper.lockOrientation(.portrait)
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    private func setupNavButtons() {
        self.navigationItem.title = nasaData?.nasaID
        self.navigationItem.rightBarButtonItem = self.addFavButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func hideBars(size: CGSize){
        let isLandscape = size.width > size.height
        navigationController?.hidesBarsWhenVerticallyCompact = false
        tabBarController?.tabBar.isHidden = isLandscape ? true : false
        extendedLayoutIncludesOpaqueBars = isLandscape ? true : false
        navigationController?.setNavigationBarHidden(isLandscape ? true : false, animated: true)
        }
    
    private func showBars() {
        navigationController?.hidesBarsWhenVerticallyCompact = true
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension UIViewController {
    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)

        // Add as a child of the current view controller.
        addChild(hostingController)

        // Add the SwiftUI view to the view controller view hierarchy.
        view.addSubview(hostingController.view)

        // Setup the contraints to update the SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        // Notify the hosting controller that it has been moved to the current view controller.
        hostingController.didMove(toParent: self)
    }
    
    @objc func addFavorite(sender: AnyObject) {
        print(CellDetailConstants.implementMe)
    }
}
