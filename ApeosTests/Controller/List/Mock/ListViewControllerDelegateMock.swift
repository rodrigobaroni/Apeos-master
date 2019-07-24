//
//  ListViewControllerDelegateMock.swift
//  ApeosTests
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Apeos
import Foundation

public class ListViewControllerDelegateMock: ListViewControllerDelegate {
    
    var isDidSelectCalled: Bool = false
    
    public func didSelect(character: Character) {
        isDidSelectCalled = true
    }
    
}
