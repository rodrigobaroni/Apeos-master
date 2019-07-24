//
//  URLElement.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public struct URLElement: Codable {
    public let type: URLType
    public let url: String
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
    
    public init(type: URLType, url: String) {
        self.type = type
        self.url = url
    }
}

public enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
