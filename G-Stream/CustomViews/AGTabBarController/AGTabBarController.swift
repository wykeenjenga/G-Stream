//
//  AGTabBarController.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import UIKit

class AGTabBarController: UITabBarController{
    
    @IBInspectable var initIndex: Int = 1
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = initIndex
        tabBar.unselectedItemTintColor = UIColor.white
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                self.self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }

}
