//
//  Group.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit
import RealmSwift

struct GroupItems: Decodable {
    var id: Int
    var name: String
    var photo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_100"
    }
}
