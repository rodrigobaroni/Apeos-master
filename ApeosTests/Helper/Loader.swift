//
//  Loader.swift
//  ApeosTests
//
//  Created by Rodrigo Alexis Garcia Baroni on 02/04/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public class Loader {
    
    public static func fixture<T: Codable>(_ filePath: String, decoder: JSONDecoder = JSONDecoder()) -> T? {
        let bundle = Bundle(for: object_getClass(self)!)
        let jsonFile = bundle.path(forResource: filePath, ofType: "json")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!))
        
        do {
            guard let data = jsonData else {
                return nil
            }
            
            return try decoder.decode(T.self, from: data)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    public static func fixture(forResource fileName: String, withExtension ext: String) -> URL {
        let bundle = Bundle(for: Loader.self)
        return bundle.url(forResource: fileName, withExtension: ext)!
    }
}
