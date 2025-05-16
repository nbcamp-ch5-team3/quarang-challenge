//
//  Extension+ITunes.swift
//  Presentation
//
//  Created by Quarang on 5/16/25.
//

import Foundation
import Domain

extension ITunesDetail {
    
    var toITunes: ITunes {
        ITunes(id: id,
               title: title,
               subtitle: subtitle ?? "",
               imageURL: artworkURL,
               detailURL: detailURL,
               genre: genre,
               priceText: priceText,
               releaseDate: releaseDate)
    }
}
