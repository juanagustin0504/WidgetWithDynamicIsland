//
//  SmartLiveManager.swift
//  Widgets
//
//  Created by Webcash on 2023/03/02.
//

import SwiftUI
import ActivityKit

/**
 'DynamicIslandWidgetAttributes' -> '자신의 ActivityAttributes' 로 변경 후 사용
 */
open class SmartLiveManager: ObservableObject {
    
    static let shared = SmartLiveManager()
    
    @Published var activity: Activity<DynamicIslandWidgetAttributes>?
    
    private init() {}
    
    func start() {
        guard activity == nil else { return }
        let attributes = DynamicIslandWidgetAttributes(name: "SmartDynamicIsland")
        let contentState = DynamicIslandWidgetAttributes.State(nowState: "Start", stateImg: "", time: 6000)
        
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
            let updateContentState = DynamicIslandWidgetAttributes.State(nowState: "Update", stateImg: "star", time: state.time)
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
