//
//  SmartLiveManager.swift
//  Widgets
//
//  Created by Webcash on 2023/03/02.
//

import SwiftUI
import ActivityKit

final class SmartLiveManager: ObservableObject {
    
    static let shared = SmartLiveManager()
    
    @Published var activity: Activity<DynamicIslandWidgetAttributes>?
    
    private init() {}
    
    func start() {
        guard activity == nil else { return }
        let attributes = DynamicIslandWidgetAttributes(name: "SmartDynamicIsland")
        let contentState = DynamicIslandWidgetAttributes.State(nowState: "1", stateImg: "img_zeropay")
        
        do {
            let activity = try Activity<DynamicIslandWidgetAttributes>.request(
                attributes: attributes,
                contentState: contentState
            )
            print(activity)
        } catch {
            print(error.localizedDescription + " [DynamicIsland Error]")
        }
    }
    
    func update(state: DynamicIslandWidgetAttributes.ContentState) {
        Task {
            let updateContentState = DynamicIslandWidgetAttributes.State(nowState: "Update", stateImg: "image_1_1")
            for activity in Activity<DynamicIslandWidgetAttributes>.activities {
                await activity.update(using: updateContentState)
            }
        }
    }
    
    func stop() {
        Task {
            for activity in Activity<DynamicIslandWidgetAttributes>.activities {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
    
}
