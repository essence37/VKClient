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
        // Установка webview в качестве делегата контроллер.
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    var vkApi = VKApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Передача URL в WKWebView.
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        urlComponent.queryItems = [URLQueryItem(name: "client_id", value: "7281932"),
                                   URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                   URLQueryItem(name: "display", value: "mobile"),
                                   URLQueryItem(name: "scope", value: "wall,photos,offline,friends,stories,status,groups"),
                                   URLQueryItem(name: "response_type", value: "token"),
                                   URLQueryItem(name: "v", value: "5.103")]
        
        let request = URLRequest(url: urlComponent.url! )
        // Переход на старницу авторизации.
        webview.load(request)
    }
}

// MARK: - Отслеживание перехода пользователя на другую страницу.

extension NewLoginController: WKNavigationDelegate {
    // Метод, перехватывающий ответы сервера при переходе.
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // Проверка URL, на который было совершено перенаправление.
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        // Обработка URL, если проверка пройдена.
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
        // Запись токена и ID пользователя.
        Session.instance.token = token!
        Session.instance.userId = Int(params["user_id"]!) ?? 0
//
////        vkApi.getFriendList(token: Session.instance.token)
//        VKApi().fetchNews()
//
        // Переход на другую странцу.
        performSegue(withIdentifier: "Login Segue", sender: nil)
        
        decisionHandler(.cancel)
    }
}

//        var webView: WKWebView!
//        let webViewConfig = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webViewConfig)
//        view = webView
//        webview.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] cookies in
//            cookies.forEach { self?.webView.configuration.websiteDataStore.httpCookieStore.delete($0) }
//        }
