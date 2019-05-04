//
//  NetworkManager.swift
//  hack
//
//  Created by 紫瑶 程 on 4/29/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import Foundation
import Alamofire

let loginEndpoint = "http://34.74.44.203/login/"
let addFriendEndpoint = "http://34.74.44.203/friend/request/"
let postEndpoint = "http://34.74.44.203/post/"

class NetworkManager {
    
    static func login(email: String, password: String, completion: @escaping (User?) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        Alamofire.request(loginEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let user = try? jsonDecoder.decode(User.self, from: data) {
                    completion(user)
                } else {
                    print("Invalid Response Data")
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }

    static func addFriend(user: Int, email:String, completion:@escaping (User?) -> Void){
        let parameters: [String: Any] = [
            "user_id" : user,
            "email": email,
        ]
        Alamofire.request(addFriendEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData{(response) in switch response.result{
        case .success(let data):
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print(json)
            }
            let jsonDecoder = JSONDecoder()
            if let user = try? jsonDecoder.decode(User.self, from: data) {
                completion(user)
            } else {
                print("Invalid Response Data")
                completion(nil)
            }
        case .failure(let error):
            print(error.localizedDescription)
            completion(nil)
        }
    }
  
}
    //------------------------------New---------------------------------
    static func createPost(user: Int, completion:@escaping (User?) -> Void){
        let parameters: [String: Any] = [
            "user_id" : user,
        ]
        Alamofire.request("http://34.74.44.203/post/\(MyVariables.user_id ?? -1)", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData{(response) in switch response.result{
        case .success(let data):
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print(json)
            }
            let jsonDecoder = JSONDecoder()
            if let user = try? jsonDecoder.decode(User.self, from: data) {
                completion(user)
            } else {
                print("Invalid Response Data")
                completion(nil)
            }
        case .failure(let error):
            print(error.localizedDescription)
            completion(nil)
            }
        }
        //------------------------------------------------------------
    }
}

