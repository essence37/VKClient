//
//  File.swift
//  VKClient
//
//  Created by Пазин Даниил on 12.05.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON
import PromiseKit

class Future {
    
    enum RequestError: Error {
        case decodableError
    }
    // MARK: - API запросы.
    
    // Генератор ссылки на методы API.
    func vkApiConfigurator(_ apiMethod:String) -> URL? {
        let vkApi = "https://api.vk.com/method/"
        return URL(string: vkApi + apiMethod)
    }
    
    // Запрос данных друзей.
    func loadUsers(token: String) -> Promise<[User]> {
        let parameters: Parameters = [
            "access_token": token,//"8427888c71a913e6e460d2a21d87bf002b0e277fea43a511f6b8f99d196e906cdd8544b787bd55a37e277"
            "v": "5.103",
            "order": "name",
            "fields": "photo_100"
        ]
        let promise = Promise<[User]> { resolver in
            AF.request(vkApiConfigurator("friends.get")!, method: .get, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    //                            if let errorMessage = json["message"].string {
                    //                                let error = WeatherError.cityNotFound(message: errorMessage)
                    //                                // Заменяем completion на вызов резолвера
                    //                                resolver.reject(error)
                    //                                return
                    //                            }
                    
                    let friends = json["response"]["items"].arrayValue.map { User(value: $0) }
                    // Заменяем completion на вызов резолвера
                    resolver.fulfill(friends)
                case .failure(let error):
                    // Заменяем completion на вызов резолвера
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
}

