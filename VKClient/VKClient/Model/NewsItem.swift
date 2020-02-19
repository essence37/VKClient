//
//  NewsItem.swift
//  VKClient
//
//  Created by Andrey Antropov on 17.02.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsItem {
    let id: Int
    let text: String
    let photos: [Photo]
    
    init(json: JSON) {
        let photoAttachments = json["attachments"].arrayValue.filter { $0["type"] == "photo" }.map(Photo.init)
        self.photos = photoAttachments
        self.id = json["post_id"].intValue
        self.text = json["text"].stringValue
    }
}

class Photo {
    let id: Int
    let url: URL?
    
    init(json: JSON) {
        self.id = json["photo"]["id"].intValue
        if let urlString = json["photo"]["sizes"].arrayValue.last?["url"].string {
            self.url = URL(string: urlString)
        } else {
            self.url = nil
        }
    }
}
