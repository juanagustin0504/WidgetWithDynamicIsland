//
//  WidgetProvider.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import WidgetKit
import UIKit

struct WidgetProvider: TimelineProvider {
    typealias Entry = WidgetEntry
    
    func placeholder(in context: Context) -> WidgetEntry {
        let img1 = UIImage(named: "img_zeropay")!
        let img2 = UIImage(named: "img_transfer")!
        
        let entry = Entry(pr: [], imgList: [img1, img2])
        
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let img1 = UIImage(named: "img_zeropay")!
        let img2 = UIImage(named: "img_transfer")!
        
        let entry = Entry(pr: [], imgList: [img1, img2])
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let currentDate = Date()
        // 30초마다 refresh
        let refreshDate = Calendar.current.date(byAdding: .second, value: 30, to: currentDate)!
        
        let image = getCodeImage()
        
        let entry = Entry(date: currentDate, pr: [], imgList: [image])
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
    
    func getCodeImage() -> UIImage {
        // testing
//        let condition = Int.random(in: 0...1) == 0
//        var image: UIImage?
//        if condition {
//            let data = CodeGenerator.generateCodeFromString(str: "800088668030000044780002", withType: .BARCODE)!
//            image = UIImage(data: data)
//        } else {
//            let data = CodeGenerator.generateCodeFromString(str: "3-BP-30000044780007--87a6", withType: .QR)!
//            image = UIImage(data: data)
//        }
//
//        guard let image = image else {
//            return UIImage(systemName: "heart.fill")!
//        }
        
        let userDefaults = UserDefaults.shared
        let image = UIImage(systemName: "heart")
        let test = userDefaults.string(forKey: "TEST")
        
        if userDefaults.bool(forKey: "IS_QR") || test == "TEST" {
            guard let qrImageData = userDefaults.data(forKey: "QR_IMAGE_DATA") else { return image! }
            let qrImage = UIImage(data: qrImageData)!
            return qrImage
        } else {
            guard let barImageData = userDefaults.data(forKey: "BARCODE_IMAGE_DATA") else { return UIImage(systemName: "heart.fill")! }
            let barImage = UIImage(data: barImageData)!
            return barImage
        }
    }
}
