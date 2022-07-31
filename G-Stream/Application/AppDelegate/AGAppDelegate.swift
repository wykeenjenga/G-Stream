//
//  AppDelegate.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//

import UIKit

@UIApplicationMain
class AGAppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate{
    
    var window: UIWindow? //= UIWindow(frame: UIScreen.main.bounds)
    let appDiContainer = AGDIContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        
        loadTheInitialScreen()
        
        return true
    }
    
    private func loadTheInitialScreen() {
        let isOnboardingShown = UserDefaults.standard.bool(forKey: "isOnboarding")
        if isOnboardingShown{
            navigateToHome()
        }else{
            navigateToOnboarding()
        }
    }
    
    func navigateToHome() {
        if let tabBarController = Accessors.Storyboard.tabBar.instantiate(with: "AGTabBarController") as? AGTabBarController {
            
            var viewControllers = [UIViewController]()
            
            let liveEventsVC = Accessors.AppDelegate.delegate.appDiContainer.makeLiveDIContainer().makeLiveViewController()
            let navLiveEventsVC = UINavigationController(rootViewController: liveEventsVC)
            viewControllers.append(navLiveEventsVC)
            
            let scheduledEventsVC = Accessors.AppDelegate.delegate.appDiContainer.makeScheduleDIContainer().makeScheduleViewController()
            let navScheduledEventsVC = UINavigationController(rootViewController: scheduledEventsVC)
            viewControllers.append(navScheduledEventsVC)
            
            tabBarController.viewControllers = viewControllers
            
            if UIApplication.shared.keyWindow == nil {
                self.window?.rootViewController = tabBarController
                self.window?.makeKeyAndVisible()
            } else {
                UIApplication.shared.keyWindow?.setRootViewController(tabBarController, options: UIWindow.TransitionOptions(direction: .toRight))
            }
            
        } else {
            assertionFailure("Could not load the home tabBar")
        }
    }

    func navigateToOnboarding() {
        if let onboarding = Accessors.Storyboard.main.instantiate(with: "OnBoardingScreen") as? UIViewController {
            if UIApplication.shared.keyWindow == nil {
                self.window?.rootViewController = onboarding
                self.window?.makeKeyAndVisible()
            }else{
                UIApplication.shared.keyWindow?.setRootViewController(onboarding, options: UIWindow.TransitionOptions(direction: .toRight))
            }
        } else {
            assertionFailure("Could not load onboarding screen")
        }
    }
}

