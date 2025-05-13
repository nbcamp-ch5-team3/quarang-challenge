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

// MARK: - RxDataSource를 위한 섹션 모델 정의
typealias ITunesSection = SectionModel<String, ITunesSectionItem>

enum ITunesSectionItem {
    case spring(item: ITunes)
    case summer(item: ITunes)
    case autumn(item: ITunes)
    case winter(item: ITunes)
}

// MARK: - 아이튠즈 뷰 컨트롤러
public final class ITunesViewController: UIViewController {
    
    private let viewModel: ITunesViewModel
    private let DIContainer: DetailDIContainerInterface
    private let iTunesView = ITunesView()
    private var disposeBag = DisposeBag()
    
    /// 데아터 소스 - 셀 타입 및 헤더 설정
    private var dataSource: RxCollectionViewSectionedReloadDataSource<ITunesSection> {
        RxCollectionViewSectionedReloadDataSource<ITunesSection>(
            configureCell: { _, collectionView, indexPath, item in
                // 셀 반환
                switch item {
                case let .spring(itunes):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ITunesThumbnailCell.identifier, for: indexPath) as! ITunesThumbnailCell
                    cell.configure(with: itunes)
                    return cell
                case let .summer(itunes), let .autumn(itunes), let .winter(itunes):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ITunesCell.identifier, for: indexPath) as! ITunesCell
                    cell.configure(with: itunes)
                    return cell
                }
            }) {  dataSource, collectionView, _, indexPath in
                // 헤더 반환
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeaderView.identifier,
                    for: indexPath
                ) as? SectionHeaderView else { return UICollectionReusableView() }
                
                header.titleLabel.text = dataSource.sectionModels[indexPath.section].model
                return header
            }
    }
    
    public override func loadView() {
        view = iTunesView
    }
    
    public init(viewModel: ITunesViewModel, DIContainer: DetailDIContainerInterface) {
        self.viewModel = viewModel
        self.DIContainer = DIContainer
        super.init(nibName: nil, bundle: nil)
        configureRegister()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.test()
    }
    
    /// 컬렉션 뷰 셀 및 헤더 설정
    private func configureRegister() {
        iTunesView.getCollectionView.register(ITunesThumbnailCell.self, forCellWithReuseIdentifier: ITunesThumbnailCell.identifier)
        iTunesView.getCollectionView.register(ITunesCell.self, forCellWithReuseIdentifier: ITunesCell.identifier)
        iTunesView.getCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
    }
    
    /// 뷰 바인딩
    func bindViewModel() {
        viewModel.items
            .map { items in
                let springs: [ITunesSectionItem] = items.map { ITunesSectionItem.spring(item: $0) }
                let summers: [ITunesSectionItem] = items.map { ITunesSectionItem.summer(item: $0) }
                let autumns: [ITunesSectionItem] = items.map { ITunesSectionItem.autumn(item: $0) }
                let winters: [ITunesSectionItem] = items.map { ITunesSectionItem.winter(item: $0) }
                return [
                    ITunesSection(model: "봄 추천", items: springs),
                    ITunesSection(model: "여름 추천", items: summers),
                    ITunesSection(model: "가을 추천", items: autumns),
                    ITunesSection(model: "겨울 추천", items: winters)
                ]
            }
            .bind(to: iTunesView.getCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}




