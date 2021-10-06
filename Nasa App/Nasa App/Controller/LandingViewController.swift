//
//  LandingViewController.swift
//  Nasa App
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import UIKit
import SDWebImage

class LandingViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var gradientLayer: CAGradientLayer?
    let nasaBlue = UIColor(red:0.02, green:0.24, blue:0.58, alpha:1)
    var networkManager = NetworkManager()
    var animate = true
    var apod: APODElement? {
            didSet {
                guard let apodData = apod else { return }
                loadData(data: apodData)
                prepareImage(data: apodData)
            }
        }
    var apodImageString: String? {
            didSet {
                DispatchQueue.main.async {
                    guard let imageUrl = self.apodImageString else { return }
                    self.image.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
                    self.image.sd_setImage(with: URL(string: imageUrl),
                                           placeholderImage: nil,
                                           options: .highPriority)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        DispatchQueue.global(qos: .userInteractive).async {
            self.networkManager.retrieveApodData { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let data):
                    strongSelf.apod = data
                case .failure(_):
                    strongSelf.loadData(data: LandingConstants.apodMock, isMockData: true)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if animate{
            animations()
            animate = false
        }
    }
    
    private func animations() {
        titleLabel.fadeIn(1, delay: 0)
        subtitleLabel.fadeIn(1, delay: 0.5)
        explanationLabel.fadeIn(1, delay: 1)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.gradientLayer?.frame = self.gradientView.bounds
        }
    }
    
    private func setupViewController() {
        view.backgroundColor = nasaBlue
        explanationLabel.backgroundColor = nasaBlue
        scrollView.contentInsetAdjustmentBehavior = .never
        makeGradient(gradientView)
    }
    
    private func makeGradient(_ view: UIView) {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [UIColor.clear.cgColor, nasaBlue.cgColor]
        view.backgroundColor = UIColor.clear
        guard let layer = gradientLayer else { return }
        view.layer.addSublayer(layer)
    }
    
}

extension LandingViewController {
    private func loadData(data: APODElement, isMockData: Bool = false) {
        let copyright = data.copyright ?? ""
        let date = data.date.replacingOccurrences(of: "/", with: "-")
        let subtitle = copyright != "" ? "\(copyright.trunc(length: 25))  / \(date)" : date
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.titleLabel.text = data.title
            strongSelf.subtitleLabel.text = subtitle
            strongSelf.explanationLabel.text = data.explanation
            /// use a generic image if it's mockdata
            if isMockData {
                strongSelf.image.image = #imageLiteral(resourceName: "apod-example")
            }
        }
    }
    
    private func prepareImage(data: APODElement) {
        let url = data.mediaType == ApodMediaType.image ? data.url : data.thumbnailUrl
        guard let imageUrl = url else { return}
        self.apodImageString = imageUrl
    }
}

extension String {
    func trunc(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
}

extension UIView {
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        })
    }
}
