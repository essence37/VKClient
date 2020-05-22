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
            "access_token": token,//"8427888c71a913e6e460d2a21d87bf002b0e277fea43a511f6b8f99d196e906cdd8544b787bd55a37e277"
            "v": "5.103",
            "order": "name",
            "fields": "photo_100"
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
        var parameters: Parameters = [
            "access_token": token,
            "v": "5.103",
            "filters": "post",
            "return_banned": 0,
            "count": 20,
            "fields": "nickname,photo_100",
            "start_from": startFrom
        ]
        if let startTime = startTime {
            parameters["start_time"] = startTime
        }
        var news = [NewsItem]()
        AF.request(self.vkApiConfigurator("newsfeed.get")!, method: .get, parameters: parameters).responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let nextFrom = json["response"]["next_from"].stringValue
                let parsingGroup = DispatchGroup()
                //                let groups = json["response"]["groups"].arrayValue.map(GroupItem.init)
                //                let profile = json["response"]["profiles"].arrayValue.map(ProfileItems.init)
                parsingGroup.notify(queue: .global()) {
                    news = json["response"]["items"].arrayValue.map(NewsItem.init)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(news)
                    }
                    DispatchQueue.main.async {
                        completion(.success(news), nextFrom)
                    }
                }
            //                print(realm.configuration.fileURL)
            case let .failure(error):
//                print(error)
                completion(.failure(error), "")
            }
        }
    }
}

