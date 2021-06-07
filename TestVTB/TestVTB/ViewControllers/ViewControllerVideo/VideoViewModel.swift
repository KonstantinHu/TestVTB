//
//  VideoViewModel.swift
//  TestVTB
//
//  Created by Hudihka on 06/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation


protocol VideoViewModelInput: class {
	func interactionPlayer(isPlay: Bool)
	func createdPlayerController() -> AVPlayerViewController?
	func createdAlertAndShow(title: String?, message: String?, buttonText: String)
	var player: AVPlayer? {get set}
}

protocol VideoViewModelOutput: class {
	var presentAlert: ((UIAlertController) -> ())? {get set}
}

class VideoViewModel: NSObject, VideoViewModelInput, VideoViewModelOutput{
	
	var presentAlert: ((UIAlertController) -> ())?
	
	private var urlVideo: String?
	var tapedButtonAlert: () -> () = { }
	
	var player: AVPlayer?
	
	init(urlVideo: String?) {
		self.urlVideo = urlVideo
	}
	
	
	func interactionPlayer(isPlay: Bool) {
		
		if let player = player {
			if isPlay{
				player.play()
			} else {
				player.pause()
			}
		}
		
	}
	
	func createdPlayerController() -> AVPlayerViewController? {
		guard let urlVideo = urlVideo, let url = URL(string: urlVideo) else {
			createdAlertAndShow(title: "URL видео не корректный",
								message: "Нажми понятно что бы перейти к сл видео, или тапни где нибудь что бы остаться здесь",
								buttonText: "Понятно")
			return nil
		}
		
		
		let playerItem: AVPlayerItem = AVPlayerItem(url: url)
		playerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
		
		player = AVPlayer(playerItem: playerItem)
		let playerController = AVPlayerViewController()

		playerController.player = player
		return playerController
	}
	
	func createdAlertAndShow(title: String?, message: String?, buttonText: String){
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: buttonText, style: .default, handler: {[weak self] _ in
			self?.tapedButtonAlert()
		})
		
		alert.addAction(action)
		self.presentAlert?(alert)
	}
	
	
	override func observeValue(forKeyPath keyPath: String?,
							   of object: Any?, change: [NSKeyValueChangeKey : Any]?,
							   context: UnsafeMutableRawPointer?) {
		
			if let playerItem = object as? AVPlayerItem,
				keyPath == "status",
				playerItem.status == .failed,
				let errorText = playerItem.error?.localizedDescription{
				
				createdAlertAndShow(title: errorText,
				message: "Нажми понятно что бы перейти к сл видео, или тапни где нибудь что бы остаться здесь",
				buttonText: "Понятно")
				
			}
	}
	
}
