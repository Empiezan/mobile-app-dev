//
//  Video.swift
//  MichaelChang-Lab4
//
//  Created by labuser on 7/14/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

struct Video : Decodable {
    let id : String
    let iso_639_1 : String
    let iso_3166_1 : String
    let key : String
    let name : String
    let site : String
    let size : Int
    let type : String
}
