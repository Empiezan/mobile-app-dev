//
//  ReleaseDate.swift
//  MichaelChang-Lab4
//
//  Created by labuser on 7/7/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

struct ReleaseDetails : Decodable {
    let certification : String!
    let iso_639_1 : String!
    let release_date : String!
    let type : Int!
    let note : String!
}
