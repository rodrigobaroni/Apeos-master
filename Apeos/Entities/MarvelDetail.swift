//
//  MarvelDetail.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 12/06/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public struct MarvelDetail: Codable {
    
    public let id: Int
    public let title: String
    public let description: String?
    public let thumbnail: Thumbnail?
    
    public init(id: Int, title: String, description: String?, thumbnail: Thumbnail?) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
    
}
