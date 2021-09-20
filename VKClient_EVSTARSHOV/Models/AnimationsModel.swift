//
//  AnimationsModel.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 11.09.2021.
//

import UIKit


//@IBDesignable
final class Animations: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var leftConstraint: NSLayoutConstraint!
    @IBOutlet var constraints: [NSLayoutConstraint]!
    
    @IBAction func didPressAnimate(_ sender: Any) {
        animate4()
    }
    
    private let duration = 2.0
    private let delay = 0.5
    
    private func animate0() {
        view.layoutIfNeeded()
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: [
                .repeat,
                .autoreverse,
                .curveEaseInOut,
            ]) {
            self.leftConstraint.isActive = false
            self.imageView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.leftConstraint.isActive = true
            self.imageView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func animate1() {
        UIView.transition(
            with: imageView,
            duration: duration,
            options: [
                .repeat,
                .autoreverse,
                .transitionCrossDissolve,
                .curveEaseInOut,
            ]) {
            self.imageView.alpha = 0.5
            self.imageView.image = UIImage(named: "Moscow")
        } completion: { _ in
            self.imageView.alpha = 1
            self.imageView.image = UIImage(named: "New York")
        }
    }
    
    private func animate2() {
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 0.5,
            options: [
                .repeat,
                .autoreverse,
                .curveLinear
            ]) {
            self.imageView.center.x += 100
        } completion: { _ in
            self.imageView.center.x -= 100
        }
    }
    
    private func animate3() {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.repeatCount = 1
        animation.repeatDuration = 0.5
        animation.autoreverses = true
        animation.fromValue = imageView.layer.position.y
        animation.toValue = imageView.layer.position.y + 100
        animation.duration = duration
        animation.fillMode = .both
        imageView.layer.add(
            animation,
            forKey: nil)
    }
    
    private func animate4() {
        CATransaction.setCompletionBlock {
            self.imageView.frame.origin.y += 100
        }
        
        CATransaction.begin()
        let animation = CASpringAnimation(keyPath: "position.y")
        animation.fromValue = imageView.layer.position.y
        animation.toValue = imageView.layer.position.y + 100
        animation.duration = duration
        animation.damping = 0.1
        animation.initialVelocity = 0.5
        animation.mass = 3
        animation.stiffness = 200
        animation.beginTime = CACurrentMediaTime() + 0.5
//        animation.autoreverses = true
        imageView.layer.add(
            animation,
            forKey: nil)
        CATransaction.commit()
    }
    
}

protocol RPLoadingAnimationDelegate: AnyObject {
   func setup(_ layer: CALayer, size: CGSize, colors: [UIColor])
}

class RotatingCircle: RPLoadingAnimationDelegate {
    
    func setup(_ layer: CALayer, size: CGSize, colors: [UIColor]) {
        
        let dotNum: CGFloat = 4
        let diameter: CGFloat = size.width / 10
        
        let circle = CALayer()
        let frame = CGRect(
            x: (layer.bounds.width - diameter) / 2,
            y: (layer.bounds.height - diameter) / 2,
            width: diameter,
            height: diameter
        )
        
        circle.backgroundColor = colors[0].cgColor
        circle.cornerRadius = diameter / 2
        circle.frame = frame
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = layer.bounds
        layer.addSublayer(replicatorLayer)
        
        replicatorLayer.addSublayer(circle)
        replicatorLayer.instanceCount = Int(dotNum)
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = frame.origin.y + 50
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        circle.add(animation, forKey: "animation")
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 0.8
        scaleAnimation.duration = 0.5
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        circle.add(scaleAnimation, forKey: "scaleAnimation")
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = -2.0 * Double.pi
        rotationAnimation.duration = 6.0
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        replicatorLayer.add(rotationAnimation, forKey: "rotationAnimation")
        
        
        if colors.count > 1 {
        
            var cgColors : [CGColor] = []
            for color in colors {
                cgColors.append(color.cgColor)
            }
            
            let colorAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorAnimation.values = cgColors
            colorAnimation.duration = 2
            colorAnimation.repeatCount = .infinity
            colorAnimation.autoreverses = true
            circle.add(colorAnimation, forKey: "colorAnimation")
        }
        
        
        
        replicatorLayer.instanceDelay = 0.1
        
        let angle = (2.0 * Double.pi) / Double(replicatorLayer.instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
    }
}
