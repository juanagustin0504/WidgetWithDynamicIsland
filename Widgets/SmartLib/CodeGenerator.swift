//
//  CodeGenerator.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import UIKit

enum CodeType {
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
            UserDefaults.standard.set(dataFromImage!, forKey: "qr_image_data")
            return dataFromImage
        } else {
            let dataFromImage = UIImage(ciImage: outputImg).jpegData(compressionQuality: 1.0)
            return dataFromImage
//            return UIImage(ciImage: outputImg)
        }
    }
}
