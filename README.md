# 📱 ITunes App

## 📌 소개

해당 프로젝트는 Apple iTunes Search API를 활용하여 음악, 영화, 앱, 팟캐스트 등의 콘텐츠를 검색하고,  
미리보기 및 상세 정보를 제공하는 iOS 애플리케이션입니다.

## ✨ 주요 기능
- 기존 요구사항은 메인화면에서 `Musinc`만을 보여줘야 했지만 탭바를 생성해 `Movie`, `App`, `Podcast` 정보를 선택해서 볼 수 있도로 구현
![스크린샷 2025-05-17 오후 12 44 55](https://github.com/user-attachments/assets/267cd68c-8b31-4744-b6c5-9fd1d96afa3d)
- 하향식 프로그래밍 개발 방법론을 도입해 프로젝트 이전에 아키텍쳐 설계와 가능 명세를 진행
![스크린샷 2025-05-17 오후 12 45 38](https://github.com/user-attachments/assets/6185ee62-d698-4a8c-b304-436633ee30d4)
- 각 계층을 프레임워크로 물리적 모듈화 진행
- 카테고리 기반 콘텐츠 탐색 (음악, 영화, 앱, 팟캐스트)
- 콘텐츠 미리보기 재생 (오디오/비디오)
- 상세 정보 조회 (스크린샷, 설명, 장르 등)
- 외부 링크 연동 (앱스토어, 웹)
- 스크롤 기반 이미지뷰 동적 반응형 UI

## 📷 스크린샷


| 설명 | 뷰 |
|:--:|:--:|
|메인화면|<img src ="https://github.com/user-attachments/assets/36759d93-52d6-4c25-8172-e0c451ebff82" width = 250>|
|탭바|<img src = "https://github.com/user-attachments/assets/36759d93-52d6-4c25-8172-e0c451ebff82" width = 250>|
|검색|<img src = "https://github.com/user-attachments/assets/f3c6b688-8704-48c5-aaca-7db113d86832" width = 250>|
|앱 상세페이지|<img src = "https://github.com/user-attachments/assets/c8a83d5f-4673-493e-9c7e-3511fa37f49c" width = 250>|
|영화 상세화면|<img src = "https://github.com/user-attachments/assets/791dcdcb-0af4-4b9b-9137-2c7ab457017e" width = 250>|

---

## 🛠 기술 스택

| 영역 | 사용 기술 |
|------|-----------|
| 언어 | Swift 5.9 |
| UI 프레임워크 | UIKit |
| 비동기 처리 | RxSwift, RxCocoa |
| API 통신 | URLSession |
| 구조 | MVVM + Clean Architecture |
| 외부 라이브러리 | SnapKit, RxSwift, RxDataSources, Then |

---

## 기술적 고민

### 1. 🔍 병렬 요청과 안전한 UI 바인딩 처리 고민

시즌(봄/여름/가을/겨울)별 iTunes 데이터를 동시에 요청하고, 각각의 결과를 정확한 위치에 바인딩하는 구조가 필요했습니다.

RxSwift를 활용하면서 다음의 두 가지를 가장 중요하게 고려했습니다.

1.	요청은 병렬, 결과는 순서대로
2.	Relay 바인딩은 항상 MainThread에서

```swift
//ITunesViewModel.swift

let terms = ["봄", "여름", "가을", "겨울"]
let relays = [springItems, summerItems, autumnItems, winterItems]

let requests = terms.map {
    useCase.execute(term: $0, type)
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .asObservable()
}

Observable.zip(requests)
    .observe(on: MainScheduler.instance)
    .subscribe(onNext: { results in
        zip(relays, results).forEach { $0.accept($1) }
    })
    .disposed(by: disposeBag)
```

🎯 핵심 고려사항
-	zip을 사용해 응답 순서 보장
-	각각을 background에서 병렬 실행
-	메인 스레드에서 Relay 업데이트로 UI 안정성 확보

병렬성과 정확한 데이터 대응, UI 스레드 안전성을 함께 만족시키기 위한 구조로 설계했습니다.

---

### 2. 🎛 단일 선택형 카테고리 처리 고민

UICollectionView 기반 카테고리 UI에서 하나만 선택 가능하도록 처리해야 했습니다.

UIKit은 UISegmentedControl 외에는 기본적으로 단일 선택 UI를 제공하지 않기 때문에, 직접 구현이 필요했습니다.

```swift
//ITunesViewController.swift

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
```

💡 설계 고민 포인트
-	선택된 항목만 강조되고, 이전 항목은 자동으로 해제되도록 구현
-	attributes 값을 통해 현재 선택 상태를 추적하고 비교
- 두 개의 IndexPath만 reloadItems 하여 스크롤 위치나 레이아웃 튐 없이 최소한의 렌더링 처리

이처럼 Rx + UICollectionView에서 단일 선택 UI를 수동 구현하며, 선택 상태 추적, 이전/현재 diff 비교, 최소한의 reload 등 효율성과 사용자 경험을 함께 고려했습니다.

---

### 3. 🎨 스크롤 기반 이미지뷰 반응형 처리

상단 artworkImageView를 스크롤에 따라 자연스럽게 축소시키는 기능을 구현하면서 다음과 같은 고민이 있었습니다.
-	뷰의 height를 실시간으로 조절해야 함 (SnapKit 기반)
-	무한 스크롤 또는 과도한 제약 변경에 따른 충돌 방지
- 완전히 스크롤된 상태에서는 불필요한 업데이트 방지

```swift
// DetailViewController.swift

func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let scrollViewHeight = scrollView.frame.size.height

    // 하단 도달 시 layout 되돌아오는 현상 방지
    let isAtBottom = offset + scrollViewHeight >= contentHeight
    if !isAtBottom {
        detailView.updateArtworkImageHeight(by: offset)
    }
}
```
```swift
// DetailView.swift

func updateArtworkImageHeight(by offsetY: CGFloat) {
    guard originalArtworkHeight > 0 else { return }

    let progress = min(max(offsetY / 200, 0), 1)
    let adjustedHeight = originalArtworkHeight * -progress
    artworkHeightConstraint?.update(offset: adjustedHeight)
    artworkImageView.alpha = 1 - progress
}
```

🎯 설계 고려사항
- offsetY / 200 → progress: 스크롤을 200pt 기준으로 정규화하여 0~1 비율 산출
- progress 값 클램핑: min/max로 0~1 범위로 고정 → 과도한 축소 방지
- SnapKit 제약 안전 업데이트: .constraint 저장 후 .update() 호출로 런타임 에러 회피
- 하단 도달 시 무효 업데이트 방지: 스크롤 끝에서 레이아웃 되돌아오는 현상 막기 위해 isAtBottom 조건 추가

이처럼 사용자 스크롤에 자연스럽게 반응하는 인터랙션을 구현하면서 UI 자연스러움 + 런타임 안정성을 동시에 고려했습니다.
퍼포먼스와 안정성 모두 만족시키기 위한 세밀한 컨트롤을 적용한 부분입니다.

---

## 📁 프로젝트 구조


- App
```
App/
├── AppDelegate.swift
├── SceneDelegate.swift
└── DIContainer/
└── DIContainer.swift
```
- Domain
```
├── Domain/
│   ├── DTO/
│   │   ├── Model/
│   ├── Error/
│   ├── Extension/
│   ├── Sources/
│   │   ├── RepositoryInterface/
│   │   ├── UseCase/
│   │   └── UseCaseInterface/
│   └── Type/
```
- Data
```
├── Data/
│   ├── Sources/
│   │   ├── Core/
│   │   ├── Manager/
│   │   └── Repository/
│   └── Data/
```
- Presentation
```
├── Presentation/
│   ├── Details/
│   │   ├── DIContainerInterface/
│   │   ├── View/
│   │   ├── ViewController/
│   │   └── ViewModel/
│   ├── ITunes/
│   │   ├── View/
│   │   ├── ViewController/
│   │   └── ViewModel/
│   ├── Search/
│   │   ├── View/
│   │   ├── ViewController/
│   │   └── ViewModel/
│   └── Resources/
├── Utils/
│   ├── Base/
│   ├── Cell/
│   ├── Components/
│   ├── Extension/
│   ├── Protocol/
│   └── Type/
```
