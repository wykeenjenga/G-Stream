//
//  AGTabBarController.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import UIKit

class AGTabBarController: UIViewController{
    @IBOutlet weak var menuBtn: AGBindingButton!
    @IBOutlet weak var headerTitle: UILabel!
    
    @IBOutlet private var tabTitles: [UILabel]!
    @IBOutlet private var tabs: [AGBindingButton]!
    @IBOutlet private var containerViews: [UIView]!
    
    private var selectedTab: Int = 0
    
    var shouldHighlightText: Bool = false
    static var shared : AGTabBarController?
    var isFeedsNeedToBeRefreshed: Bool = false
    var messageIdOfNotification = ""
    var selectedTabIndex: Int = 0 {
        didSet {
            updateSelection(with: tabs[selectedTabIndex])
        }
    }
    
    var viewControllers: [UIViewController] = [] {
        didSet {
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        for (index, viewController) in viewControllers.enumerated() {
            ViewEmbedder.embed(parent: self,
                               container: containerViews[index],
                               child: viewController,
                               previous: nil)
        }
        let firstTab = tabs[selectedTabIndex]
        firstTab.isSelected = true
        if shouldHighlightText {
            let firstTabTitle = tabTitles[selectedTabIndex]
            firstTabTitle.textColor = UIColor(named: "orange")
        }
        AGTabBarController.shared = self
        
    }
    
    @IBAction func tabButtonTapped(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity },
                       completion: { Void in()
                        sender.isUserInteractionEnabled = true
        })
        self.updateSelection(with: sender)
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
    
    private func updateSelection(with sender: UIButton) {
        print("....SELECTED TAB is>>>|\(sender.tag)")
        if selectedTab == sender.tag {
            let vc = viewControllers[selectedTab]
            if let viewC = vc as? UINavigationController, let home = viewC.viewControllers[0] as? AGLiveEventViewController, home.liveEventsTable.contentOffset.y != 0 {
            }
            vc.navigationController?.popToRootViewController(animated: true)
        } else {
            selectedTab = sender.tag
        
            for containerView in containerViews {
                if containerView.tag == sender.tag {
                    containerView.isHidden = false
                } else {
                    containerView.isHidden = true
                }
            }
            for tab in tabs {
                if tab.tag == sender.tag {
                    tab.isSelected = true
                } else {
                    tab.isSelected = false
                }
            }
            if shouldHighlightText {
                for tabTitle in tabTitles {
                    if tabTitle.tag == sender.tag {
                        tabTitle.textColor = UIColor(named: "orange")
                    } else {
                        tabTitle.textColor = Theme.currentTheme().textColor
                    }
                }
            }
            
            headerTitle.layer.removeAllAnimations()
            
            if sender.tag == 0{
                self.headerTitle.text = "Live Matches"
            }else{
                self.headerTitle.text = "Scheduled Matches"
            }
        }
    }
}

class ViewEmbedder {
    class func embed(parent: UIViewController,
                     container: UIView,
                     child: UIViewController,
                     previous: UIViewController?) {
        
        if let previous = previous {
            removeFromParent(vc: previous)
        }
        child.willMove(toParent: parent)
        parent.addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: parent)
        let w = container.frame.size.width;
        let h = container.frame.size.height;
        child.view.frame = CGRect(x: 0, y: 0, width: w, height: h)
    }
    
    class func removeFromParent(vc:UIViewController) {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    class func embed(withIdentifier id: String,
                     parent: UIViewController,
                     container: UIView,
                     completion: ((UIViewController)->Void)? = nil){
        let vc = parent.storyboard!.instantiateViewController(withIdentifier: id)
        embed(
            parent: parent,
            container: container,
            child: vc,
            previous: parent.children.first
        )
        completion?(vc)
    }
}
