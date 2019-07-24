//
//  ListViewModelTest.swift
//  ApeosTests
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Quick
import Nimble
@testable import Apeos

public class ListViewModelTest: QuickSpec {
    
    var sut: ListViewModel!
    var characters: [Character]!
    
    public override func spec() {
        
        describe("ListViewModel") {
            
            context("quando iniciar o padrão", closure: {
                
                beforeEach {
                    self.sut = ListViewModel()
                }
                
                it("deveria ter 0 characters", closure: {
                    expect(self.sut.characters).to(haveCount(0))
                })
                
            })
            
            context("quando iniciar com characters", closure: {
                
                beforeEach {
                    let response: MarvelResponse = Loader.fixture("characters")!
                    
                    if case .character(let values) = response.data.results {
                        self.sut = ListViewModel(characters: values)
                    }
                    
                }
                
                it("deveria ter 1 character", closure: {
                    expect(self.sut.characters).to(haveCount(1))
                })
                
            })
            
        }
        
    }
    
}
