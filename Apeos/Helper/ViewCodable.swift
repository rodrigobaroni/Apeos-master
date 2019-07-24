//
//  ViewCodable.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 27/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public protocol ViewCodable {
    func buildHierarchy()
    func buildConstraints()
    func configure()
    func render()
    func setupView()
}

public extension ViewCodable {
    
    func setupView() {
        buildHierarchy()
        buildConstraints()
        render()
        configure()
    }
    
    func render() {}
}
