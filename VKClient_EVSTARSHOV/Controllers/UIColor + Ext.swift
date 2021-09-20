//
//  UIColor + Ext.swift
//  Weather1640
//
//  Created by Юрий Султанов on 26.08.2021.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        UIColor(
            red: .random(in: 0...255)/255,
            green: .random(in: 0...255)/255,
            blue: .random(in: 0...255)/255,
            alpha: 1.0)
    }
}
