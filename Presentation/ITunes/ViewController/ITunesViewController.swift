//
//  ViewController.swift
//  quarang-challenge
//
//  Created by Quarang on 5/7/25.
//

import UIKit
import Domain
internal import RxSwift
import RxDataSources

// MARK: - 아이튠즈 뷰 컨트롤러
public final class ITunesViewController: UIViewController {

    private let viewModel: ITunesViewModel
    var disposeBag = DisposeBag()
    private let DIContainer: DetailDIContainerInterface
    private let iTunesView = ITunesView()
    
    public override func loadView() {
        view = iTunesView
    }
    
    public init(viewModel: ITunesViewModel, DIContainer: DetailDIContainerInterface) {
        self.viewModel = viewModel
        self.DIContainer = DIContainer
        super.init(nibName: nil, bundle: nil)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.test()
        // Do any additional setup after loading the view.
    }

    func configureLayout() {
        
        iTunesView.getCollectionView.register(ITunesThumbnailCell.self, forCellWithReuseIdentifier: "ITunesThumbnailCell")

        let dataSource = RxCollectionViewSectionedReloadDataSource<ITunesSection>(
            configureCell: { dataSource, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ITunesThumbnailCell", for: indexPath) as! ITunesThumbnailCell

                switch item {
                case let .spring(itunes),
                     let .summer(itunes),
                     let .autumn(itunes),
                     let .winter(itunes):
                    cell.configure(with: itunes)
                }

                return cell
            })

        viewModel.items
            .map { items in
                let springs: [ITunesSectionItem] = items.map { ITunesSectionItem.spring(item: $0) }
                return [ITunesSection(model: "spring", items: springs)]
            }
            .bind(to: iTunesView.getCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

enum ITunesSectionItem {
    case spring(item: ITunes)
    case summer(item: ITunes)
    case autumn(item: ITunes)
    case winter(item: ITunes)
}

typealias ITunesSection = SectionModel<String, ITunesSectionItem>
