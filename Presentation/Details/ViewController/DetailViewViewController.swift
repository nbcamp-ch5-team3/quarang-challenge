//
//  DetailViewViewController.swift
//  Presentation
//
//  Created by Quarang on 5/10/25.
//

import UIKit
import WebKit
internal import RxSwift
internal import RxCocoa

// MARK: - 상세페이지 뷰 컨트롤러
final public class DetailViewViewController: UIViewController {
    
    private let detailView = DetailView()
    private var disposeBag = DisposeBag()
    private let viewModel: DetailViewViewModel
    
    private var isPlaying: Bool = false
    
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
        bindViewModel()
        configureRegister()
        viewModel.action.onNext(.viewDidLoad)
    }
    
    private func configureRegister() {
        detailView.getScrollView.rx.setDelegate(self).disposed(by: disposeBag)
        detailView.getScreenshotCollectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.identifier)
    }
    
    /// 데이터 바인딩
    private func bindViewModel() {
        
        // 스크린샷 이미지 바인딩
        viewModel.state.itunesDetail
            .compactMap { $0?.screenshotURLs }
            .bind(to: detailView.getScreenshotCollectionView.rx.items(
                cellIdentifier: ScreenshotCell.identifier,
                cellType: ScreenshotCell.self
            )) { _, url, cell in
                cell.configure(with: url)
            }
            .disposed(by: disposeBag)
        
        // "사이트에서 보기" 터치 이벤트
        // 앱: 앱스토어 열기
        // 뮤직, 영화, 팟캐스트: 해당 사이트 열기
        detailView.getExternalLinkButton.rx.tap
            .withLatestFrom(viewModel.state.itunesDetail)
            .compactMap { $0?.detailURL }
            .subscribe(with: self) { owner, url in
                if url.absoluteString.contains("apps.apple.com") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    let webVC = UIViewController()
                    let webView = WKWebView()
                    webView.load(URLRequest(url: url))
                    webVC.view = webView
                    webVC.modalPresentationStyle = .formSheet
                    owner.present(webVC, animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        // 미리 보기 & 미리 듣기 이벤트
        // 프리뷰 URL 중 특정 확장자만 실행
        // 뮤직: 미리 듣기 및 재생 시 음악 재생
        // 영화: 미리 보기 및 재생 시 영화 재생
        detailView.getplayerButton.rx.tap
            .subscribe(with: self) { owner, _ in
                guard let player = owner.detailView.getPlayer else { return }
                
                if owner.isPlaying {
                    player.pause()
                    if let url = try? owner.viewModel.state.itunesDetail.value()?.previewURL {
                        switch url.pathExtension {
                        case "m4a": owner.detailView.getplayerButton.setTitle("미리 듣기", for: .normal)
                        case "m4v": owner.detailView.getplayerButton.setTitle("미리 보기", for: .normal)
                        default: break
                        }
                    }
                    owner.detailView.getplayerButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                } else {
                    player.play()
                    owner.detailView.getplayerButton.setTitle("정지", for: .normal)
                    owner.detailView.getplayerButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
                }
                owner.isPlaying.toggle()
            }
            .disposed(by: disposeBag)
        
        // 뒤로 가기 버튼 이벤트 바인딩
        detailView.getDismissButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
            
        // 현재 뷰 데이터 fetch
        viewModel.state.itunesDetail
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, detail in
                guard let detail else { return }
                owner.detailView.configure(with: detail)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: 동적으로 스크롤 상태를 감지해
extension DetailViewViewController: UIScrollViewDelegate {
    
    /// 동적 스크롤 메서드
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y                 // 스크롤 상태 계산
        let contentHeight = scrollView.contentSize.height       // 스크롤 뷰의 내용 높이
        let scrollViewHeight = scrollView.frame.size.height     // 스크롤 뷰의 높이

        // 스크롤 내부 컨텐츠보다 스크롤뷰 높이와 스크롤한 높이의 합이 크거나 같은 경우
        // 스크롤의 가장 하단임
        // 스크롤의 가장 하단일 때는 해당 계산을 진행하면 스크롤 값이 변경만 되도 원래로 돌아오는 성질이 존재함으로 메서드 실행 방지
        let isAtBottom = offset + scrollViewHeight >= contentHeight
        if !isAtBottom {
            detailView.updateArtworkImageHeight(by: offset)
        }
        
    }
}
