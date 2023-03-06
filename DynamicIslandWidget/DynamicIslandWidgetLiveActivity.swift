//  DynamicIslandWidgetLiveActivity.swift
//  DynamicIslandWidget
//
//  Created by Webcash on 2022/12/13.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandWidgetAttributes: ActivityAttributes {
    
    typealias State = ContentState
    
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var nowState: String
        var stateImg: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandWidgetLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                let userDefaults = UserDefaults.shared
                let isQR = userDefaults.bool(forKey: "IS_QR")
                if isQR {
                    Image(uiImage: UIImage(data: userDefaults.data  (forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 100))
                        .padding(10)
                } else {
                    Image(uiImage: UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 350))
                        .padding(10)
                }
            }
            .foregroundColor(.white)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.center) {
                    let userDefaults = UserDefaults.shared
//                    Image(uiImage: UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 350))
//                    Image(uiImage: UIImage(data: userDefaults.data(forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 100))
                    let isQR = userDefaults.bool(forKey: "IS_QR")
                    
                    if isQR {
                        Image(uiImage: UIImage(data: userDefaults.data  (forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 100))
                    } else {
                        Image(uiImage: UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 350))
                    }
                }
                DynamicIslandExpandedRegion(.leading) {
                    Image(uiImage: UIImage(named: "img_zeropay")!.resize(newWidth: 100))
                }
                DynamicIslandExpandedRegion(.trailing) {
//                    Image(uiImage: UIImage(named: "img_zeroapy")!.resize(newWidth: 100))
                }
                DynamicIslandExpandedRegion(.bottom) {
//                    Image(uiImage: UIImage(data: UserDefaults.shared.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 350))
//                    Image(uiImage: UIImage(systemName: "star.fill")!)
                }
            } compactLeading: {
                Image(uiImage: UIImage(named: "img_zeropay")!.resize(newWidth: 25))
            }
            compactTrailing: {
                if UserDefaults.shared.bool(forKey: "IS_QR") {
                    Text("QR")
                } else {
                    Text("Barcode")
                }
            } minimal: {
                VStack {
                    Image(uiImage: UIImage(named: "img_zeropay")!.resize(newWidth: 25))
                }
            }
            .widgetURL(URL(string: "dynamic_island://"))
            .keylineTint(Color.cyan)
        }
    }
}
