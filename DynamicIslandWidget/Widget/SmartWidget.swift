//
//  SmartWidget.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import SwiftUI
import WidgetKit

struct SmartWidget: Widget {
    static let kind: String = "SmartWidgetSample" // Widget ID
    
    /**
     body 안에 사용하는 Configuration
     - IntentConfiguration: 사용자가 위젯에서 Edit을 통해 위젯에 보여지는 내용을 변경 가능
     - StaticConfiguration: 사용자가 변경 불가능한 정적 데이터 표출
     */
    public var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: SmartWidget.kind, // Widget ID
            provider: WidgetProvider() // Widget 생성자
        ) { timelineEntry in
            WidgetEntryView(entry: timelineEntry) // Widget 표출될 View
        }
        .configurationDisplayName("Smart Widget") // Widget 제목
        .description("Smart Widget Sample.") // Widget 설명
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge]) // 지원하는 Widget 사이즈
    }
}
