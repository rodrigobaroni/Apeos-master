//
//  ListViewTest.swift
//  ApeosTests
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Quick
import Nimble
@testable import Apeos

public class ListViewTest: QuickSpec {
    
    var sut: ListView!
    var delegateMock: ListViewDelegateMock!
    
    public override func spec() {
        
        describe("ListView") {
            
            context("quando iniciar usando o padrao", closure: {
                
                beforeEach {
                    self.sut = ListView(frame: UIScreen.main.bounds)
                }
                
                it("deveria iniciar os items padrao", closure: {
                    expect(self.sut.tableView.numberOfRows(inSection: 0)).to(equal(0))
                })
                
            })
            
            context("quando iniciar com view model", closure: {
                
                beforeEach {
                    let response: MarvelResponse = Loader.fixture("characters")!
                    
                    if case .character(let values) = response.data.results {
                        let viewModel = ListViewModel(characters: values)
                        self.sut.viewModel = viewModel
                    }
                    
                    self.delegateMock = ListViewDelegateMock()
                    self.sut.delegate = self.delegateMock
                    
                }
                
                it("deveria selecionar o primeiro item da table view", closure: {
                    self.sut.tableView.delegate?.tableView?(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    expect(self.delegateMock.isDidSelectCalled).to(beTrue())
                })
                
                it("deveria ter 1 item na table view", closure: {
                    expect(self.sut.tableView.dataSource?.tableView(self.sut.tableView, numberOfRowsInSection: 0)).to(equal(1))
                })
                
                it("deveria", closure: {
                    let cell = (self.sut.tableView.dataSource?.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ListView.HeroCell)
                    expect(cell.viewModel?.name).to(equal("3-D Man"))
                    expect(cell.viewModel?.url?.absoluteString).to(equal("http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
                })
                
            })
            
        }
        
    }
    
}
