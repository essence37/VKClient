//
//  ViewController.swift
//  VKClient
//
//  Created by Пазин Даниил on 18.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit
// Библиотека удалена для экономии места. Код, отвечающий за авторизацию через Firebase закомментирован.
//import Firebase

class LoginController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func loginButtonPressed(_ sender: Any) {
        // Логика авторизации при нажатии на кнопку авторизации.
        guard let login = loginInput.text,
            let password = passwordInput.text,
            login == "",
            password == "" else {
                show(message: "Incorrect login/password")
                return
        }
        performSegue(withIdentifier: "Login Segue", sender: nil)
        
        /*guard
            let email = loginInput.text,
            let password = passwordInput.text,
            email.count > 0,
            password.count > 0
            else {
                self.show(message: "Логин/пароль не введены")
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                self.show(message: error.localizedDescription)
            }
        }*/
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        /*let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = false
            textPassword.placeholder = "Enter your password"
        }
        
        let cancelAction = UIAlertAction (title: "Cancel",
                                          style: .cancel)
        
        let saveAction = UIAlertAction (title: "Save", style: .default) { _ in
            guard let emailField = alert.textFields?[0],
                let passwordField = alert.textFields?[1],
                let password = passwordField.text,
                let email = emailField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
                if let error = error {
                    self?.show(message: error.localizedDescription)
                } else {
                    Auth.auth().signIn(withEmail: email, password: password)
                }
            }
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)*/
    }
    
//    private var handle: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Жест нажатия.
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присвоение его UIScrollView.
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        /*self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "Login Segue", sender: nil)
                self.loginInput.text = nil
                self.passwordInput.text = nil
            }
        }*/
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Отписка от уведомлений при исчезновении контроллера.
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /*override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle)
    }*/
    
    // Появление клавиатуры.
    @objc func keyboardWasShown (notification: Notification) {
        // Вычисление размера клавиатуры.
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Отступ внизу UIScrollView, равный размеру клавиатуры.
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // Когда клавиатура исчезает.
    @objc func keyboardWillHidden (notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0.
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    // Исчезновение клавиатуры при клике по пустому месту на экране.
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}

