//
//  Chests.swift
//  crapi
//
//  Created by wayo on 24/09/2018.
//  Copyright © 2018 juanjosecarracedo. All rights reserved.
//

import Foundation

struct Chests: Codable {
    let upcoming: [String]
    let superMagical, magical, legendary, epic: Int
    let giant: Int
}
