//
//  DetailViewViewController.swift
//  Presentation
//
//  Created by Quarang on 5/10/25.
//

import UIKit

// MARK: - 상세페이지 뷰 컨트롤러
final public class DetailViewViewController: UIViewController {
    
    private let detailView = DetailView()
    private let viewModel: DetailViewViewModel
    
    public override func loadView() {
        view = detailView
    }
    
    public init(viewModel: DetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
