//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Class Properties
    
    var window: UIWindow?
    
    var cities: [City] = []
    
    static let shared = UIApplication.shared.delegate as! AppDelegate
    
    let weatherAPIKey = "5436aaa00baefc8543341b80fd8ef1e0"
    
    private lazy var rootAnimationOptions: UIWindow.TransitionOptions = {
        var options = UIWindow.TransitionOptions()
        options.direction = .fade
        options.duration = 0.15
        return options
    }()
    
    // -----------------------------------------------------------------------------------------------

    // MARK: - Life Cycle Functions
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initialSetup()
        
        return true
    }

    // -----------------------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------------------

// MARK: - Initial Setup -

extension AppDelegate {
    
    private func initialSetup() {
        loadCityData()
        setupWindow()
        setupNavigationBar()
        setupIQKeyBoardManager()
        setRootController()
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = UIColor.black
        window?.makeKeyAndVisible()
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.purple
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
    }
    
    private func setupIQKeyBoardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarTintColor = UIColor.purple
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 15
    }
    
    private func loadCityData() {
        let path = Bundle.main.path(forResource: "city.list", ofType: "json")!
        if let jsonString = try? String(contentsOfFile: path, encoding: .utf8){
            cities = JSON(parseJSON: jsonString).arrayValue.map{City(withJOSN: $0)}
        }
    }
    
    private func setRootController() {
        let vc = UIStoryboard.home.controller(withClass: HomeVC.self)
        let navController = UINavigationController(rootViewController: vc)
        window?.setRootViewController(navController, options: rootAnimationOptions)
    }
}

// -----------------------------------------------------------------------------------------------
