//
//  Common.swift
//  SignIn_inflearn
//
//  Created by 이재은 on 25/08/2019.
//  Copyright © 2019 jaeeun. All rights reserved.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var output = ""
        for (key, value) in self {
            output = output + "\(key)=\(value)&"
        }
        
        output = String(output.dropLast())
        return output
    }
}
