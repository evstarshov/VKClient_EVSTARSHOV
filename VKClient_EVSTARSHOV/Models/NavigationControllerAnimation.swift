//
//  NavigationControllerAnimation.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.09.2021.
//

import UIKit

final class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationTime = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
        let source = transitionContext.viewController(forKey: .from),
        let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width, y: 0)
        
        UIView.animateKeyframes(withDuration: animationTime, delay: 0.0, options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                let translation = CGAffineTransform(translationX: -250.0, y: 0.0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4) {
                let translation = CGAffineTransform(translationX: source.view.bounds.width / 2, y: 0.0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                destination.view.transform = translation.concatenating(scale)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                destination.view.transform = .identity
            }
        } completion: { isComplited in
            if isComplited && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(isComplited && !transitionContext.transitionWasCancelled)
        }
    }
}

final class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
//        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.insertSubview(
            destination.view,
            belowSubview: source.view)
        
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(
            translationX: -250,
            y: 0)
            .concatenating(CGAffineTransform(
                            scaleX: 0.8,
                            y: 0.8))
        
        UIView.animateKeyframes(
            withDuration: animateTime,
            delay: 0.0,
            options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                let translation = CGAffineTransform(
                    translationX: source.view.bounds.width / 2,
                    y: 0.0)
                let scale = CGAffineTransform(
                    scaleX: 1.2,
                    y: 1.2)
                source.view.transform = translation.concatenating(scale)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: 0.4,
                relativeDuration: 0.4) {
                source.view.transform = CGAffineTransform(
                    translationX: source.view.bounds.width,
                    y: 0.0)
            }
                
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
                destination.view.transform = .identity
            }
        } completion: { isCompleted in
            if isCompleted && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            
            transitionContext.completeTransition(isCompleted && !transitionContext.transitionWasCancelled)
        }
    }
}
