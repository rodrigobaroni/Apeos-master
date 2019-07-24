//
//  DataResult.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public enum DataResult: Codable {
    case character([Character])
    case detail([MarvelDetail])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let decode = try? container.decode([Character].self) {
            self = .character(decode)
            return
        }
        if let decode = try? container.decode([MarvelDetail].self) {
            self = .detail(decode)
            return
        }
        throw DecodingError.typeMismatch(DataResult.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DataResut"))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .character(let encode):
            try container.encode(encode)
        case .detail(let encode):
            try container.encode(encode)
        }
    }
}
