//
//  AppDelegate.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//

import UIKit

@UIApplicationMain
class AGAppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate{
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        
        //loadTheInitialScreen()
        navigateToOnboarding()
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
        if let navHome = Accessors.Storyboard.main.instantiate(with: "AGHomeController") as? UIViewController {
            if UIApplication.shared.keyWindow == nil {
                self.window?.rootViewController = navHome
                self.window?.makeKeyAndVisible()
            }
        } else {
            assertionFailure("Could not load home screen")
        }
    }

    func navigateToOnboarding() {
        if let onboarding = Accessors.Storyboard.main.instantiate(with: "OnBoardingScreen") as? UIViewController {
            if UIApplication.shared.keyWindow == nil {
                self.window?.rootViewController = onboarding
                self.window?.makeKeyAndVisible()
            }
        } else {
            assertionFailure("Could not load onboarding screen")
        }
    }
}

