//
//  Photos.swift
//  VKClient
//
//  Created by Пазин Даниил on 26.05.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class FriendPhotosItem: Object {
    @objc dynamic var id: Int = 0
    var photos: List<Photo> = .init()
    
    init(json: JSON) {
        let photoSizes = json["sizes"].arrayValue.map(Photo.init)
        self.photos.removeAll()
        self.photos.append(objectsIn: photoSizes)
        self.id = json["owner_id"].intValue
    }
    
    required init() {
        super.init()
    }
}

class Photos: Object {
    @objc dynamic var url: String?
    
    init(json: JSON) {
        if let urlString = json.arrayValue.last?["url"].string {
            self.url = urlString
        } else {
            self.url = nil
        }
    }
    
    required init() {
        super.init()
    }
}
