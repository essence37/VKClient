//
//  User.swift
//  VKClient
//
//  Created by Пазин Даниил on 18.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
import RealmSwift

//class UserResponse: Decodable {
//    let response: UserData
//}
//
//class UserData: Decodable {
//    let items: [User]
//}
//
//class User: Decodable {
//
//    dynamic var firstName = ""
//    dynamic var lastName = ""
//
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case lastName = "last_name"
//    }
//
//    convenience required init (from decoder: Decoder) throws {
//        self.init()
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.firstName = try values.decode(String.self, forKey: .firstName)
//        self.lastName = try values.decode(String.self, forKey: .lastName)
//    }
//
//}
//
//extension UserResponse {
//    func toUser() -> [Friend] {
//        var friends = [Friend]()
//        response.items.forEach { (friendItem) in
//            friends.append(Friend(image: (UIImage(named: "Joey")!), name: friendItem.firstName + " " + friendItem.lastName))
//        }
//        return friends
//    }
//}

class UserResponse: Decodable {
    let response: UserData
}

class UserData: Decodable {
    let items: [User]
}

class User: Object, Decodable {
    
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    convenience required init (from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
    }
    
}

extension UserResponse {
    func toUser() -> [Friend] {
        var friends = [Friend]()
        response.items.forEach { (friendItem) in
            friends.append(Friend(image: (UIImage(named: "Joey")!), name: friendItem.firstName + " " + friendItem.lastName))
        }
        return friends
    }
}
