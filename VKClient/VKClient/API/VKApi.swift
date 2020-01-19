//
//  VKApi.swift
//  VKClient
//
//  Created by Пазин Даниил on 18.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
import Alamofire

class VKApi {
    
    func getFriendList(token: String) {

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [URLQueryItem(name: "v", value: "5.103"),
                                     URLQueryItem(name: "access_token", value: token),
                                     URLQueryItem(name: "order", value: "name"),
                                     URLQueryItem(name: "fields", value: "last_seen")]
        var request = URLRequest(url: urlConstructor.url!)
        request.httpMethod = "POST"
        let task = session.dataTask(with: request) { (data, response,error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
           print(json)
        }
        task.resume()
      }
        
        // MARK: - Через Alamofire
        
    func vkApiConfigurator(_ apiMethod:String) -> URL? {
        let vkApi = "https://api.vk.com/method/"
        return URL(string: vkApi + apiMethod)
    }

    func loadUserData(token: String, complition: @escaping ([User]) -> Void) {

//        let params = ["access token": token]
        let parameters: Parameters = [
            "access_token": token,//"8427888c71a913e6e460d2a21d87bf002b0e277fea43a511f6b8f99d196e906cdd8544b787bd55a37e277"
            "v": "5.103"
        ]

        AF.request(vkApiConfigurator("friends.get")!, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let user = try! JSONDecoder().decode(UserData.self, from: data).items
            print(user)
        }
    }
    
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
//        let url = vkApiConfigurator("friends.get")
//        urlConstructor.scheme = "https"
//        urlConstructor.host = "api.vk.com"
//        urlConstructor.path = "/method/friends.get"
//        urlConstructor.queryItems = [URLQueryItem(name: "v", value: "5.103"),
//                                     URLQueryItem(name: "access_token", value: token),
//                                     URLQueryItem(name: "order", value: "name"),
//                                     URLQueryItem(name: "fields", value: "last_seen")]
//        let task = session.dataTask(with: url!) { (data, response, error) in
//            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//            print(json)
//        }
//        task.resume()
        
        
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
//            print(json)
//        }
//        task.resume()
//
//    }
        
        
        
    
    
    
}

