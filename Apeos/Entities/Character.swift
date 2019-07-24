//
//  Character.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public struct Character: Codable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    public let resourceURI: String
    public let comics: HeroInfo
    public let series: HeroInfo
    public let stories: HeroInfo
    public let events: HeroInfo
    public let urls: [URLElement]
    
    public init(id: Int, name: String, description: String, thumbnail: Thumbnail, resourceURI: String, comics: HeroInfo, series: HeroInfo, stories: HeroInfo, events: HeroInfo, urls: [URLElement]) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
}
