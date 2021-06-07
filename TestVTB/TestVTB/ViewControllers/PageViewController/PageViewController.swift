//
//  PageViewController.swift
//  TestVTB
//
//  Created by Hudihka on 01/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
	
	fileprivate var dataArray: [UIViewController]? {
		didSet{
			showIndex(currentIndex)
		}
	}
	
	private var spiner: UIActivityIndicatorView!
	
	
	private var currentIndex: Int {
		guard let vc = viewControllers?.first else { return 0 }
		return dataArray?.firstIndex(of: vc) ?? 0
	}
	
    private let pageControl = UIPageControl()
	
	var viewModel: PageViewModel?
	
	init(){
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
		
        self.dataSource = self
        self.delegate = self
	}

    override init(transitionStyle style: UIPageViewController.TransitionStyle,
				  navigationOrientation: UIPageViewController.NavigationOrientation,
				  options: [UIPageViewController.OptionsKey : Any]? = nil) {
		
        super.init(transitionStyle: style,
				   navigationOrientation: navigationOrientation,
				   options: options)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.uiDesing()
		
		viewModel?.loadData()
		observationViewModel()
    }
	
	private func uiDesing(){
		self.view.backgroundColor = UIColor.white
		
		spiner = UIActivityIndicatorView(style: .large)
		spiner.color = UIColor.black
		spiner.startAnimating()
		spiner.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(spiner!)

		spiner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		spiner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	
	private func observationViewModel(){
		viewModel?.updateViewData = {[weak self] array in
			self?.dataArray = array
		}
		
		viewModel?.nextIndex = {[weak self] in
			if let sleF = self{
				let index = sleF.currentIndex + 1
				sleF.showIndex(index)
			}
		}
		
		viewModel?.presentAletr = {[weak self] text in
			if let sleF = self{
				sleF.spiner.stopAnimating()
				sleF.showAlert(title: "ОШИБКА", message: text, buttonText: "понятно")
			}
		}
	}
    
	
	private func showIndex(_ index: Int){
		guard let dataArray = dataArray, !dataArray.isEmpty else {
			return
		}
		
		spiner?.stopAnimating()
		let obj = dataArray[safe: index] ?? dataArray[0]
		setViewControllers([obj],
							direction: .forward,
							animated: true,
							completion: nil)
	}

}


extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
	
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return dataArray?.count ?? 0
	}
	
	
	    public func pageViewController(_ pageViewController: UIPageViewController,
									   viewControllerBefore viewController: UIViewController) -> UIViewController? {
			
		guard let dataArray = dataArray else {
			return nil
		}
			
		guard let viewControllerIndex = dataArray.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return dataArray.last
        }

        guard dataArray.count > previousIndex else {
            return nil
        }

        return dataArray[previousIndex]
    }

    public func pageViewController(_ pageViewController: UIPageViewController,
								   viewControllerAfter viewController: UIViewController) -> UIViewController? {
		
		guard let dataArray = dataArray else {
			return nil
		}
		
		guard let viewControllerIndex = dataArray.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < dataArray.count else {
            return dataArray.first
        }

        guard dataArray.count > nextIndex else {
            return nil
        }

        return dataArray[nextIndex]
    }
	
	

}
