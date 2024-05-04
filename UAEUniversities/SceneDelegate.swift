//
//  SceneDelegate.swift
//  UAEUniversities
//
//  Created by Khalid on 04/05/2024.
//

import UIKit
import UniversitiesList

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UniversitiesListWireFrame.createUniversitiesListModule()
        window?.makeKeyAndVisible()
    }
}
