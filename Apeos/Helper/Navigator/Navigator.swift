//
//  Navigator.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public protocol Navigator {
    associatedtype Destination
    func navigate(to destination: Destination)
}
