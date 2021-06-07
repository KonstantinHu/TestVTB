//
//  NetworkService.swift
//  TestVTB
//
//  Created by Hudihka on 02/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation


protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {

    // построение запроса данных по URL
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from requst: URLRequest,
								completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
		
		let ignoreSert = AllowSelfSignedCertificate()
		
		let config = URLSessionConfiguration.default
		config.requestCachePolicy = .reloadIgnoringLocalCacheData
		
		let session = URLSession(configuration: config, delegate: ignoreSert, delegateQueue: nil)
		
        return session.dataTask(with: requst, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}


class AllowSelfSignedCertificate: NSObject, URLSessionDelegate{
	
	
	func urlSession(_ session: URLSession,
					didReceive challenge: URLAuthenticationChallenge,
					completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
		completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
	}
}
