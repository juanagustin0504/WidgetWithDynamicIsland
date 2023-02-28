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

        let entry = Entry(pr: [], imgList: [img1])
        
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let img1 = UIImage(named: "img_zeropay")!
        
        let entry = Entry(pr: [], imgList: [img1])
        
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
        let userDefaults = UserDefaults.shared
        let image = UIImage(named: "img_zeropay")!
        
        if userDefaults.bool(forKey: "IS_QR") {
            guard let qrImageData = userDefaults.data(forKey: "QR_IMAGE_DATA") else { return image }
            let qrImage = UIImage(data: qrImageData)!
            return qrImage.resize(newWidth: 100)
        } else {
            guard let barImageData = userDefaults.data(forKey: "BARCODE_IMAGE_DATA") else { return image }
            let barImage = UIImage(data: barImageData)!
            return barImage.resize(newWidth: 200)
        }
    }
}
