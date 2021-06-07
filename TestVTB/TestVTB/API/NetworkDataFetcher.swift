//
//  NetworkDataFetcher.swift
//  TestVTB
//
//  Created by Hudihka on 02/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?, Error?) -> Void)
	func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> (T?, Error?)
}

class NetworkDataFetcher: DataFetcher {

    private var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String,
											response: @escaping (T?, Error?) -> Void) {
		
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil, error)
            }

            let decoded = self.decodeJSON(type: T.self, from: data)
			response(decoded.0, decoded.1)

        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> (T?, Error?) {
        let decoder = JSONDecoder()
		
        guard let data = from else { return (nil, nil) }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return (objects, nil)
        } catch let jsonError {
            return (nil, jsonError)
        }
    }
}

