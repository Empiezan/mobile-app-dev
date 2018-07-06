//
//  TMDbSearchResults.swift
//  MichaelChang-Lab4
//
//  Created by macos on 7/5/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

struct TMDbSearchResult: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [MovieData] 
}
