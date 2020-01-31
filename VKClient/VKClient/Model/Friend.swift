//
//  Friend.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import Foundation
import RealmSwift


class Friend: Object { // это может быть классом и структурой, и у тех и у тех есть инициализаторы
    
    // во-первых, переменные никак не могут быть let, так как данные для каждого пользователя мы будем разные использовать
    // во-вторых, здесь мы только указываем тип данных и их инициализируем, сами данные мы впишем в контроллере со списком друзей
    
    @objc dynamic var image = "" // по логике эта картинка и будет аватаром пользователя
    @objc dynamic var name = ""
//    var photos = [UIImage()] // это будет галереей пользователя, пока не используем
    
    convenience init(json: JSON) {
        self.init()
        
        self.image = json["items"][0]["photo_100"].stringValue
        self.name = json["items"][0]["first_name"].stringValue
    }
    
//    // инициализатор, когда будет галерея пользователя, пока не используем в контроллере
//    init(image: UIImage, name: String, photos: [UIImage]) {
//        self.image = image
//        self.name = name
//        self.photos = photos
//    }
    
}
