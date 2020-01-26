//
//  VKApi.swift
//  VKClient
//
//  Created by Пазин Даниил on 18.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
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
    
    func requestServer<T: Decodable>(requestURL: URL, parameters: Parameters, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(requestURL, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let user = (try JSONDecoder().decode(T.self, from: data))
                
                completion(.success(user))
                
            } catch {
                completion(.failure(RequestError.decodableError))
            }
        }
    }
    
    func loadUserData(token: String, completion: @escaping (Result<[Friend], Error>) -> Void) {
     
        let parameters: Parameters = [
            "access_token": token,//"8427888c71a913e6e460d2a21d87bf002b0e277fea43a511f6b8f99d196e906cdd8544b787bd55a37e277"
            "v": "5.103",
            "order": "name",
            "fields": "photo_100"
        ]
//        AF.request(vkApiConfigurator("friends.get")!, method: .get, parameters: parameters).responseData { response in
//            guard let data = response.value else { return }
//            do {
//            let user = (try JSONDecoder().decode(UserData.self, from: data)).items
//            completion(user)
//            } catch let error {
//                print(error)
//            }
//        }
        
        requestServer(requestURL: vkApiConfigurator("friends.get")!, parameters: parameters) { (users: Result<UserResponse, Error>) in
            
            switch users {
            case .failure(let error):
                completion(.failure(error))
            case .success(let friends):
                completion(.success(friends.toUser()))
            }
        }
        
    }
    
    func loadGroupsData(token: String, completion: @escaping (Result<[Group], Error>) -> Void) {
         
            let parameters: Parameters = [
                "access_token": token,//"8427888c71a913e6e460d2a21d87bf002b0e277fea43a511f6b8f99d196e906cdd8544b787bd55a37e277"
                "v": "5.103",
                "extended": "1",
                "fields": "photo_100, name"
            ]
            
            requestServer(requestURL: vkApiConfigurator("groups.get")!, parameters: parameters) { (groups: Result<GroupsResponse, Error>) in
                
                switch groups {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let groups):
                    completion(.success(groups.toGroups()))
                }
            }
            
        }
}

