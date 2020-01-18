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
    
    func vkApiConfigurator(_ apiMethod:String) -> URL? {
        let vkApi = "https://api.vk.com/method/"
        return URL(string: vkApi + apiMethod)
    }
    
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
    
    
    
    
}

