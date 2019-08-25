//
//  ViewController.swift
//  SignIn_inflearn
//
//  Created by 이재은 on 25/08/2019.
//  Copyright © 2019 jaeeun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(infoReload), name: Notification.Name.init("UserInfoLoad"), object: nil)
    }
    
    @objc func infoReload() {
        DispatchQueue.main.async {
            self.userInfoLabel.text = User.shared.info.email
        }
    }
    
    @IBAction func moveToSignIn(_ sender: Any) {
        
        let signInVC = UIStoryboard(name: "SignInVC", bundle: nil).instantiateViewController(withIdentifier: "naviSignIn")
        present(signInVC, animated: true)
    }
    
}

