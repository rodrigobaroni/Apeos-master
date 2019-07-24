//
//  MarvelServiceMock.swift
//  ApeosTests
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Alamofire
import Apeos
import Foundation

public class MarvelServiceMock: MarvelServiceProtocol {

    var isCharacterDetailCalled: Bool = false
    var isCharactersCalled: Bool = false
    var isComicsCalled: Bool = false
    var isEventsCalled: Bool = false
    var isStoriesCalled: Bool = false
    var isSeriesCalled: Bool = false

    public func characterDetail(with characterId: Int, then completion: @escaping (Result<CharacterDetail>) -> Void) {
        isCharacterDetailCalled = true
    }
    
    public func characters(with numberOfPage: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        let response: MarvelResponse = Loader.fixture("characters")!
        isCharactersCalled = true
        completion(.success(response))
    }
    
    public func comics(with characterId: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        isComicsCalled = true
    }
    
    public func events(with characterId: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        isEventsCalled = true
    }
    
    public func stories(with characterId: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        isStoriesCalled = true
    }
    
    public func series(with characterId: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        isSeriesCalled = true
    }
    
}
