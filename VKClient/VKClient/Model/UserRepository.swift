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

class UserRepository {
    
    func saveUserData (user: User) {
        do {
            let realm = try Realm()
            
            try realm.write {
                let userRealm = User()
                userRealm.firstName = user.firstName
                userRealm.lastName = user.lastName
                userRealm.photo = user.photo
            }
            
            realm.add(user)
            print(realm.objects(User.self ))
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}
