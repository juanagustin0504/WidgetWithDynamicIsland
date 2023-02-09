//
//  PullRequest.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import Foundation

struct PullRequest {
    struct Request: Encodable {
        
    }
    
    struct Response: Decodable {
        let title: String
        let date: String
        let url: String
    }
}
