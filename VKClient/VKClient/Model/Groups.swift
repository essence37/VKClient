//
//  Group.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

struct GroupItem: Decodable {
    let id: Int
    let name: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_100"
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_100"].string ?? json["photo_50"].stringValue
    }
}
