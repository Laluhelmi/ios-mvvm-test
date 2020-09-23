//
//  File.swift
//  Mvvm
//
//  Created by laluheri on 9/22/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation

class MaterialRaw: Decodable {
    var id   : Int?
    var uuid : String?
    var sku: String?
    var unit : String?
    var nameEng: String?
    var nameChin: String?
    var defaultPrice: Double?
    var packing: String?
    
    var stores : [Store]?
}
