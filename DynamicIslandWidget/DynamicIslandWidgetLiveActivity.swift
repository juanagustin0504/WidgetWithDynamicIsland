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
            let userDefaults = UserDefaults.shared
            let isQR = userDefaults.bool(forKey: "IS_QR")
            
            if isQR {
                Image(uiImage: UIImage(data: userDefaults.data(forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 200))
            } else {
                Image(uiImage: UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 200))
            }
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.center) {
                    let userDefaults = UserDefaults.shared
                    let isQR = userDefaults.bool(forKey: "IS_QR")
                    
                    if isQR {
                        Image(uiImage: UIImage(data: userDefaults.data(forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 50))
                    } else {
                        Image(uiImage: UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 50))
                    }
                    
                }
            } compactLeading: {
                Image(systemName: "star.fill")
            }
            compactTrailing: {
                Image(systemName: "star")
            } minimal: {
                VStack {
                    Text("☆")
                }
            }
            .widgetURL(URL(string: "dynamic_island://"))
            .keylineTint(Color.cyan)
        }
    }
}
