//
//  CodeGenerator.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import UIKit

public enum CodeType {
    case BARCODE
    case QR
}

class CodeGenerator {
    class func generateCodeFromString(str: String, withType type: CodeType) -> Data? {
        let data = str.data(using: .ascii)
        var filterStr = ""
        
        switch type {
        case .BARCODE:
            filterStr = "CICode128BarcodeGenerator"
        default:
            filterStr = "CIQRCodeGenerator"
        }
        
        guard let filter = CIFilter(name: filterStr) else {
            print("CIFilter error")
            return nil
        }
        
        filter.setValue(data, forKey: "inputMessage")
        
        guard let outputCIImage = filter.outputImage else {
            print("Cannot get image")
            return nil
        }
        
        let scaleValue: CGFloat = 15
        let transfrom = CGAffineTransform.init(scaleX: scaleValue, y: scaleValue)
        let outputImg = outputCIImage.transformed(by: transfrom)
        
        //return UIImage(ciImage: outputImg)
        
        
        if #available(iOS 13.0, *) {
            let colorParameters = [
                "inputColor0": CIColor(color: UIColor.black), // Foreground
                "inputColor1": CIColor(color: UIColor.clear) // Background
            ]
            let colored = outputImg.applyingFilter("CIFalseColor", parameters: colorParameters)
            let image = UIImage(ciImage: colored)
            let dataFromImage = image.jpegData(compressionQuality: 0.001)
            return dataFromImage
        } else {
            let dataFromImage = UIImage(ciImage: outputImg).jpegData(compressionQuality: 1.0)
            return dataFromImage
//            return UIImage(ciImage: outputImg)
        }
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
