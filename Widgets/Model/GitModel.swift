//
//  GitModel.swift
//  Widgets
//
//  Created by Webcash on 2023/02/09.
//

import Foundation

struct GitModel: Codable {
    
    struct Request: Encodable {
        
    }
    
    struct Response: Decodable {
        let gitData: [GitData]
        
        
        struct GitData: Decodable {
            let commit: Commit
            
            struct Commit: Decodable {
                let author: Author
                let message: String
                let url: String
                
                struct Author: Decodable {
                    let name: String
                    let email: String
                    let date: String
                }
            }
        }
//        let url: String
//        let state: String
//        let title: String
//        let user: User
//        let createdDate: String
//        let updatedDate: String
//
//        enum CodingKeys: String, CodingKey {
//            case url = "html_url"
//            case state
//            case title
//            case user
//            case createdDate = "created_at"
//            case updatedDate = "updated_at"
//        }
//
//        struct User: Decodable {
//            let name: String
//            let imageUrl: String
//
//            enum CodingKeys: String, CodingKey {
//                case name = "login"
//                case imageUrl
//            }
//        }
    }
}
