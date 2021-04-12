//
//  Tweet.swift
//  TwitterApp
//
//  Created by Zhaisan on 13.04.2021.
//

import Foundation
import FirebaseDatabase

struct Tweet{
    var content: String?
    var author: String?
    
    var dict: [String: String]{
        return [
            "tweet": content!,
            "author": author!
        ]
    }
    
    init(_ content: String, _ author: String){
        self.content = content
        self.author = author
    }
    
    init(snapshot: DataSnapshot){
        if let value = snapshot.value as? [String: String]{
            content = value["tweet"]
            author = value["author"]
        }
    }
    
    
    
}
