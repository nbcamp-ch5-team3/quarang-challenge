//
//  CategoryCell.swift
//  Presentation
//
//  Created by Quarang on 5/14/25.
//

import UIKit
import Domain

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    private let label = PaddedLabel(vertical: 8, horizontal: 16).then {
        $0.backgroundColor = .systemGray5
        $0.textColor = .label
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    /// 뷰 추가 및 설정
    private func configureViews() {
        contentView.addSubview(label)
    }
    /// 오토레이아웃 설정
    private func configureLayout() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 셀 외부에서 데이터 업데이트
    func configure(entity: ITunesEntity, selected: Bool) {
        label.text = "\(entity.image) \(entity.label)"
        label.backgroundColor = selected ? .systemBlue : .systemGray5
        label.textColor = selected ? .white : .label
    }
}




//import UIKit
//import Domain
//internal import RxSwift
//
//class CategoryCell: UICollectionViewCell {
//    
//    static let identifier = "CategoryCell"
//    var tapSubject = PublishSubject<ITunesEntity>()
//    var disposeBag = DisposeBag()
//    private var entity: ITunesEntity?
//    
//    private let button = UIButton(configuration: .filled()).then {
//        $0.layer.cornerRadius = 8
//        $0.clipsToBounds = true
//        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
//        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configureViews()
//        configureLayout()
//        bind()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
//    
//    /// 버튼 바인딩
//    private func bind() {
//        button.rx.tap
//            .withUnretained(self)
//            .subscribe(onNext: { owner, _  in
//                if let entity = owner.entity {
//                    owner.tapSubject.onNext(entity)
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    /// 뷰 추가 및 설정
//    private func configureViews() {
//        contentView.addSubview(button)
//    }
//    /// 오토레이아웃 설정
//    private func configureLayout() {
//        button.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//    
//    /// 셀 외부에서 데이터 업데이트
//    func configure(entity: ITunesEntity, selected: Bool) {
//        self.entity = entity
//        
//        var config = button.configuration
//        config?.title = "\(entity.image) \(entity.label)"
//        config?.baseBackgroundColor = selected ? .systemBlue : .systemGray5
//        config?.baseForegroundColor = selected ? .white : .label
//        button.configuration = config
//    }
//    
//    var getButton: UIButton { button }
//}
