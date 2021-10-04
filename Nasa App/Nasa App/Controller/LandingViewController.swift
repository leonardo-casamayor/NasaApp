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
    var animate = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        networkManager.retrieveApodData { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    strongSelf.loadData(data: data)
                }
            case .failure(_):
                return
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
        activtyIndicator = NVActivityIndicatorView(frame: image.frame, type: .orbit, color: .white, padding: 200)
        guard let activityIndicatorU = self.activtyIndicator else { return }
        gradientView.addSubview(activityIndicatorU)
        activityIndicatorU.startAnimating()
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
        guard let urlRequest = URL(string: imageUrl) else { return }
        let request = URLRequest(url: urlRequest)
        let dataTask = URLSession.shared.dataTask(with: request) {(data, _, _) in
            guard let data = data else {
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.image.image = image
                guard let activtyIndicator = strongSelf.activtyIndicator else { return }
                activtyIndicator.stopAnimating()
            }
        }
        dataTask.resume()
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.titleLabel.text = data.title
        }
        guard let copyright = data.copyright else {
            return
        }
        let date = data.date.replacingOccurrences(of: "/", with: "-")
        let subtitle = copyright != "" ? "\(copyright.trunc(length: 25))  / \(date)" : date
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.subtitleLabel.text = subtitle
            strongSelf.explanationLabel.text = data.explanation
        }
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
