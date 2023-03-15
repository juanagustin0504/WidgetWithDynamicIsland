//
//  SmartWidgetManager.swift
//  SmartWidgetManager
//
//  Created by Webcash on 2023/02/20.
//

import WidgetKit

open class SmartWidgetManager {
    public static var shared = SmartWidgetManager()
    
    /// 모든 위젯 새로고침
    internal func reloadAllWidgets() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    /// 특정 위젯 새로고침
    internal func reloadWidget(ofKind: String) {
        WidgetCenter.shared.reloadTimelines(ofKind: ofKind)
    }
}
