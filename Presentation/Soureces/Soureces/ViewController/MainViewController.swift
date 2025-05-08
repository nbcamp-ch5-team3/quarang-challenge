//
//  ViewController.swift
//  quarang-challenge
//
//  Created by Quarang on 5/7/25.
//

import UIKit

class MainViewController: UIViewController {

    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
    }


}

