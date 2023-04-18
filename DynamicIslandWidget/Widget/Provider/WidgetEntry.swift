//
//  WidgetEntry.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import WidgetKit
import UIKit

struct WidgetEntry: TimelineEntry {
    var date: Date = Date() // Date 시간에 따라 데이터를 표현하기 위해 필요(필수)
    let imgList: UIImage // 표현될 데이터(이미지)
}

