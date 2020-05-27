//
//  VKApi.swift
//  VKClient
//
//  Created by Пазин Даниил on 18.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class VKApi {
    
    enum RequestError: Error {
        case decodableError
    }
        // MARK: - API запросы.
    
    // Генератор ссылки на методы API.
    func vkApiConfigurator(_ apiMethod:String) -> URL? {
        let vkApi = "https://api.vk.com/method/"
        return URL(string: vkApi + apiMethod)
    }
    // Универсальная функция для формирования запроса.
    func sendRequest<T: Decodable>(requestURL: URL, method: HTTPMethod = .get, parameters: Parameters, completion: @escaping (Result<[T], Error>) -> Void) {
        AF.request(requestURL, method: method, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            
            do {
                let result = (try JSONDecoder().decode(CommonResponse<T>.self, from: data))
                completion(.success(result.response.items))
            } catch {
                completion(.failure(RequestError.decodableError))
            }
        }
    }
    // Запрос данных друзей.
    func loadUserData(token: String, completion: @escaping (Result<[User], Error>) -> Void) {
        let parameters: Parameters = [
            "access_token": token,
            "v": "5.103",
            "order": "name",
            "fields": "photo_100",
        ]
        sendRequest(requestURL: vkApiConfigurator("friends.get")!, method: .post, parameters: parameters) { completion($0) }
    }
    // Запрос данных групп.
    func loadGroupsData(token: String, completion: @escaping (Result<[GroupsRealm], Error>) -> Void) {
        let parameters: Parameters = [
            "access_token": token,
            "v": "5.103",
            "extended": "1",
            "fields": "photo_100, name"
        ]
        sendRequest(requestURL: vkApiConfigurator("groups.get")!, method: .post, parameters: parameters) { completion($0) }
    }
    // Запрос данных новостей.
    func loadNewsData(startFrom: String = "", startTime: Double? = nil, token: String, completion: @escaping (Result<[NewsItem], Error>, String) -> Void) {
        let parameters: Parameters = [
            "access_token": token,
            "v": "5.103",
            "filters": "post",
            "return_banned": 0,
            "count": 20,
            "fields": "nickname,photo_100",
            "start_from": startFrom
        ]
        AF.request(self.vkApiConfigurator("newsfeed.get")!, method: .get, parameters: parameters).responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let nextFrom = json["response"]["next_from"].stringValue
                DispatchQueue.main.async {
                //                let groups = json["response"]["groups"].arrayValue.map(GroupItem.init)
                //                let profile = json["response"]["profiles"].arrayValue.map(ProfileItems.init)
                    let news = json["response"]["items"].arrayValue.map(NewsItem.init)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(news)
                    }
                    completion(.success(news), nextFrom)
                }
            //                print(realm.configuration.fileURL)
            case let .failure(error):
                completion(.failure(error), "")
            }
        }
    }
    
    // Загрузка вотографий друга.
    func loadUserPhotos(token: String, friendID: Int, completion: @escaping (Result<[FriendPhotosItem], Error>) -> Void) {
        let parameters: Parameters = [
            "access_token": token,
            "v": "5.103",
            "owner_id": friendID,
        ]
        
        AF.request(self.vkApiConfigurator("photos.getAll")!, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                //                let groups = json["response"]["groups"].arrayValue.map(GroupItem.init)
                //                let profile = json["response"]["profiles"].arrayValue.map(ProfileItems.init)
                    let friendPhotos = json["response"]["items"].arrayValue.map(FriendPhotosItem.init)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(friendPhotos)
                    }
                    completion(.success(friendPhotos))
            //                print(realm.configuration.fileURL)
            case let .failure(error):
                completion(.failure(error))
            }
        }
        
        
        
        
    }
    
}

