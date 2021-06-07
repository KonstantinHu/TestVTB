//
//  Model.swift
//  TestVTB
//
//  Created by Hudihka on 02/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation

struct Model: Decodable {
    var a: String?
    var task_id: Int?
    var status: Int?
	var results: [String:String]?
	
	
	var getUrlsString: [String] {
		
		if let results = results {
			let keys = ["src", "single", "split_v", "split_h"]
			let filter = results.filter({keys.contains($0.key)})
			
			return Array(filter.values)
		}
		
		return []
	}
}
