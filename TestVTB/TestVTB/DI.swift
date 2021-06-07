//
//  DI.swift
//  TestVTB
//
//  Created by Hudihka on 02/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation

protocol DIProtocol {
	static var pageVC: PageViewController {get}
	static func VCVideo(_ url: String, tapedButtonError: @escaping(() -> ())) -> ViewControllerVideo
}

class Builder: DIProtocol{
	
	
	static var pageVC: PageViewController {
		let PVC = PageViewController()
		PVC.viewModel = PageViewModel()
		
		return PVC
	}
	
	static func VCVideo(_ url: String,
						tapedButtonError: @escaping(() -> ()) ) -> ViewControllerVideo {
		
		let VCV = ViewControllerVideo()
		let VVM = VideoViewModel(urlVideo: url)
		VCV.videoViewModel = VVM
		VVM.tapedButtonAlert = {
			tapedButtonError()
		}
		
		return VCV
	}

}
