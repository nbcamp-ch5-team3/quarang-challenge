//
//  DetailDependencyContainerInterface.swift
//  Presentation
//
//  Created by Quarang on 5/10/25.
//

import Domain
import UIKit

// MARK: - DIP(의존성 역전 방지)를 위한 DIContainer 인터페이스 선언
public protocol DetailDIContainerInterface {
    func makeDetailViewController(id: Int, _ type: MediaType) -> UIViewController
}
