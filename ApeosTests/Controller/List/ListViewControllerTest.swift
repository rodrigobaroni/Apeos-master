//
//  ListViewControllerTest.swift
//  ApeosTests
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Quick
import Nimble
import Alamofire
@testable import Apeos

public class ListViewControllerTest: QuickSpec {
    
    var sut: ListViewController!
    var delegateMock: ListViewControllerDelegateMock!
    var serviceMock: MarvelServiceMock!
    
    public override func spec() {
        
        describe("ListViewController") {
            
            context("quando iniciar", closure: {
                
                beforeEach {
                    self.delegateMock = ListViewControllerDelegateMock()
                    self.serviceMock = MarvelServiceMock()
                    self.sut = ListViewController(service: self.serviceMock)
                    self.sut.delegate = self.delegateMock
                    self.sut.beginAppearanceTransition(true, animated: false)
                    self.sut.endAppearanceTransition()
                }
                
                it("deveria ter a view do tipo ListView", closure: {
                    expect(self.sut.view).to(beAKindOf(ListView.self))
                })
                
                it("deveria chamar a request de characters", closure: {
                    expect(self.serviceMock.isCharactersCalled).to(beTrue())
                })
                
                it("deveria chamar o didSelect delegate da view controller", closure: {
                    self.sut.didSelect(IndexPath(row: 0, section: 0))
                    expect(self.delegateMock.isDidSelectCalled).to(beTrue())
                })
            })
            
        }
        
    }
    
}
