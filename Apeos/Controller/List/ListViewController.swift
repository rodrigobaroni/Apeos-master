//
//  ListViewController.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 27/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

public protocol ListViewControllerDelegate: class {
    func didSelect(character: Character)
}

public class ListViewController: UIViewController {
    
    private let service: MarvelServiceProtocol
    
    private var characters: [Character] {
        didSet {
           updateView()
        }
    }

    // TODO: - Verificar porque o delegate não funciona quando esta com weak
    public var delegate: ListViewControllerDelegate?
    
    public init(service: MarvelServiceProtocol) {
        self.service = service
        self.characters = [Character]()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var theView: ListView {
        return self.view as! ListView
    }

    // MARK: - Life Cycle Methods
    
    public override func loadView() {
        let frame = UIScreen.main.bounds
        let view = ListView(frame: frame)
        self.view = view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heros"
        theView.delegate = self
        loadData()
    }
    
    // MARK: - Private Methods
    
    private func loadData(with offset: Int? = nil) {
        
        service.characters(with: offset ?? 0) { [weak self] result in
            switch result {
            case .success(let value):
                if case .character(let values) = value.data.results {
                    self?.characters.append(contentsOf: values)
                }
            case .failure(let error):
                self?.handle(error)
            }
        }
        
    }
    
    private func updateView() {
        let viewModel = ListViewModel(characters: characters)
        theView.viewModel = viewModel
    }
    
    private func handle(_ error: Error) {
        let alertController = UIAlertController(title: "Apeos",
                                                message: "Desculpe mas parece que os heróis estão de folga :( Deseja tentar chama-los novamente?",
                                                preferredStyle: .alert)
        
        let letsGoAction = UIAlertAction(title: "Chamar todos os heróis!!!", style: .default, handler: { [weak self] _ in
            self?.loadData()
        })
        
        let cancelAction = UIAlertAction(title: "Deixa pra la, não quero mais", style: .destructive, handler: nil)
        
        alertController.addAction(letsGoAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ListViewController: ListViewDelegate {

    // MARK: ListViewDelegate Methods
    
    public func prefetchHeros(with count: Int) {
        loadData(with: count + 20)
    }
    
    public func didSelect(_ indexPath: IndexPath) {
        delegate?.didSelect(character: characters[indexPath.row])
    }
    
}
