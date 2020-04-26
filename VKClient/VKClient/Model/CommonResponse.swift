//
//  CommonResponse.swift
//  VKClient
//
//  Created by Пазин Даниил on 31.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation

struct CommonResponse<T: Decodable>: Decodable {
    var response: CommonResponseArray<T>
    
}

struct CommonResponseArray<T: Decodable>: Decodable {
    var count: Int
    var items: [T]
    
}
