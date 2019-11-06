//
//  ViewController.swift
//  VKClient
//
//  Created by Пазин Даниил on 18.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let login = loginInput.text,
            let password = passwordInput.text,
            login == "",
            password == "" else {
                show(message: "Incorrect login/password")
                return
        }
        
        performSegue(withIdentifier: "Login Segue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

