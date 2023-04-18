//
//  WidgetsApp.swift
//  Widgets
//
//  Created by Webcash on 2022/12/13.
//

import SwiftUI
import BackgroundTasks

@main
struct WidgetsApp: App {
    @State var stack: [String] = []
    @Environment(\.scenePhase) private var phase
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $stack) {
                ContentView()
                    .onOpenURL { url in
                        // Link된 url 받아서 스택에 추가(String)
                        print("url : \(url.description)")
                        stack.append(url.description)
                    }
                    .navigationDestination(for: String.self) { str in
                        // 스택에 url이 추가되면 Naviagtion 작동
                        // Widget을 통해 들어오면 QR, BARCODE
                        // 그 외 Dynamic Island
                        if str.contains("QR") || str.contains("BARCODE") {
                            ContentViewFromWidget()
                        } else {
                            ContentViewFromDynamicIsland()
                        }
                    }
            }
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .background: scheduleAppRefresh()
            default: break
            }
        }
        .backgroundTask(.appRefresh("myapprefresh")) { sender in
            print("sender ::::::: \(sender)\n")
            SmartLiveManager.shared.update(state: DynamicIslandWidgetAttributes.ContentState(nowState: "Update", stateImg: "star", time: 1))
        }
    }
    
    func scheduleAppRefresh() {
        
        let request = BGAppRefreshTaskRequest(identifier: "myapprefresh")
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
