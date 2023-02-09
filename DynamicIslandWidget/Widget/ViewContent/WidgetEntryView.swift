//
//  WidgetEntryView.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import UIKit
import SwiftUI
import WidgetKit

struct WidgetEntryView: View {
    let entry: WidgetEntry
    
    @Environment(\.widgetFamily) var family
    
    var maxCount: Int {
        switch family {
        case .systemMedium:
            return 2
        default:
            return 5
        }
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
//            let image = CodeGenerator.generateCodeFromString(str: "3-BP-30000044780007--87a6", withType: .QR)!
//            WidgetView(img: image)
//            Divider()
//            Image(systemName: "star.fill")
            let data = UserDefaults.standard.data(forKey: "qr_image_data")!
            let uiimageFromData = UIImage(data: data)!
            Image(uiImage: uiimageFromData)
                .resizable()
                .frame(width: 100, height: 100)
//            Image(uiImage: UIImage(named: "img_zeropay")!)
//            let image = entry.imgList[0]
//            WidgetView(img: image)
//            Link(destination: URL(string: "https://www.bizplay.co.kr")!) {
//                let image1 = CodeGenerator.generateCodeFromString(str: "800088668030000044780002", withType: .BARCODE)
//                let image2 = CodeGenerator.generateCodeFromString(str: "3-BP-30000044780007--87a6", withType: .QR)
//                WidgetView(img: image1!)
//                    .backgroundStyle(.yellow)
//
//                Divider()
//            }
        }
        
//        VStack(alignment: .leading) {
//            ForEach(0..<min(maxCount, entry.imgList.count), id: \.self) { index in
////                WidgetView(pr: PullRequest.Response(title: "title", date: Date().description, url: ""))
////                let pr = entry.imgList[index]
////                let url = URL(string: "widget://pr?url=\("https://www.bizplay.co.kr")")!
////                Link(destination: url) {
////                    WidgetView(pr: PullRequest.Response(title: "타이틀", date: Date().description, url: ""))
////                    Divider()
////                }
//            }
//        }
//        .padding(.all, 16)
    }
}

struct WidgetView: View {
//    let pr: PullRequest.Response
    let img: UIImage
    
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(uiImage: img)
        }
//        VStack(alignment: .leading) {
//            Text(pr.title)
//                .font(.system(size: 18, weight: .semibold))
//                .foregroundColor(.black)
//
//            Spacer()
//                .frame(height: 4)
//
//            HStack {
//                Image(systemName: "star")
//
//                Divider()
//
//                Text(pr.date)
//                    .font(.system(size: 14, weight: .regular))
//                    .foregroundColor(.gray)
//            }.frame(height: 20)
//        }
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
//        DynamicIslandWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), texts: ["Hello"]))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        WidgetEntryView(entry: WidgetEntry(date: Date(), pr: [], imgList: []))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
