//
//  ViewController.swift
//  TestVTB
//
//  Created by Hudihka on 01/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewControllerVideo: UIViewController {
	
	var videoViewModel: VideoViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		observationViewModel()
		
		self.view.backgroundColor = UIColor.black
		if let playerController = videoViewModel?.createdPlayerController(){
			self.addChild(playerController)
			self.view.addSubview(playerController.view)
			playerController.view.frame = self.view.frame
		}
		
	}

	
	private func observationViewModel(){
		videoViewModel?.presentAlert = {[weak self] alert in
			
			guard let selF = self else {
				return
			}
			
			selF.present(alert, animated: true, completion:{
				alert.view.superview?.isUserInteractionEnabled = true
				let gester = UITapGestureRecognizer(target: selF, action: #selector(selF.alertControllerBackgroundTapped))
				alert.view.superview?.addGestureRecognizer(gester)
			})
			
		}
		
	}

	
	override func viewDidAppear(_ animated: Bool){
			super.viewDidAppear(animated)
		
		videoViewModel?.interactionPlayer(isPlay: true)
			
	}
	
	override func viewWillDisappear(_ animated: Bool){
			super.viewWillDisappear(animated)
		videoViewModel?.interactionPlayer(isPlay: false)
			
	}
	
	@objc private func alertControllerBackgroundTapped(){
		self.dismiss(animated: true, completion: nil)
	}

}

