//  DynamicIslandWidgetLiveActivity.swift
//  DynamicIslandWidget
//
//  Created by Webcash on 2022/12/13.
//

import ActivityKit
import WidgetKit
import SwiftUI
import BackgroundTasks

struct DynamicIslandWidgetAttributes: ActivityAttributes {
    
    typealias State = ContentState
    
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var nowState: String
        var stateImg: String
        var time: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandWidgetLiveActivity: Widget {
    
    let date = Date()
    @State var timeRemaining : Int = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack(alignment: .center) {
//                let userDefaults = UserDefaults.shared
//                let isQR = userDefaults.bool(forKey: "IS_QR")
//                if isQR {
//                    Image(uiImage: UIImage(data: userDefaults.data  (forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 100))
//                        .padding(10)
//                } else {
//                    Image(uiImage: UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 200))
//                        .padding(10)
//                }
                ZStack {
                    Text(convertSecondsToTime(timeInSeconds:context.state.time))
                        .font(.system(size: 50))
                        .onReceive(timer) { _ in
                            timeRemaining -= 1
                        }
                }
                .onAppear {
                    calcRemain()
                }
            }
            .foregroundColor(.white)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.center) {
                    let userDefaults = UserDefaults.shared
                    let isQR = userDefaults.bool(forKey: "IS_QR")
                    
                    if isQR {
                        Image(uiImage: UIImage(data: userDefaults.data  (forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 100))
                    } else {
                        Image(uiImage: UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 350))
                    }
                }
                DynamicIslandExpandedRegion(.leading) {
                    // Leading
                }
                DynamicIslandExpandedRegion(.trailing) {
                    // Trailing
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // Bottom
                }
            } compactLeading: {
                if context.state.stateImg == "" {
                    Image(uiImage: UIImage(named: "img_zeropay")!.resize(newWidth: 25))
                } else {
                    Image(systemName: "star")
                }
                
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
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds - hours*3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i", hours,minutes,seconds)
    }
    
    func calcRemain() {
        let calendar = Calendar.current
        let targetTime : Date = calendar.date(byAdding: .second, value: 5, to: date, wrappingComponents: false) ?? Date()
        let remainSeconds = Int(targetTime.timeIntervalSince(date))
        self.timeRemaining = remainSeconds
    }
}
