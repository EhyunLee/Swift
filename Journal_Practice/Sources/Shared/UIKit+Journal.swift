//
//  UIKit+Journal.swift
//  Journal_Practice
//
//  Created by 이의현 on 2018. 8. 26..
//  Copyright © 2018년 이의현. All rights reserved.
//

import UIKit

extension UIImage {
    // Gradient 함수 추가
    static func gradientImage(with colors: [UIColor], size:CGSize) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIColor {
    static var gradientStart: UIColor {
        return .init(red: 0.549, green: 0.874, blue: 0.960, alpha: 1.0)
    }
    static var gradientEnd: UIColor {
        return .init(red: 0.980, green: 0.980, blue: 0.745, alpha: 1.0)
    }
}
