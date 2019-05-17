//
//  AppDelegate.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinator!
    var context: Context!
    var window: UIWindow?

    // MARK: - Private properties
    
    private var imageCache: NSCache<Key, Object>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
        imageCache = NSCache<Key, Object>()

        let client = HTTPClient(engine: .urlSession(.default))

        let imageRepository = ImageRepository(networkClient: client)
        let imageProvider = ImageProvider(repository: imageRepository,
                                          cache: self.imageCache)

        context = Context(networkClient: client, imageProvider: imageProvider)

        coordinator = AppCoordinator(presenter: window!,
                                     context: context)
        coordinator.start()
        return true
    }
}

