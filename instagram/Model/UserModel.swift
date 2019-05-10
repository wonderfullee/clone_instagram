//
//  UserModel.swift
//  instagram
//
//  Created by zhihao li on 4/2/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import Foundation

class UserModel {
    var name : String!
    var email : String!
    var imageURL : String!
    var title : String!
    var userID : String!
    var signDate : Date!
    
    init(userID: String!, dictionary: Dictionary< String, AnyObject >) {
        self.userID = userID
        
        if let title = dictionary["title"] as? String{
            self.title = title
        }
        
        if let email = dictionary["email"] as? String{
            self.email = email
        }
        
        if let imageURL = dictionary["imageURL"] as? String{
            self.imageURL = imageURL
        }
        
        if let signDate = dictionary["signDate"] as? Double{
            self.signDate = Date(timeIntervalSince1970: signDate) // all data must after since 1970
        }
    }
}
