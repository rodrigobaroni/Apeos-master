//
//  HeroInfo.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public struct HeroInfo: Codable {
    public let available: Int
    public let collectionURI: String
    
    public init(available: Int, collectionURI: String) {
        self.available = available
        self.collectionURI = collectionURI
    }
}
