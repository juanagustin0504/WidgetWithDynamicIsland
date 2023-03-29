//
//  Extension.swift
//  Widgets
//
//  Created by Webcash on 2023/03/15.
//

import UIKit

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
        print("화면 배율: \(UIScreen.main.scale)")// 배수
        print("origin: \(self), resize: \(renderImage)")
        print(renderImage)
        return renderImage
    }
}

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.com.webcash.Widgets"
        return UserDefaults(suiteName: appGroupId)!
        
        /**
         - 기존에 사용하던 UserDefaults.standard의 값을 불러와 share UserDefaults에 추가
         UserDefaults.standard.dictionaryRepresentation().forEach { (key, value) in
             UserDefaults.shared.set(value, forKey: key)
         }
         */
    }
}
