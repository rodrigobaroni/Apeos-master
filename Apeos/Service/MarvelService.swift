//
//  MarvelService.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Alamofire

public protocol MarvelServiceProtocol {
    func characters(with numberOfPage: Int, then completion: @escaping (Alamofire.Result<MarvelResponse>) -> Void)
    func characterDetail(with characterId: Int, then completion: @escaping (Result<CharacterDetail>) -> Void)
    func comics(with characterId: Int, then completion: @escaping (Alamofire.Result<MarvelResponse>) -> Void)
    func events(with characterId: Int, then completion: @escaping (Alamofire.Result<MarvelResponse>) -> Void)
    func stories(with characterId: Int, then completion: @escaping (Alamofire.Result<MarvelResponse>) -> Void)
    func series(with characterId: Int, then completion: @escaping (Alamofire.Result<MarvelResponse>) -> Void)
}

public class MarvelService: MarvelServiceProtocol {
    
    public init() { }
    
    public func characters(with numberOfPage: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        Alamofire.AF.request(MarvelRouter.characters(offset: numberOfPage)).responseDecodable { (response: DataResponse<MarvelResponse>) in
            completion(response.result)
        }
    }
    
    public func characterDetail(with characterId: Int, then completion: @escaping (Result<CharacterDetail>) -> Void) {
    
        // TODO: Atualizar para o Combine quando estiver disponivel
        // https://developer.apple.com/documentation/combine
        
        let characterDetail = CharacterDetail()
        let semaphore = DispatchSemaphore(value: 1)
        
        let queue = DispatchQueue.global(qos: .background)
        let operationQueue = OperationQueue()
        operationQueue.underlyingQueue = queue
        
        let comicsOperation = BlockOperation {
            semaphore.wait()
            self.comics(with: characterId, then: { [weak self] result in
                switch result {
                case .success(let values):
                    let detailValues = self?.convertToDetail(with: values)
                    characterDetail.appendDetail(type: .comics, value: detailValues)
                    semaphore.signal()
                case .failure(let error):
                    operationQueue.cancelAllOperations()
                    completion(.failure(error))
                }
            })
        }
        
        let eventsOperation = BlockOperation {
            semaphore.wait()
            self.events(with: characterId, then: { [weak self] result in
                switch result {
                case .success(let values):
                    let detailValues = self?.convertToDetail(with: values)
                    characterDetail.appendDetail(type: .events, value: detailValues)
                    semaphore.signal()
                case .failure(let error):
                    operationQueue.cancelAllOperations()
                    completion(.failure(error))
                }
            })
        }
        
        let storiesOperation = BlockOperation {
            semaphore.wait()
            self.stories(with: characterId, then: { [weak self] result in
                switch result {
                case .success(let values):
                    let detailValues = self?.convertToDetail(with: values)
                    characterDetail.appendDetail(type: .stories, value: detailValues)
                    semaphore.signal()
                case .failure(let error):
                    operationQueue.cancelAllOperations()
                    completion(.failure(error))
                }
            })
        }
        
        let seriesOperation = BlockOperation {
            semaphore.wait()
            self.series(with: characterId, then: { [weak self] result in
                switch result {
                case .success(let values):
                    let detailValues = self?.convertToDetail(with: values)
                    characterDetail.appendDetail(type: .series, value: detailValues)
                    semaphore.signal()
                    completion(.success(characterDetail))
                case .failure(let error):
                    operationQueue.cancelAllOperations()
                    completion(.failure(error))
                }
            })
        }
        
        eventsOperation.addDependency(comicsOperation)
        storiesOperation.addDependency(eventsOperation)
        seriesOperation.addDependency(storiesOperation)
        operationQueue.addOperations([comicsOperation, eventsOperation, storiesOperation, seriesOperation], waitUntilFinished: false)
        
    }
    
    public func comics(with characterId: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        Alamofire.AF.request(MarvelRouter.comics(characterId: characterId)).responseDecodable { (response: DataResponse<MarvelResponse>) in
            completion(response.result)
        }
    }
    
    public func events(with characterId: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        Alamofire.AF.request(MarvelRouter.events(characterId: characterId)).responseDecodable { (response: DataResponse<MarvelResponse>) in
            completion(response.result)
        }
    }
    
    public func stories(with characterId: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        Alamofire.AF.request(MarvelRouter.stories(characterId: characterId)).responseDecodable { (response: DataResponse<MarvelResponse>) in
            completion(response.result)
        }
    }
    
    public func series(with characterId: Int, then completion: @escaping (Result<MarvelResponse>) -> Void) {
        Alamofire.AF.request(MarvelRouter.series(characterId: characterId)).responseDecodable { (response: DataResponse<MarvelResponse>) in
            completion(response.result)
        }
    }
    
    // MARK: - Private Methods
    
    private func convertToDetail(with response: MarvelResponse) -> [MarvelDetail]? {
        if case .detail(let values) = response.data.results {
            return values
        }
        return nil
    }
    
}
