//
//  DataFetcherService.swift
//  TestVTB
//
//  Created by Hudihka on 02/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation

class DataFetcherService {
    
    private var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    
    func fetchCountry(completion: @escaping (Model?, Error?) -> Void) {
        let urlString = "https://89.208.230.255/test/item"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    

}
