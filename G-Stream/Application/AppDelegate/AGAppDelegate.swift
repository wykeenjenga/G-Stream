//
//  AppDelegate.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//

import UIKit

@main
class AGAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    func navigateToHome() {
        
    }

    
    func navigateToOnboarding() {
        if let onboarding = Accessors.Storyboard.main.instantiate(with: "OnBoardingScreen") as? UIViewController {
            if UIApplication.shared.keyWindow == nil {
                self.window?.rootViewController = onboarding
                self.window?.makeKeyAndVisible()
            } else {
                UIApplication.shared.keyWindow?.setRootViewController(onboarding, options: UIWindow.TransitionOptions(direction: .toRight))
            }
        } else {
            assertionFailure("Could not load onboarding screen")
        }
    }
}

