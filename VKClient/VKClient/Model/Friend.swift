//
//  Friend.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class User { // это может быть классом и структурой, и у тех и у тех есть инициализаторы
    
    // во-первых, переменные никак не могут быть let, так как данные для каждого пользователя мы будем разные использовать
    // во-вторых, здесь мы только указываем тип данных и их инициализируем, сами данные мы впишем в контроллере со списком друзей
    
    var image = UIImage() // по логике эта картинка и будет аватаром пользователя
    var name = ""
    var photos = [UIImage()] // это будет галереей пользователя, пока не используем
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    // инициализатор, когда будет галерея пользователя, пока не используем в контроллере
    init(image: UIImage, name: String, photos: [UIImage]) {
        self.image = image
        self.name = name
        self.photos = photos
    }
}
