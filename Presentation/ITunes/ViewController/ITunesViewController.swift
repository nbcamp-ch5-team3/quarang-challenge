//
//  ViewController.swift
//  quarang-challenge
//
//  Created by Quarang on 5/7/25.
//

import UIKit

// MARK: - 아이튠즈 뷰 컨트롤러
public final class ITunesViewController: UIViewController {

    private let viewModel: ITunesViewModel
    private let mainView = ITunesView()
    
    public override func loadView() {
        view = mainView
    }
    
    public init(viewModel: ITunesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
    }


}

