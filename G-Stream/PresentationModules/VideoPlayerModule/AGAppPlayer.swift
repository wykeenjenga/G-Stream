//
//  AppPlayer.swift
//  G-Stream
//
//  Created by Wykee Njenga on 8/03/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//
import UIKit
import AVFoundation
import AVKit

class AGAppPlayer: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoPlayer = AGVideoPlayerViewController()
        videoPlayer.isUserInteractionEnabled = true
        
        self.view.addSubview(videoPlayer)
        videoPlayer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        videoPlayer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        videoPlayer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        videoPlayer.heightAnchor.constraint(equalToConstant: 400).isActive = true
        self.view.layoutIfNeeded()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        self.view.backgroundColor = .black
    }
}

