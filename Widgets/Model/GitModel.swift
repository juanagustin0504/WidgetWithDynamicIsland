//
//  GitModel.swift
//  Widgets
//
//  Created by Webcash on 2023/02/09.
//

import Foundation

struct GitResponse: Decodable {
    var commit: Commit
    
    struct Commit: Decodable {
        var author: Author
        var message: String
        var url: String
        
        struct Author: Decodable {
            var name: String
            var email: String
            var date: String
        }
    }
}
