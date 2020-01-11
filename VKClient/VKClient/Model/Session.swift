//
//  Session.swift
//  VKClient
//
//  Created by Пазин Даниил on 11.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit

class Session {
    static let instance = Session(token: "", userId: 0)
    
    private init(token: String, userId: Int) {
        self.token = token
        self.userId = userId
    }
    
    var token: String
    var userId: Int
}
