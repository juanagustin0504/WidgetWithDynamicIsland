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
    
    /// 위젯 추가 시 보이는 placeholder
    func placeholder(in context: Context) -> WidgetEntry {
        let img1 = UIImage(named: "img_zeropay")!.resize(newWidth: 50)

        let entry = Entry(imgList: [img1])
        
        return entry
    }
    
    /// 위젯 추가 화면에서 보이는 스냅샷
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let img1 = UIImage(named: "img_zeropay")!.resize(newWidth: 50)
        
        let entry = Entry(imgList: [img1])
        
        completion(entry)
    }
    
    /// 첫 실행 및 새로고침 시 작동하는 timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let currentDate = Date()
        // 30초마다 refresh
        let refreshDate = Calendar.current.date(byAdding: .second, value: 30, to: currentDate)!
        
        let image = getCodeImage()
        
        let entry = Entry(date: currentDate, imgList: [image])
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
