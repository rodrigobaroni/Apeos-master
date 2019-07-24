//
//  DetailViewModel.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 30/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

public protocol DetailViewModelProtocol {
    var charactersDetail: [[HeroDetailCellViewModel]] { get }
    var characterTitleDetail: [String] { get }
}

public struct DetailViewModel: DetailViewModelProtocol {
    
    public var charactersDetail: [[HeroDetailCellViewModel]]
    public var characterTitleDetail: [String]
    
    public init() {
        charactersDetail = [[HeroDetailCellViewModel]()]
        characterTitleDetail = [String()]
    }
    
}

extension DetailViewModel {
    
    public init(detail: CharacterDetail) {
        
        charactersDetail = []
        characterTitleDetail = []
        
        if let comics = detail.comics, !comics.isEmpty {
            
            let comicsDetailViewModel = comics.map { detail -> HeroDetailCellViewModel in
                if let thumbnail = detail.thumbnail {
                    return HeroDetailCellViewModel(url: URL(string: "\(thumbnail.path).\(thumbnail.thumbnailExtension)"), name: detail.title, description: detail.description)
                }
                return HeroDetailCellViewModel(image: UIImage(named: "not_found"), name: detail.title, description: detail.description)
            }
            
            charactersDetail.append(comicsDetailViewModel)
            characterTitleDetail.append("Comics")
            
        }
        
        if let events = detail.events, !events.isEmpty {
            
            let eventsDetailViewModel = events.map { detail -> HeroDetailCellViewModel in
                if let thumbnail = detail.thumbnail {
                    return HeroDetailCellViewModel(url: URL(string: "\(thumbnail.path).\(thumbnail.thumbnailExtension)"), name: detail.title, description: detail.description)
                }
                return HeroDetailCellViewModel(image: UIImage(named: "not_found"), name: detail.title, description: detail.description)
            }
            
            charactersDetail.append(eventsDetailViewModel)
            characterTitleDetail.append("Events")
            
        }
        
        if let stories = detail.stories, !stories.isEmpty {
            
            let storiesDetailViewModel = stories.map { detail -> HeroDetailCellViewModel in
                if let thumbnail = detail.thumbnail {
                    return HeroDetailCellViewModel(url: URL(string: "\(thumbnail.path).\(thumbnail.thumbnailExtension)"), name: detail.title, description: detail.description)
                }
                return HeroDetailCellViewModel(image: UIImage(named: "not_found"), name: detail.title, description: detail.description)
            }
            
            charactersDetail.append(storiesDetailViewModel)
            characterTitleDetail.append("Stories")
            
        }
        
        if let series = detail.series, !series.isEmpty {
            
            let seriesDetailViewModel = series.map { detail -> HeroDetailCellViewModel in
                if let thumbnail = detail.thumbnail {
                    return HeroDetailCellViewModel(url: URL(string: "\(thumbnail.path).\(thumbnail.thumbnailExtension)"), name: detail.title, description: detail.description)
                }
                return HeroDetailCellViewModel(image: UIImage(named: "not_found"), name: detail.title, description: detail.description)
            }
            
            charactersDetail.append(seriesDetailViewModel)
            characterTitleDetail.append("Series")
            
        }
        
    }
    
}
