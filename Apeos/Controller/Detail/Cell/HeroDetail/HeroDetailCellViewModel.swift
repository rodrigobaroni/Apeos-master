//
//  HeroDetailCellViewModel.swift
//  Apeos
//
//  Created by v.franca.nunes.silva on 16/06/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

public struct HeroDetailCellViewModel {
    public var url: URL?
    public var image: UIImage?
    
    public var name: String
    public var description: String?
    
    public init(url: URL? = nil, image: UIImage? = nil, name: String, description: String?) {
        self.url = url
        self.image = image
        self.name = name
        self.description = description
    }
}
