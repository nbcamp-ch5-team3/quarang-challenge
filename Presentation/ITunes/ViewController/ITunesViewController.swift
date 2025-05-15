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
typealias ITunesSection = SectionModel<SeasonType, ITunesSectionItem>

enum ITunesSectionItem {
    case category(attributes: ITunesAttributes)
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
    
    private let type: ViewType
    private let itemCatergory: [ITunesAttributes]
    private lazy var attributes: ITunesAttributes? = itemCatergory.first
    
    /// 데아터 소스 - 셀 타입 및 헤더 설정
    private var dataSource: RxCollectionViewSectionedReloadDataSource<ITunesSection> {
        RxCollectionViewSectionedReloadDataSource<ITunesSection>(
            configureCell: { _, collectionView, indexPath, item in
                // 셀 반환
                switch item {
                case let .category(attributes):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
                    
                    cell.configure(attributes: attributes, selected: self.attributes == attributes)
                    
//                    cell.tapSubject
//                        .subscribe(with: self, onNext: { owner, tappedAttributes in
//                            self.attributes = attributes
//                            cell.configure(attributes: attributes, selected: owner.attributes == attributes)
//                        })
//                        .disposed(by: cell.disposeBag)
                    return cell
                case let .spring(itunes):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ITunesThumbnailCell.identifier, for: indexPath) as! ITunesThumbnailCell
                    cell.configure(with: itunes)
                    cell.getItunesCellView.delegate = self
                    return cell
                case let .summer(itunes), let .autumn(itunes), let .winter(itunes):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ITunesCell.identifier, for: indexPath) as! ITunesCell
                    cell.configure(with: itunes)
                    cell.getItunesCellView.delegate = self
                    return cell
                }
            }) { dataSource, collectionView, _, indexPath in
                let model = dataSource.sectionModels[indexPath.section].model
                
                guard model != .category else { return UICollectionReusableView() }

                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeaderView.identifier,
                    for: indexPath
                ) as? SectionHeaderView else {
                    return UICollectionReusableView()
                }

                header.configure(title: model.title, subTitle: model.subtitle)
                return header
            }
    }
    
    public override func loadView() {
        view = iTunesView
    }
    
    public init(viewModel: ITunesViewModel, type: ViewType, DIContainer: DetailDIContainerInterface) {
        self.viewModel = viewModel
        self.DIContainer = DIContainer
        self.type = type
        self.itemCatergory = type.attributesEnum
        super.init(nibName: nil, bundle: nil)
        configureRegister()
        bindViewModel()
        iTunesView.getCollectionView.allowsMultipleSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        guard let attributes else { return }
        viewModel.state.actionSubject.onNext(.viewDidLoad(type: setItunesType(attributes)))
    }
    
    /// 컬렉션 뷰 셀 및 헤더 설정
    private func configureRegister() {
        iTunesView.getCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        iTunesView.getCollectionView.register(ITunesThumbnailCell.self, forCellWithReuseIdentifier: ITunesThumbnailCell.identifier)
        iTunesView.getCollectionView.register(ITunesCell.self, forCellWithReuseIdentifier: ITunesCell.identifier)
        iTunesView.getCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
    }
    
    /// 뷰 바인딩
    func bindViewModel() {
        
        iTunesView.getCollectionView.rx
            .modelSelected(ITunesSectionItem.self)
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .bind { owner, item in
                switch item {
                case .category(let attributes):
                    guard let oldAttributes = self.attributes,
                          let oldIndex = owner.itemCatergory.firstIndex(of: oldAttributes),
                          let newIndex = owner.itemCatergory.firstIndex(of: attributes)
                    else { return }
                    owner.attributes = attributes
                    owner.viewModel.state.actionSubject.onNext(.viewDidLoad(type: owner.setItunesType(attributes)))

                    let oldIndexPath = IndexPath(item: oldIndex, section: 0)
                    let newIndexPath = IndexPath(item: newIndex, section: 0)
                    owner.iTunesView.getCollectionView.reloadItems(at: [oldIndexPath, newIndexPath])
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(
                viewModel.state.springItems,
                viewModel.state.summerItems,
                viewModel.state.autumnItems,
                viewModel.state.winterItems
            )
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .map { owner, items in
                let (spring, summer, autumn, winter) = items
                let category = owner.itemCatergory.map { ITunesSectionItem.category(attributes: $0) }
                let springs = spring.map { ITunesSectionItem.spring(item: $0) }
                let summers = summer.map { ITunesSectionItem.summer(item: $0) }
                let autumns = autumn.map { ITunesSectionItem.autumn(item: $0) }
                let winters = winter.map { ITunesSectionItem.winter(item: $0) }
                return [
                    ITunesSection(model: .category, items: category),
                    ITunesSection(model: .spring, items: springs),
                    ITunesSection(model: .summer, items: summers),
                    ITunesSection(model: .autumn, items: autumns),
                    ITunesSection(model: .winter, items: winters)
                ]
            }
            .bind(to: iTunesView.getCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func setItunesType(_ attributes: ITunesAttributes) -> ViewType {
        switch type {
        case .music: return ViewType.music(attributes: attributes.attributes)
        case .movie: return ViewType.movie(attributes: attributes.attributes)
        case .app: return ViewType.app(attributes: attributes.attributes)
        case .podcast: return ViewType.podcast(attributes: attributes.attributes)
        default : return type
        }
    }
}


extension ITunesViewController: ITunesCellViewDelegate {
    func didTapDownLoadButton(id: Int) {
        let vc = DIContainer.makeDetailViewController(id: id, type.type)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
