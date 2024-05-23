//
//  gradient.swift
//  APPlICATION
//
//  Created by Ashish on 14/03/24.
//

import UIKit

class gradient : UIView {
//    var topColor : UIColor = .blue
//    var bottomColor : UIColor = .black
//
//    var startPointX : CGFloat = 1
//    var startPointY : CGFloat = 0
//    var endPointX : CGFloat = 1
//    var endPointy : CGFloat = 1
//
//    override func layoutSubviews() {
//        let gradientlayer = CAGradientLayer()
//        gradientlayer.colors = [topColor.cgColor, bottomColor.cgColor]
//        gradientlayer.startPoint = CGPoint(x: startPointX, y: startPointY)
//        gradientlayer.endPoint = CGPoint(x: endPointX, y: endPointy)
//        gradientlayer.frame = self.bounds
//
//        self.layer.insertSublayer(gradientlayer, at: 0)
//
//    }
    
    var topColor: UIColor = UIColor(hex: "#283A5E")
        var bottomColor: UIColor = .white

        var startPointX: CGFloat = 1
        var startPointY: CGFloat = 0
        var endPointX: CGFloat = 1
        var endPointY: CGFloat = 1

        private var gradientLayer: CAGradientLayer?

        override func layoutSubviews() {
            super.layoutSubviews()

            // Remove any existing gradient layer
            gradientLayer?.removeFromSuperlayer()

            // Create and add new gradient layer
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
            gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
            gradientLayer.frame = self.bounds

            self.layer.insertSublayer(gradientLayer, at: 0)

            // Store reference to gradient layer
            self.gradientLayer = gradientLayer
        }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
