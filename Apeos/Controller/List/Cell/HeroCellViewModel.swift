//
//  HeroCellViewModel.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 27/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public struct HeroCellViewModel {
    public var url: URL?
    public var name: String?
    
    public init() { }
}

extension HeroCellViewModel {
    
    public init(url: URL?, name: String?) {
        self.url = url
        self.name = name
    }
    
}
