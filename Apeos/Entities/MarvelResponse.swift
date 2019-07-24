//
//  MarvelResponse.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public struct MarvelResponse: Codable {
    public let code: Int
    public let status: String
    public let data: MarvelResponseData
    
    public init(code: Int, status: String, data: MarvelResponseData) {
        self.code = code
        self.status = status
        self.data = data
    }
}
