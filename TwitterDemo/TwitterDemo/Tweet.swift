//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Zhaisan on 11/04/21.
//

import Foundation
import FirebaseDatabase

struct Tweet {
    var content: String?
    var author: String?
    var date: String?
    var hashtag: String?
    var name: String?
    var surname: String?
    var dict: [String: String] {
        return 
            ["tweet": content!,
             "author": author!,
             "date": date!,
             "hashtag": hashtag!,
             "name": name!,
             "surname": surname!
            ]
    }
    
    init(_ content: String, _ author: String, _ date: String, _ hashtag: String, _ name: String, _ surname: String ) {
        self.content = content
        self.author = author
        self.date = date
        self.hashtag = hashtag
        self.name = name
        self.surname = surname
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String] {
            content = value["tweet"]
            author = value["author"]
            date = value["date"]
            hashtag = value["hashtag"]
            name = value["name"]
            surname = value["surname"]
        }
    }
    
}
