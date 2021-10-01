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
    @IBOutlet weak var image: MyImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var gradientLayer: CAGradientLayer?
    let nasaBlue = UIColor(red:0.02, green:0.24, blue:0.58, alpha:1)
    var activtyIndicator: NVActivityIndicatorView?
    var animate = true
    var apod: APODElement? {
        didSet{
            guard let apod = apod else { return }
            let url = apod.mediaType == ApodMediaType.image ? apod.url : apod.thumbnailUrl
            dataImage = url
            loadData(data: apod)
        }
    }
    var dataImage: String? {
        didSet {
            DispatchQueue.main.async {
                print(self.dataImage!)
                self.image.loadImage(self.apod!.url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchData(url: NetworkManagerConstants.apodAPIURL){ [weak self] result in
                guard let strongSelf = self else {return}
                switch result {
                case .success(let data):
                strongSelf.apod = data
                case .failure(_):
                    print("error")
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
        activtyIndicator = NVActivityIndicatorView(frame: image.frame, type: .orbit, color: .white, padding: 200)
        guard let activityIndicatorU = self.activtyIndicator else { return }
        gradientView.addSubview(activityIndicatorU)
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
//        let url = data.mediaType == ApodMediaType.image ? data.url : data.thumbnailUrl
//        if !isMockData {
//            guard let imageUrl = url else { return}
//            self.dataImage = imageUrl
//        }
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.titleLabel.text = data.title
            strongSelf.subtitleLabel.text = subtitle
            strongSelf.explanationLabel.text = data.explanation
//            if isMockData {
//                strongSelf.image.image = #imageLiteral(resourceName: "apod-example")
//            }
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
extension LandingViewController {
    func fetchData(url: String, completion: @escaping (Result<APODElement, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request){ (data, response, error) in
            
            guard let dataUnwrap = data else { return }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                let stausCode = httpResponse.statusCode
                switch stausCode {
                case 200..<300:
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let decodedObject = try decoder.decode(APODElement.self, from: dataUnwrap)
                        completion(.success(decodedObject))
                    } catch {
                        print("parsing error")
                    }
                default:
                    print("Unexpected Error")
                }
            }
        }
        task.resume()
    }
    
}
extension UIImageView {
    func loadImage(_ urlString: String, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let url = URL(string: urlString) else { return }
            
            let session = URLSession(configuration: .default)
            
            let downloadImageTask = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let imageData = data {
                        DispatchQueue.main.async {[weak self] in
                            var image = UIImage(data: imageData)
                            self?.image = nil
                            self?.image = image
                            image = nil
                            completion?()
                        }
                    }
                }
                session.finishTasksAndInvalidate()
            }
            downloadImageTask.resume()
        }
        }
        
}

