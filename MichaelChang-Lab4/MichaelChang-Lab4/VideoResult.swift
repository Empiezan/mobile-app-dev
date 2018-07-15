//
//  VideoResult.swift
//  MichaelChang-Lab4
//
//  Created by labuser on 7/14/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

struct VideoResult : Decodable {
    let id : Int!
    let results : [Video]
}
