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
    @objc dynamic var date: TimeInterval = Double()
    var photos: List<Photo> = .init()
    
    init(json: JSON) {
        let photoAttachments = json["attachments"].arrayValue.filter { $0["type"] == "photo" }.map(Photo.init)
        self.photos.removeAll()
        self.photos.append(objectsIn: photoAttachments)
        self.id = json["post_id"].intValue
        self.text = json["text"].stringValue
        self.date = json["date"].doubleValue
    }
    
    required init() {
        super.init()
    }
}

class Photo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var url: String?
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var aspectRatio: CGFloat { return CGFloat(height)/CGFloat(width) }
    
    
    init(json: JSON) {
        self.id = json["photo"]["id"].intValue
        if let urlString = json["photo"]["sizes"].arrayValue.last?["url"].string,
            let sizesArray = json["photo"]["sizes"].array,
            let xSize = sizesArray.first(where: { $0["type"].stringValue == "x" }) {
            self.url = urlString
            self.width = xSize["width"].intValue
            self.height = xSize["height"].intValue
        } else {
            self.url = nil
        }
    }
    
    required init() {
        super.init()
    }
}
