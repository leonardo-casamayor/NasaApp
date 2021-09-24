//
//  CollectionViewController.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 30/08/2021.
//

import UIKit

class PopularViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    let dataLoader = DataLoader()
    private let collectionView = UICollectionView(frame: .zero,collectionViewLayout: CollectionViewHelper.generateLayout(size: CollectionViewConstants.LayoutSize(columns: 2, height: 1/3)))
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        setupCollectionViewController()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        dataLoader.request(endpoint: ApiQuery.generateURL(api: APIadress.mediaLibrary,
                                                           endpoint: EndpointAdress.search,
                                                           queryType: QueryType.complexQuery,
                                                           queryDictionary: MediaApiConstants.defaultPopularSearch).url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RotationHelper.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RotationHelper.lockOrientation(.all)
    }
    
    private func setupCollectionViewController() {
        view.addSubview(collectionView)
        view.backgroundColor = GeneralConstants.nasaBlue
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        CollectionViewHelper.setupCollectionView(self, collectionView: collectionView, traitCollection: traitCollection, identifier: CollectionCell.PopularIdentifier)
        collectionViewConstraints()
    }
    
    private func setupSearchBar() {
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    private func collectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    }
    
    private func sendToCellDetails() {
        // setup here any data we will pass to the next viewcontroller
        guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CellDetailViewController") as? CellDetailViewController else { return }
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
        
}

//MARK: CollectionViewDataSource
extension PopularViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.PopularIdentifier, for: indexPath)
        return cell
    }
    
}

//MARK: Compositional Layout
extension PopularViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        CollectionViewHelper.traitCollectionDidChange(collectionView: collectionView, traitCollection: traitCollection)
    }
}

extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendToCellDetails()
    }
}
