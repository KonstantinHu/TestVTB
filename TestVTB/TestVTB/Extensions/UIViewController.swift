//
//  UIViewController.swift
//  TestVTB
//
//  Created by Hudihka on 02/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
	
	func showAlertEnableBacground(title: String?,
								  message: String?,
								  buttonText: String,
								  handler: ((UIAlertAction) -> Void)? = nil){
		
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: handler))
		self.present(alert, animated: true, completion:{
			alert.view.superview?.isUserInteractionEnabled = true
			let gester = UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped))
			alert.view.superview?.addGestureRecognizer(gester)
		})
	}
	
	@objc private func alertControllerBackgroundTapped(){
		self.dismiss(animated: true, completion: nil)
	}
	
	
	func showAlert(title: String?,
				   message: String?,
				   buttonText: String){
		
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	
}
