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
        let addFavButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: CellDetailConstants.favHeart), style: .done, target: self, action: #selector(self.favoriteToggle))
        self.navigationItem.rightBarButtonItem = addFavButton
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
    
    @objc func favoriteToggle() {
        let user = UsersLoader().load()
        guard let data = nasaData else { return }
        let favorites = getFavorites(forUser: user.username)
        let valueExists = favorites.contains { $0.nasaId == data.nasaID }
        if valueExists {
            removeFavorite(favorites, forUser: user.username)
        }
        else {
            addFavorite(forUser: user.username, withFavorites: favorites)
        }
    }
    
    private func getFavorites(forUser user: String) -> [FavoriteModel] {
        guard let data = UserDefaults.standard.data(forKey: "Favorites/\(user)") else { return [] }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([FavoriteModel].self, from: data)
        }
        catch {
            return []
        }
    }
    
    private func removeFavorite(_ favorites: [FavoriteModel], forUser user: String){
        guard let data = nasaData else { return }
        let filteredFavorites = favorites.filter { $0.nasaId == data.nasaID }
        rewriteFavorites(filteredFavorites, forUser: user)
    }
    
    private func addFavorite(forUser user: String, withFavorites favorites: [FavoriteModel]){
        guard let favorite = createFavoriteItem() else { return }
        var newFavorites = favorites
        newFavorites.insert(favorite, at: 0)
        rewriteFavorites(newFavorites, forUser: user)
    }
    
    private func createFavoriteItem() -> FavoriteModel? {
        guard let data = nasaData,
              let url = assetUrl,
              let thumbUrl = thumbnailUrl else { return nil }
        let type = data.mediaType == MediaType.video ? FavoriteType.video : FavoriteType.image
        return FavoriteModel(nasaId: data.nasaID, assetLink: url, thumbnailLink: thumbUrl, mediaType: type, title: data.title, date: data.dateCreated, description: data.description)
    }
    
    private func rewriteFavorites( _ favorites: [FavoriteModel], forUser user: String){
        do {
            let encoder = JSONEncoder()
            let ecodedFavorite = try encoder.encode(favorites)
            UserDefaults.standard.set(ecodedFavorite, forKey: "Favorites/\(user)")
        }
        catch {
            showAlert()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: AlertConstants.favoritesAlertTitle, message: AlertConstants.favoritesAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
