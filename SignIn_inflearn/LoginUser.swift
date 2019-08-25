//
//  LoginUser.swift
//  SignIn_inflearn
//
//  Created by 이재은 on 25/08/2019.
//  Copyright © 2019 jaeeun. All rights reserved.
//

import Foundation

// singleton : 인스턴스가 한번 생성되면 계속 유지되서 같은 값이 나오는 형태

class User {
    static let shared = User()
    var info = LoginUser()
    
    // 외부에서 다른 인스턴스로 생성하지 못하도록
    private init() {
        
    }
}

struct LoginUser: Codable {
    
    init() {
        name = ""
        password = ""
        email = ""
        id = 0
        locations = [LocationModel]()
    }
    
    struct LocationModel: Codable {
        let city: String
        let state: String
    }
    
    let name: String
    let password: String
    let email: String
    let id: Int
    let locations: [LocationModel]?
}

// 옵셔널로 했을 때 post 옵셔널 언래핑해서 어떻게 보내는지..?
