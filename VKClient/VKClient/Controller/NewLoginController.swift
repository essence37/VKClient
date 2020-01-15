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
    
    // Идентификатор приложения.
    let appId = "7281932"
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webViewConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = self
        
        
        // Переход на старницу авторизации.
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        urlComponent.queryItems = [URLQueryItem(name: "7281932", value: appId),
                                   URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                   URLQueryItem(name: "display", value: "mobile"),
                                   URLQueryItem(name: "scope", value: "friends"),
                                   URLQueryItem(name: "response_type", value: "token"),
                                   URLQueryItem(name: "v", value: "5.103")]
        
        let request = URLRequest(url: urlComponent.url! )
        webView.load(request)
        view = webView
        
        
    }
     
    
}

// MARK: - Отслеживание перехода пользователя на другую страницу.

extension NewLoginController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)
        
    }
}
