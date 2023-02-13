//
//  Network.swift
//  Widgets
//
//  Created by Webcash on 2023/02/13.
//

import Foundation
import Combine

class Network {
    
    // Handle your request errors
    enum Error: LocalizedError {
        case invalidResponse
        case addressUnreachable(URL)
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse:
                return "The server responded with garbage."
            case .addressUnreachable(let url):
                return "\(url.absoluteString) is unreachable."
            }
        }
    }
    
    let url: URL = URL(string: "https://api.github.com/repos/juanagustin0504/WidgetWithDynamicIsland/commits")!
    
    let networkQueue = DispatchQueue(label: "Network",
                                     qos: .default,
                                     attributes: .concurrent)
    
    func fetch(url: String, completion: @escaping (Result<Any?, NSError>) -> Void) {
        let url = URL(string: url)
        guard let url = url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard let data = data else { return }
            
            guard let responseObj = data.dataToDecodableObject(responseType: [GitResponse].self) else {
                let error = NSError(domain: "decode error", code: 168, userInfo: [NSLocalizedDescriptionKey : "enc_yn decode error"])
                completion(.failure(error))
                return
            }
            completion(.success(responseObj))
        }.resume()
        
    }
    
}
