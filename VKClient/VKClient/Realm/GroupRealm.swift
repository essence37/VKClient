//
//  GroupRealm.swift
//  VKClient
//
//  Created by Пазин Даниил on 29.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation
import RealmSwift

func saveGroupsData (_ groups: [Groups]) {
    do {
        let realm = try Realm()
        print(realm.configuration.fileURL)
        realm.beginWrite()
        
        realm.add(groups)
        
        try realm.commitWrite()
    } catch {
        print(error)
    }
}
