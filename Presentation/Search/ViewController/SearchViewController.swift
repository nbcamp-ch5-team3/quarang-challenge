//
//  SearchViewController.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import UIKit
import Domain

// MARK: 검색 뷰 컨트롤러
public final class SearchViewController: UIViewController {

    
    private let viewModel: SearchViewModel
    private let serachView = SearchView()
    
    public override func loadView() {
        view = serachView
    }
    
    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
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
