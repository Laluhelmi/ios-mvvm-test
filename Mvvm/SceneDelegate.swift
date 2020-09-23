//
//  SceneDelegate.swift
//  Mvvm
//
//  Created by laluheri on 9/17/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        self.loadBaseController()
    }
    
    func loadBaseController() {
       let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       guard let window = self.window else { return }
       window.makeKeyAndVisible()
       let nav1 = UINavigationController()
        
        if UserDefaults.standard.bool(forKey: Constant.IS_LOGGED_IN) == false {
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
            nav1.viewControllers = [loginVC]
            self.window!.rootViewController = nav1
        } else {
            let loginVC = storyboard.instantiateViewController(withIdentifier: "DashboardTabVC") as! DashboardTabVC
            
            nav1.viewControllers = [loginVC]
            self.window!.rootViewController = nav1
        }
        self.window?.makeKeyAndVisible()
        
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

