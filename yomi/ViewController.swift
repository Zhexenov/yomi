//
//  ViewController.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import UIKit

protocol IMainView : class {
    
    func showLoading()
    func hideLoading()
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


}


extension MainViewController : IMainView {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
