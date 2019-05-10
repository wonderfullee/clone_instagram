//
//  PostModel.swift
//  instagram
//
//  Created by zhihao li on 4/2/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import Foundation

class PostModel{
    
    var title : String!
    var likes : Int!
    var imageURL : String!
    var ownerUID : String!
    var postID : String!
    var creationDate : Date!
    
    init(postID : String!, diction: Dictionary <String, AnyObject>) {
        
        self.postID = postID
        
        if let title = diction["title"] as? String{
            self.title = title
        }
        
        if let ownerUID = diction["ownerUID"] as? String{
            self.ownerUID = ownerUID
        }
        
        if let likes = diction["likes"] as? Int{
            self.likes = likes
        }
        
        if let imageURL = diction["imageURL"] as? String{
            self.imageURL = imageURL
        }
        
        if let creationDate = diction["Date"] as? Double{
            self.creationDate = Date(timeIntervalSince1970: creationDate) // all data must after since 1970
        }
    }
}
    

