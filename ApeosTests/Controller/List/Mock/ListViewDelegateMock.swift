//
//  ListViewDelegateMock.swift
//  ApeosTests
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Apeos
import Foundation

public class ListViewDelegateMock: ListViewDelegate {
    
    var isPrefetchHerosCalled: Bool = false
    var isDidSelectCalled: Bool = false
    
    public func prefetchHeros(with count: Int) {
        isPrefetchHerosCalled = true
    }
    
    public func didSelect(_ indexPath: IndexPath) {
        isDidSelectCalled = true
    }
    
}
