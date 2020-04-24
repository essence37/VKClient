//
//  NewsItem.swift
//  VKClient
//
//  Created by Andrey Antropov on 17.02.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class NewsItem: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var text: String = String()
    var photos: List<Photo> = .init()
    
    init(json: JSON) {
        let photoAttachments = json["attachments"].arrayValue.filter { $0["type"] == "photo" }.map(Photo.init)
        self.photos.removeAll()
        self.photos.append(objectsIn: photoAttachments)
        self.id = json["post_id"].intValue
        self.text = json["text"].stringValue
    }
    
    required init() {
        super.init()
    }
}

class Photo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var url: String?
    
    init(json: JSON) {
        self.id = json["photo"]["id"].intValue
        if let urlString = json["photo"]["sizes"].arrayValue.last?["url"].string {
            self.url = urlString
        } else {
            self.url = nil
        }
    }
    
    required init() {
        super.init()
    }
}
