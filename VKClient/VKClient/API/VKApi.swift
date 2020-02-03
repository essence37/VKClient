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

class VKApi {
    
    enum RequestError: Error {
        case decodableError
    }
    
//    func getFriendList(token: String) {
//
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
//        var urlConstructor = URLComponents()
//        urlConstructor.scheme = "https"
//        urlConstructor.host = "api.vk.com"
//        urlConstructor.path = "/method/friends.get"
//        urlConstructor.queryItems = [URLQueryItem(name: "v", value: "5.103"),
//                                     URLQueryItem(name: "access_token", value: token),
//                                     URLQueryItem(name: "order", value: "name"),
//                                     URLQueryItem(name: "fields", value: "last_seen")]
//        var request = URLRequest(url: urlConstructor.url!)
//        request.httpMethod = "POST"
//        let task = session.dataTask(with: request) { (data, response,error) in
//            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//           print(json)
//        }
//        task.resume()
//      }
        
        // MARK: - Универсальная функция для формирования запроса.
        
    func vkApiConfigurator(_ apiMethod:String) -> URL? {
        let vkApi = "https://api.vk.com/method/"
        return URL(string: vkApi + apiMethod)
    }
    
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
    
    func loadUserData(token: String, completion: @escaping (Result<[User], Error>) -> Void) {
        let parameters: Parameters = [
            "access_token": token,//"8427888c71a913e6e460d2a21d87bf002b0e277fea43a511f6b8f99d196e906cdd8544b787bd55a37e277"
            "v": "5.103",
            "order": "name",
            "fields": "photo_100"
        ]
        
        sendRequest(requestURL: vkApiConfigurator("friends.get")!, method: .post, parameters: parameters) { completion($0) }
    }
    
    func loadGroupsData(token: String, completion: @escaping (Result<[GroupsRealm], Error>) -> Void) {
         
            let parameters: Parameters = [
                "access_token": token,//"8427888c71a913e6e460d2a21d87bf002b0e277fea43a511f6b8f99d196e906cdd8544b787bd55a37e277"
                "v": "5.103",
                "extended": "1",
                "fields": "photo_100, name"
            ]
            
        sendRequest(requestURL: vkApiConfigurator("groups.get")!, method: .post, parameters: parameters) { completion($0) }
    }
}

