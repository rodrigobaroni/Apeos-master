//
//  ListViewModel.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 27/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public protocol ListViewModelProtocol {
    var characters: [HeroCellViewModel] { get }
}

public struct ListViewModel: ListViewModelProtocol {
    public var characters: [HeroCellViewModel]

    public init() {
        characters = [HeroCellViewModel]()
    }
    
}

extension ListViewModel {
    
    public init(characters: [Character]) {
        self.characters = characters.map {
            return HeroCellViewModel(url: URL(string: "\($0.thumbnail.path).\($0.thumbnail.thumbnailExtension)"), name: $0.name)
        }
    }

}
