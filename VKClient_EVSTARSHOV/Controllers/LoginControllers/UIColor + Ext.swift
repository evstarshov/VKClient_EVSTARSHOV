

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
