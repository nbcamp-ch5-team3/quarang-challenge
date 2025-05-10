//
//  ViewController.swift
//  quarang-challenge
//
//  Created by Quarang on 5/7/25.
//

import UIKit
import Domain

// MARK: - 아이튠즈 뷰 컨트롤러
public final class ITunesViewController: UIViewController {

    private let type: ViewType
    private let viewModel: ITunesViewModel
    private let DIContainer: DetailDIContainerInterface
    private let iTunesView = ITunesView()
    
    public override func loadView() {
        view = iTunesView
    }
    
    public init(viewModel: ITunesViewModel, type: ViewType, DIContainer: DetailDIContainerInterface) {
        self.type = type
        self.viewModel = viewModel
        self.DIContainer = DIContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }


}

