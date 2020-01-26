//
//  Group.swift
//  VKClient
//
//  Created by Пазин Даниил on 18.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation
import RealmSwift

class GroupsResponse: Decodable {
    let response: GroupsData
}

class GroupsData: Decodable {
    let items: [Groups]
}

class Groups: Object, Decodable {
    
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photo = "photo_100"
    }
    
    convenience required init (from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.photo = try values.decode(String.self, forKey: .photo)
    }
    
}

extension GroupsResponse {
    func toGroups() -> [Group] {
        var myGroups = [Group]()
        response.items.forEach { (groupItem) in
            myGroups.append(Group(image: (UIImage(named: groupItem.photo)!), name: groupItem.name))
        }
        return myGroups
    }
}

