//
//  SignUpViewController.swift
//  SignIn_inflearn
//
//  Created by 이재은 on 25/08/2019.
//  Copyright © 2019 jaeeun. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = signUpButton.bounds.size.height / 2
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func popVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpAPICall(_ sender: Any) {
        let params = ["name": userNameTextField.text,
                      "password": passwordTextField.text,
                      "email": emailTextField.text]
        
        if let url = URL(string: "http://localhost:3000/loginUsers") {
            var request = URLRequest.init(url: url)
            
            request.httpMethod = "POST"
            request.httpBody = params.queryString.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(LoginUser.self, from: data)
                    
                    User.shared.info = user
                    
                    self.dismiss(animated: true, completion: nil)
                    
                    NotificationCenter.default
                        .post(name: NSNotification.Name.init("UserInfoLoad"),
                              object: nil)
                    
                } catch {
                    print("Sign Up Error: \(error)")
                }
            }.resume()
        }
    }
}
