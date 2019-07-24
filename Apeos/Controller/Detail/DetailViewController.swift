//
//  DetailViewController.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 30/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

public class DetailViewController: UIViewController {
    
    private let character: Character
    private let service: MarvelServiceProtocol

    private var characterDetail: CharacterDetail? {
        didSet {
            updateView()
        }
    }
    
    public init(character: Character, service: MarvelServiceProtocol) {
        self.character = character
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var theView: DetailView {
        return self.view as! DetailView
    }
    
    // MARk: - Life Cycle Methods
    
    public override func loadView() {
        let frame = UIScreen.main.bounds
        let view = DetailView(frame: frame)
        self.view = view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = character.name
        loadData()
    }
    
    // MARK: - Private Methods
    
    private func loadData() {
    
        service.characterDetail(with: character.id) { [weak self] result in
            switch result {
            case .success(let value):
                self?.characterDetail = value
            case .failure(let error):
                self?.handle(error)
            }
        }
        
    }
    
    private func updateView() {
        
        guard let characterDetail = characterDetail else {
            return
        }
        
        let viewModel = DetailViewModel(detail: characterDetail)
        theView.viewModel = viewModel
    }
    
    private func handle(_ error: Error) {
        let alertController = UIAlertController(title: "Apeos",
                                                message: "Desculpe mas esse herói esta ocupado no momento :( \nDeseja tentar chama-lo novamente?",
                                                preferredStyle: .alert)
        
        let letsGoAction = UIAlertAction(title: "Preciso da ajuda dele AGORA!", style: .default, handler: { [weak self] _ in
            self?.loadData()
        })
        
        let cancelAction = UIAlertAction(title: "Deixa quieto, nem gosto tanto dele", style: .destructive, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        alertController.addAction(letsGoAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
