//
//  VideoPlayerView.swift
//  G-Stream
//
//  Created by Wykee Njenga on 8/03/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import UIKit
import AVFoundation

class AGVideoPlayerViewController: UIView {
    
    //MARK: - UIViews
    lazy var playVideoStream: UIButton = {
        let playBtn = UIButton(type: .custom)
        playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        playBtn.tintColor = .white
        return playBtn
    }()
    
    lazy var closeButton: UIButton = {
        let closeBtn = UIButton(type: .custom)
        closeBtn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.tintColor = .white
        closeBtn.isHidden = false
        return closeBtn
    }()
    
    let indicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()
        return loadingIndicator
    }()
    
    
    let controlsContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    var currentTime: UILabel = {
           let lbl = UILabel()
           lbl.text = "00:00"
           lbl.textColor = .white
           lbl.translatesAutoresizingMaskIntoConstraints = false
           lbl.font = UIFont.systemFont(ofSize: 13)
           lbl.textAlignment = .left
           return lbl
       }()
    
    
    let videoDuration: UILabel = {
        let lbl = UILabel()
        lbl.text = "00:00"
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textAlignment = .right
        return lbl
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .gray
        slider.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        
        slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        return slider
    }()
    
    //MARK: - variables
    var isSkiping = false
    var isPlaying = false
    var videoPlayer: AVPlayer?
    var isControllerHidden: Bool = false
    
    @objc func handlePause() {
        if isPlaying {
            videoPlayer?.pause()
            playVideoStream.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }else{
            videoPlayer?.play()
            playVideoStream.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    //MARK: - Listeners
    @objc func handleClosePlayer() {
        videoPlayer?.pause()
        self.removeFromSuperview()
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        Accessors.AppDelegate.delegate.navigateToHome()
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                self.isSkiping = true
            case .moved:
                if let duration = videoPlayer?.currentItem?.duration {
                    let totalSeconds = CMTimeGetSeconds(duration)
                    let value = Float64(slider.value) * totalSeconds
                    let seekTime = CMTime(value: Int64(value), timescale: 1)
                    videoPlayer?.seek(to: seekTime, completionHandler: { (completed) in })
                }
            case .ended:
                self.isSkiping = false
            default:
                self.isSkiping = false
                break
            }
        }
    }
    
    @objc func showControllers(sender : UITapGestureRecognizer) {
        if isControllerHidden{
            self.slider.isHidden = false
            self.playVideoStream.isHidden = false
            self.closeButton.isHidden = false
            self.hideControllers()
            self.isControllerHidden = false
            self.currentTime.isHidden = false
            self.videoDuration.isHidden = false
            print("HIddem")
        }else{
            self.slider.isHidden = true
            self.playVideoStream.isHidden = true
            self.closeButton.isHidden = true
            self.isControllerHidden = true
            self.currentTime.isHidden = true
            self.videoDuration.isHidden = true
            print("not")
        }
    }
    
    func hideControllers(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            self.slider.isHidden = true
            self.playVideoStream.isHidden = true
            self.closeButton.isHidden = true
            self.isControllerHidden = true
            self.currentTime.isHidden = true
            self.videoDuration.isHidden = true
        })
    }
    

    //MARK: - Initialize our UIView frame and add subviews
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    
        setupPlayerView()
        addSubview(controlsContainer)
        controlsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        controlsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        controlsContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        controlsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        controlsContainer.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        self.controlsContainer.addSubview(playVideoStream)
        playVideoStream.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playVideoStream.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playVideoStream.heightAnchor.constraint(equalToConstant: 100).isActive = true
        playVideoStream.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playVideoStream.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        self.controlsContainer.addSubview(closeButton)
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        //closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: -50).isActive = true
        closeButton.addTarget(self, action: #selector(handleClosePlayer), for: .touchUpInside)
        

        controlsContainer.addSubview(videoDuration)
        controlsContainer.addSubview(currentTime)
        
        videoDuration.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        videoDuration.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        videoDuration.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoDuration.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        currentTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        currentTime.heightAnchor.constraint(equalToConstant: 24).isActive = true
        currentTime.widthAnchor.constraint(equalToConstant: 60).isActive = true
        currentTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true

        controlsContainer.addSubview(slider)
        slider.leadingAnchor.constraint(equalTo: currentTime.trailingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: videoDuration.leadingAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        self.backgroundColor = .black
        
        //self.hideControllers()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.showControllers))
        //self.controlsContainer.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Internal error occurred")
    }
    
    func setupControlBGLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainer.layer.addSublayer(gradientLayer)
    }
    
    func setupPlayerView() {
        
        let liveStreamUrl = URL(string: StreamingVideoURL.videoUrl)
        
        if let url = liveStreamUrl{
            
            let asset = AVURLAsset(url: url, options: ["AVURLAssetHTTPHeaderFieldsKey": Header.headers])
            let playerItem = AVPlayerItem(asset: asset)
            self.videoPlayer = AVPlayer(playerItem: playerItem)
            let playerlayer = AVPlayerLayer(player: videoPlayer)
            self.layer.addSublayer(playerlayer)
            playerlayer.frame = self.frame
            
            videoPlayer?.play()
            videoPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            videoPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsText = String(format: "%2d", Int(seconds) % 60)
                let minutesText = String(format: "%02d",Int(seconds) / 60)
                self.currentTime.text = "\(minutesText):\(secondsText)"
                
                if !self.isSkiping{
                    if let duration = self.videoPlayer?.currentItem?.duration {
                        let durationSeconds = CMTimeGetSeconds(duration)
                        self.slider.value = Float(seconds / durationSeconds)
                    }
                }
            })
       }
               
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    
        if keyPath == "currentItem.loadedTimeRanges" {
            indicator.stopAnimating()
            controlsContainer.backgroundColor = .clear
            isPlaying = true
            
            if let duration = videoPlayer?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d",Int(seconds) / 60)
                self.videoDuration.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        
        layer.sublayers?.forEach({ (sl) in
            sl.frame = layer.bounds
        })
    }
    
}
