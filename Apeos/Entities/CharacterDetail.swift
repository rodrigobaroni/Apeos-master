//
//  CharacterDetail.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public enum CharacterDetailType {
    case comics
    case events
    case stories
    case series
}

public class CharacterDetail {
    
    public var comics: [MarvelDetail]?
    public var events: [MarvelDetail]?
    public var stories: [MarvelDetail]?
    public var series: [MarvelDetail]?

    public func appendDetail(type: CharacterDetailType, value: [MarvelDetail]?) {
        switch type {
        case .comics:
            comics = value
        case .events:
            events = value
        case .stories:
            stories = value
        case .series:
            series = value
        }
    }
}
