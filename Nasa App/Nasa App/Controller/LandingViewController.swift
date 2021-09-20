//
//  LandingViewController.swift
//  Nasa App
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import UIKit
import NVActivityIndicatorView

class LandingViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var gradientLayer: CAGradientLayer?
    let nasaBlue = UIColor(red:0.02, green:0.24, blue:0.58, alpha:1)
    var activtyIndicator: NVActivityIndicatorView?
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
    override func viewDidAppear(_ animated: Bool) {
        animations()
    }
    
    private func animations() {
        titleLabel.fadeIn(2, delay: 0)
        subtitleLabel.fadeIn(2, delay: 1)
        explanationLabel.fadeIn(2, delay: 2)
        activtyIndicator = NVActivityIndicatorView(frame: image.frame, type: .orbit, color: .white, padding: 200)
        gradientView.addSubview(activtyIndicator!)
        activtyIndicator!.startAnimating()
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
            let request = URLRequest(url: URL(string: imageUrl)!)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, _, _) in
                    guard let data = data else {
                        return
                    }
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        // Configure Thumbnail Image View
                        self?.image.image = image
                        self?.activtyIndicator!.stopAnimating()
                    }
                }
            dataTask.resume()
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

extension UIView {
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        })
    }
}
