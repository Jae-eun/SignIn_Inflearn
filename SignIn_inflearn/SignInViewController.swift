//
//  SignInViewController.swift
//  SignIn_inflearn
//
//  Created by 이재은 on 25/08/2019.
//  Copyright © 2019 jaeeun. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let loginURLString = "http://localhost:3000/loginUsers"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = signInButton.bounds.size.height / 2
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func moveToSignUp(_ sender: Any) {
        let signUpVC = UIStoryboard(name: "SignUpVC",
                                    bundle: nil)
            .instantiateViewController(withIdentifier: "SignUpViewController")
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func signInAPICall(_ sender: Any) {
        
        let param = ["username": usernameTextField.text ?? "",
                     "password": passwordTextField.text ?? ""]
        
        var urlComponents = URLComponents(string: loginURLString)
        urlComponents?.query = param.queryString
        
        guard let hasURL = urlComponents?.url else { return }
        
        URLSession.shared.dataTask(with: hasURL) { (data, response, error) in
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let user = try decoder.decode([LoginUser].self, from: data)
                
                if let hasUserInfo = user.first {
                    User.shared.info = hasUserInfo
                    self.dismiss(animated: true, completion: nil)
                    
                    NotificationCenter.default
                        .post(name: NSNotification.Name.init("UserInfoLoad"),
                              object: nil)
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController.init(title: "유저정보가 없음",
                                                           message: nil,
                                                           preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "확인",
                                                      style: .default))
                        alert.addAction(UIAlertAction(title: "취소",
                                                      style: .default))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } catch {
                print("error: \(error)")
            }
        }.resume()
    }
}
