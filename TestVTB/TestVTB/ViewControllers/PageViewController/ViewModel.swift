//
//  ViewModel.swift
//  TestVTB
//
//  Created by Hudihka on 02/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation
import UIKit

protocol PageViewModelProtocolInput: class {
	
	associatedtype T
	associatedtype D
	
	func loadData()
	func addArray(_ from: [D]) //делается для возможной пагинации
	var dataArray: [T] {get set} //делается для возможной пагинации

}

protocol PageViewModelProtocolOutput: class {
	
	associatedtype K

	
	var presentAletr: ((String?) -> Void)? {get set}
	var updateViewData: (([K]) -> Void)? {get set}
	var nextIndex: (() -> Void)? {get set}

}


class PageViewModel: PageViewModelProtocolInput, PageViewModelProtocolOutput {

	typealias T = ViewControllerVideo
	typealias K = ViewControllerVideo
	typealias D = String
	
	var dataFetcherService = DataFetcherService()
	
	var dataArray: [ViewControllerVideo]
	
	var presentAletr: ((String?) -> Void)?
	var updateViewData: (([ViewControllerVideo]) -> Void)?
	var nextIndex: (() -> Void)?
	
	init() {
		dataArray = []
	}
	
	func loadData() {
		
		self.updateViewData?(dataArray)
		
		dataFetcherService.fetchCountry {[weak self] (model, error) in
			guard let selF = self else {return}
			
			if let error = error {
				selF.presentAletr?(error.localizedDescription)
			} else if var urls = model?.getUrlsString {

				selF.addArray(urls)
				selF.updateViewData?(selF.dataArray)
			} else {
				selF.presentAletr?("Не пришло данных")
			}

        }
		
	}
	
	func addArray(_ from: [String]) {
		var array = [ViewControllerVideo]()
		
		for i in from {
			
			let VC = Builder.VCVideo(i, tapedButtonError: { [weak self] in
				self?.nextIndex?()
			})
			array.append(VC)
		}
		
		dataArray += array
	}
	
	
}
