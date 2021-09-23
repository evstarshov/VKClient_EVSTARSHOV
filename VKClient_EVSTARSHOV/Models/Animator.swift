//
//  Animator.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.09.2021.
//

import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationTime = 1.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
        let source = transitionContext.viewController(forKey: .from),
        let destination = transitionContext.viewController(forKey: .to)
        else {return}
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(
            translationX: source.view.bounds.width, y: source.view.bounds.height)
        
        UIView.animate(withDuration: animationTime) {
            destination.view.transform = .identity
            
        } completion: { isCompleted in
            transitionContext.completeTransition(isCompleted)
        }
    }
}
