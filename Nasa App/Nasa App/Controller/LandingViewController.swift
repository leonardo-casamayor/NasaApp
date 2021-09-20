//
//  LandingViewController.swift
//  Nasa App
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import UIKit
struct MockApod {
    let date, explanation: String
    let hdurl: String?
    let mediaType: ApodMediaType
    let title: String
    let url: String
    let copyright: String?
    let thumbnailUrl: String?
}
struct APODElement: Codable {
    let date, explanation: String
    let hdurl: String?
    let mediaType: ApodMediaType
    let title: String
    let url: String
    let copyright: String?
    let thumbnailUrl: String?

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl, title, url, copyright
        case mediaType = "media_type"
        case thumbnailUrl = "thumbnail_url"
    }
}
typealias Apod = [APODElement]
    
enum ApodMediaType: String, Codable {
    case image = "image"
    case video = "video"
}
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        networkManager.retrieveApodData { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    
                    self?.loadData(data: data)
                    
                }
            case .failure(_):
                return
            }
        }
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
    private func loadData(data: APODElement) {
        let url = data.mediaType == ApodMediaType.image ? data.url : data.thumbnailUrl
        guard let imageUrl = url else {
            return
        }
        image.setImageFrom(imageUrl)
        titleLabel.text = data.title
        guard let copyright = data.copyright else {
            return
        }
        let date = data.date.replacingOccurrences(of: "/", with: "-")
        let subtitle = copyright != "" ? "\(copyright.trunc(length: 25))  / \(date)" : date
        subtitleLabel.text = subtitle
        explanationLabel.text = data.explanation
    }
}

extension String {
    func trunc(length: Int, trailing: String = "…") -> String {
       return (self.count > length) ? self.prefix(length) + trailing : self
     }
}
