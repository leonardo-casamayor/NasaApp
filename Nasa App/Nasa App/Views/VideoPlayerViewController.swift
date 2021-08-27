//
//  VideoPlayerViewController.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 25/08/2021.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var playToForward: NSLayoutConstraint!
    @IBOutlet weak var playToBackward: NSLayoutConstraint!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    //MARK: - Attributes
    var areViewsHidden = false
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isVideoPlaying = false
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let size = UIScreen.main.bounds.size
        print(size)
        updateConstraints(size: size)
    }
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVideoPlayer()
        
        print(size)
        
    }
    //MARK: - viewWillTransition
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateConstraints(size: size)
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    
    //MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.currentItem?.removeObserver(self, forKeyPath: "duration")
    }
    
    //MARK: - IBActions
    @IBAction func playPressed(_ sender: UIButton) {
        if isVideoPlaying {
            player.pause()
            isVideoPlaying = !isVideoPlaying
            sender.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
        } else {
            player.play()
            isVideoPlaying = !isVideoPlaying
            sender.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
    }
    
    @IBAction func forwardPressed(_ sender: UIButton) {
        guard let duration = player.currentItem?.duration else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 10.0
        
        if newTime < (CMTimeGetSeconds(duration)) {
            let time: CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
            player.seek(to: time)
        }
    }
    
    @IBAction func backwardPressed(_ sender: UIButton) {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 10.0
        
        if newTime < 0 {
            newTime = 0
        }
        let time : CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
        player.seek(to: time)
    }
    @IBAction func backPressed(_ sender: UIButton) {
        print("We will implement this shortly, keep enjoying the video.")
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        player.seek(to: CMTimeMake(value: Int64(sender.value * 1000), timescale: 1000))
    }
    
    
}

extension VideoPlayerViewController {
    
    //MARK: - VideoPlayerSetup
    func setUpVideoPlayer() {
        let url = URL(string: "https://s3.eu-west-2.amazonaws.com/gymstar-app/7A77786B4870594D7165625046614E74/post_videos/postVideo1582781434.005436.mp4")!
        player = AVPlayer(url: url)
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        addTimeObserver()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        videoView.layer.addSublayer(playerLayer)
    }
    
    //MARK: - Helper Methods
    func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours, minutes, seconds])
        } else {
            return String(format: "%02i:%02i", arguments: [minutes, seconds])
        }
    }
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = self?.player.currentItem else { return }
            self?.timeSlider.maximumValue = Float(currentItem.duration.seconds)
            self?.timeSlider.minimumValue = 0
            self?.timeSlider.value = Float(currentItem.currentTime().seconds)
            self?.currentTimeLabel.text = self?.getTimeString(from: currentItem.currentTime())
        })
    }
    
    //MARK: - Observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            self.durationLabel.text = getTimeString(from: player.currentItem!.duration)
        }
    }
    //MARK: - Constraints
    func updateConstraints(size: CGSize) {
        let height = size.height
        let width = size.width
        let isIpadHorizontalLarge = width > height && width > 1200.00
        let isIpadHorizontal = width > height && width > 1000.00
        let isIpadVertical = width < height && width > 1000.00
        let isPadVerticalSmall = width < height && width > 750.00
        let isIphoneVertical = width < height && height < 897.00
        let isIPhoneHorizontal = width > height && width < 897
        playToForward.constant = width * 0.1
        playToBackward.constant = width * 0.1
        if isIpadVertical || isIpadHorizontalLarge || isPadVerticalSmall {
            topViewHeight = modifyConstraintMultiplier(constraint: topViewHeight, multiplier: 0.05)
            bottomViewHeight = modifyConstraintMultiplier(constraint: bottomViewHeight, multiplier: 0.05)
        } else if isIphoneVertical || isIpadHorizontal {
            topViewHeight = modifyConstraintMultiplier(constraint: topViewHeight, multiplier: 0.07)
            bottomViewHeight = modifyConstraintMultiplier(constraint: bottomViewHeight, multiplier: 0.07)
        } else if isIPhoneHorizontal {
            topViewHeight = modifyConstraintMultiplier(constraint: topViewHeight, multiplier: 0.1)
            bottomViewHeight = modifyConstraintMultiplier(constraint: bottomViewHeight, multiplier: 0.1)
        }
    }
    
    func modifyConstraintMultiplier(constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = constraint.constraintWithMultiplier(multiplier)
        view.removeConstraint(constraint)
        view.addConstraint(newConstraint)
        view.layoutIfNeeded()
        return newConstraint
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
