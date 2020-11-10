//
//  PlaceViewController.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/11/20.
//  Copyright (c) 2020 Jex. All rights reserved.


import UIKit


class PlaceViewController : UIViewController {
    
	var presenter: IPlacePresenter?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }
    
    private func setupViews() {
        view.backgroundColor = .secondarySystemBackground
        
    }
}


extension PlaceViewController : IPlaceView {
    func showPlaceDetails(_ place: Place) {
        navigationItem.title = place.name
    }
}
