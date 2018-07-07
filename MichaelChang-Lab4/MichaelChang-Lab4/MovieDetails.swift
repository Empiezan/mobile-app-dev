//
//  MovieDetails.swift
//  MichaelChang-Lab4
//
//  Created by labuser on 7/7/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

struct MovieDetails : Decodable {
    let iso_3166_1: String!
    let release_dates: [ReleaseDetails]
}
