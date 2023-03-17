//
//  Network.swift
//  Widgets
//
//  Created by Webcash on 2023/02/13.
//

import Foundation
import Combine

class Network {
    private static var sharedInstance   = Network()
    private static var sessionConfig    : URLSessionConfiguration!
    private static var session          : URLSession!
    private static var userAgent        = "Mozilla/5.0 (%@; U; CPU %@ %@ like Mac OS X; ko-kr) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148;nma-plf=IOS;nma-bizplay20=Y;nma-app-ver=1.6.4;nma-plf-ver=16.3.1;nma-model=iPhone;nma-app-id=com.webcash.bizzeropay;nma-app-cd=1a42751d95908c4856d0daf5b3ee7f14;nma-dev-id=4E3BF60C-ACF3-41AE-92C9-6DB0A0053D22;nma-netnm=LG U+;nma-phoneno=;nma-adr-id=;"
    
    static var shared: Network = {
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.urlCache?.removeAllCachedResponses() // clear URL cache
        // Timeout Configuration
        session = URLSession(configuration: sessionConfig)
        return sharedInstance
    }()
    
    func fetch<I: Encodable, O : Decodable>(url: String, body: I, responseType : O.Type, completion: @escaping (Result<O, NSError>) -> Void) {
        let url = URL(string: url)
        guard let url = url else { return }
        
        var urlRequest = self.urlRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let strQuery = self.queryString(body: body)
        let jsonBody = "_JSON_=\(strQuery)"
        urlRequest.httpBody = jsonBody.data(using: .utf8)
        urlRequest.setValue(Network.userAgent, forHTTPHeaderField: "User-Agent")
        
        print("\n\n|||||||||| REQUEST |||||||||| \n\(jsonBody)")
        
        Network.session.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data else { return }
            
            //---쿠키 저장하기-------------------
            if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                let cookies: [HTTPCookie] = HTTPCookie.cookies(withResponseHeaderFields: fields, for: response!.url!)
//                if cookies.count != 0 {
//                    cookies.forEach { cookie in
//                        if cookie.name == "JSESSIONID" {
//                            SharedFunction.shared.cookies = cookies
//                            return
//                        }
//                    }
//                    
//                }
            }
            
            guard let responseObj = data.dataToDecodableObject(responseType: O.self) else {
                let error = NSError(domain: "decode error", code: 168, userInfo: [NSLocalizedDescriptionKey : "enc_yn decode error"])
                completion(.failure(error))
                return
            }
            print("\n\n::::::::: RESPONSE ::::::::: \n\(responseObj)")
            completion(.success(responseObj))
        }.resume()
        
    }
    
    func urlRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        guard let cookies = HTTPCookieStorage.shared.cookies(for: url) else {
            return request
        }
        
        request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: cookies)
//        if SharedFunction.shared.cookies.count != 0 {
//            request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: SharedFunction.shared.cookies)
//        }
        
        return request
    }
    
    private func queryString<T:Encodable>(body:T) -> String {
        let request = body
        guard let str = request.asJSONString() else {
            return ""
        }
        return str
    }
}

extension Encodable {
    func asJSONString() -> String? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            return nil
        }
    }
}
