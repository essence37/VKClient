//
//  Realm.swift
//  VKClient
//
//  Created by Пазин Даниил on 26.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation
import RealmSwift

 // MARK: - Сохранение данных о друзьях в Realm

func saveUserData (_ users: [User]) {
    do {
        let realm = try Realm()
        
        realm.beginWrite()
        
        realm.add(users)
        
        try realm.commitWrite()
    } catch {
        print(error)
    }
}


func saveGroupsData (_ groups: [Groups]) {
        do {
            let realm = try Realm()
            
            realm.beginWrite()
            
            realm.add(groups)
            
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
