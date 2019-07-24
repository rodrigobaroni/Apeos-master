//
//  Coordinator.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 30/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit
import Alamofire

public final class MarvelNavigator: Navigator {
    
    private let service: MarvelServiceProtocol
    private var router: Router
    
    public enum Destination {
        case detail(Character)
    }
    
    public init(navigationController: UINavigationController, service: MarvelServiceProtocol = MarvelService()) {
        self.service = service
        self.router = Router(navigationController: navigationController)
    }

    public func start() {
        let controller = ListViewController(service: service)
        self.router.navigationController?.setViewControllers([controller], animated: false)
        
        controller.delegate = self
    }
    
    public func navigate(to destination: Destination) {
    
        switch destination {
        case .detail(let character):
            let controller = DetailViewController(character: character, service: service)
            self.router.push(viewController: controller)
        }
        
    }

}

extension MarvelNavigator: ListViewControllerDelegate {
    
    public func didSelect(character: Character) {
        navigate(to: .detail(character))
    }
    
}
