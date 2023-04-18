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
    
    /// 데이터를 불러오기 전에 보여줄 placeholder
    func placeholder(in context: Context) -> WidgetEntry {
        let img1 = UIImage(named: "qr")!.resize(newWidth: 50)

        let entry = Entry(imgList: img1)
        
        return entry
    }
    
    /// 위젯 갤러리에서 위젯을 고를 때 보여줄 snapshot
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let img1 = UIImage(named: "barcode")!.resize(newWidth: 50)
        
        let entry = Entry(imgList: img1)
        
        completion(entry)
    }
    
    /// 홈화면에 있는 위젯을 언제 업데이트 시킬 것인지 구현하는 timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let currentDate = Date()
        // 30초마다 refresh
        let refreshDate = Calendar.current.date(byAdding: .second, value: 30, to: currentDate)!
        
        let image = getCodeImage()
        
        let entry = Entry(date: currentDate, imgList: image)
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
    
    func getCodeImage() -> UIImage {
        let userDefaults = UserDefaults.shared
        let image = UIImage(named: "img_zeropay")!
        
        if userDefaults.bool(forKey: "IS_QR") {
            guard let qrImageData = userDefaults.data(forKey: "QR_IMAGE_DATA") else { return image.resize(newWidth: 50) }
            let qrImage = UIImage(data: qrImageData)!
            return qrImage.resize(newWidth: 100)
        } else {
            guard let barImageData = userDefaults.data(forKey: "BARCODE_IMAGE_DATA") else { return image.resize(newWidth: 50) }
            let barImage = UIImage(data: barImageData)!
            return barImage.resize(newWidth: 200)
        }
    }
}
