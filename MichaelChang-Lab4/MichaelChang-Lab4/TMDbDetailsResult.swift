//
//  TMDbDetailsResult.swift
//  MichaelChang-Lab4
//
//  Created by labuser on 7/7/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

struct TMDbDetailsResult : Decodable {
    let id : Int!
    let results : [MovieDetails]
}
