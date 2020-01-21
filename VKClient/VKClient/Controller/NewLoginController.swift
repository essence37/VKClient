//
//  NewLoginController.swift
//  VKClient
//
//  Created by Пазин Даниил on 14.01.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation
import Alamofire
import WebKit

class NewLoginController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    var vkApi = VKApi()
    
    // Идентификатор приложения.
    let appId = "7281932"
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let webViewConfig = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        
        
        
        // Переход на старницу авторизации.
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        urlComponent.queryItems = [URLQueryItem(name: "client_id", value: appId),
                                   URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                   URLQueryItem(name: "display", value: "mobile"),
                                   URLQueryItem(name: "scope", value: "friends"),
                                   URLQueryItem(name: "response_type", value: "token"),
                                   URLQueryItem(name: "v", value: "5.103")]
        
        let request = URLRequest(url: urlComponent.url! )
        webview.load(request)
//        view = webView
        
        
    }
     
    
}

// MARK: - Отслеживание перехода пользователя на другую страницу.

extension NewLoginController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components (separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
//        print(token)
        
        Session.instance.token = token!
        Session.instance.userId = Int(params["user_id"]!) ?? 0
    
//        vkApi.getFriendList(token: Session.instance.token)

        
        performSegue(withIdentifier: "Login Segue", sender: nil)
        
        decisionHandler(.cancel)

    }
    
}

