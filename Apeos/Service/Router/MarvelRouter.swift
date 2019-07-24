//
//  MarvelRouter.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Alamofire
import CryptoSwift

public enum MarvelRouter: Requestable {
    
    case characters(offset: Int)
    case comics(characterId: Int)
    case events(characterId: Int)
    case stories(characterId: Int)
    case series(characterId: Int)
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var path: String {
        switch self {
        case .characters:
            return "characters"
        case .comics(let characterId):
            return "characters/\(characterId)/comics"
        case .events(let characterId):
            return "characters/\(characterId)/events"
        case .stories(let characterId):
            return "characters/\(characterId)/stories"
        case .series(let characterId):
            return "characters/\(characterId)/series"
        }
    }
    
    public var parameters: Parameters? {
        let apikey = "3ba3e7aa5aa6e4809d4fb5a0829295a2"
        let ts = Date().timeIntervalSince1970.description
        let hash = "\(ts)c226bcfe95d703f86b17d93246f756ba4ba58786\(apikey)".md5()
        
        switch self {
        case .characters(let offset):
            return [
                "offset": offset,
                "apikey": apikey,
                "hash": hash,
                "ts": ts,
            ]
        case .comics, .events, .stories, .series:
            return [
                "limit": 3,
                "apikey": apikey,
                "hash": hash,
                "ts": ts,
            ]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: "https://gateway.marvel.com/v1/public/")!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .characters, .comics, .events, .stories, .series:
            urlRequest = try Alamofire.URLEncoding().encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
    
}
