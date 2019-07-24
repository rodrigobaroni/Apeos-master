//
//  Router.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

public class Router {
    
    public weak var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
    }
    
    public func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    public func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
