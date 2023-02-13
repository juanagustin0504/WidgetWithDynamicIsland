//
//  SharedFunction.swift
//  Widgets
//
//  Created by Webcash on 2023/01/12.
//

import Foundation

struct SharedFunction {
    
    static let shared = SharedFunction()
    
    func setUserDefaultsValue(_ value: String, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
}

extension Data {
    /// Convert Data to NSDictionary
    func dataToDic() -> NSDictionary {
        guard let dic: NSDictionary = (try? JSONSerialization.jsonObject(with: self, options: [])) as? NSDictionary else {
            return [:]
        }
        
        return dic
    }
    
    func prettyPrint() -> String {
        if JSONSerialization.isValidJSONObject(self.dataToDic()) {
            if let data = try? JSONSerialization.data(withJSONObject: self.dataToDic(), options: JSONSerialization.WritingOptions.prettyPrinted) {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    func dataToDecodableObject<O: Decodable>(responseType type : O.Type) -> O? {

        guard let responseObject = try? JSONDecoder().decode(type.self, from: self) else {
            if self.prettyPrint() == "{\n\n}" {
                
                let htmlString = String(data: self, encoding: .utf8) ?? ""
                
                print("error response::: \(self.prettyPrint())")
            }
            else {
                print("Error Response Mapping: \(self.prettyPrint())")
            }
            return nil
        }
        return responseObject
    }
}
