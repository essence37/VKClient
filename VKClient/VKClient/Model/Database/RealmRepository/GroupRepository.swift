//
//  GroupRealm.swift
//  VKClient
//
//  Created by Пазин Даниил on 29.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation
import RealmSwift

class GroupRepository {
    
    func getAllGroups() -> Results<GroupsRealm>? {
        let realm = try? Realm()
        return realm?.objects(GroupsRealm.self)
    }
    
    func addGroups (groups: [GroupsRealm]) {
        do {
            let realm = try Realm()
            
            try realm.write {
                var groupsToAdd = [GroupsRealm]()
                groups.forEach { group in
                    let groupRealm = GroupsRealm()
                    groupRealm.id = group.id
                    groupRealm.name = group.name
                    groupRealm.photo = group.photo
                    groupsToAdd.append(groupRealm)
                }
                realm.add(groupsToAdd, update: .modified)
            }
            print(realm.objects(GroupsRealm.self))
            
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
