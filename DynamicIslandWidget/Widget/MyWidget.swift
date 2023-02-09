//
//  MyWidget.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import SwiftUI
import WidgetKit

struct MyWidget: Widget {
    static let kind: String = "MyWidget"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: MyWidget.kind, provider: WidgetProvider()) { timelineEntry in
            WidgetEntryView(entry: timelineEntry)
        }
        .configurationDisplayName("위젯 테스트")
        .description("위젯 테스트입니다.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
