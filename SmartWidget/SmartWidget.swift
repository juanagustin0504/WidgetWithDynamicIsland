//
//  SmartWidget.swift
//  SmartWidget
//
//  Created by Webcash on 2023/02/20.
//

import WidgetKit
import UIKit

class SmartWidget {
    public static var shared = SmartWidget()
    
    /// 모든 위젯 새로고침
    internal func reloadAllWidgets() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    /// 특정 위젯 새로고침
    internal func reloadWidget(ofKind: String) {
        WidgetCenter.shared.reloadTimelines(ofKind: ofKind)
    }
}
