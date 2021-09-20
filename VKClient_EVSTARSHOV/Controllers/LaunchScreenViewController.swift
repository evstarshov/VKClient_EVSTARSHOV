//
//  LaunchScreenViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 11.09.2021.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet var round1: UIImageView!
    @IBOutlet var round2: UIImageView!
    @IBOutlet var round3: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        animateRound1Appearing()
        animateRound2Appearing()
        animateRound3Appearing()
    }

    func animateRound1Appearing() {

        let myDelay = 0.3
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + myDelay
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        //fadeInAnimation.repeatCount = 5
        fadeInAnimation.isRemovedOnCompletion = true
        fadeInAnimation.autoreverses = true
        
        self.round1.layer.add(fadeInAnimation, forKey: nil)
        self.round1.layer.add(fadeInAnimation, forKey: nil)
    }
    
    func animateRound2Appearing() {
        let myDelay = 0.5
        let fadeInAnimation2 = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation2.fromValue = 0
        fadeInAnimation2.toValue = 1
        fadeInAnimation2.duration = 1
        fadeInAnimation2.beginTime = CACurrentMediaTime() + myDelay
        fadeInAnimation2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation2.fillMode = CAMediaTimingFillMode.backwards
        fadeInAnimation2.autoreverses = true
        
        self.round2.layer.add(fadeInAnimation2, forKey: nil)
        self.round2.layer.add(fadeInAnimation2, forKey: nil)
    }
    
    func animateRound3Appearing() {
        [CATransaction .begin()];

        [CATransaction .setCompletionBlock({ [self] in
            performSeguetoLogin()
        })]
        let myDelay = 0.7
        let fadeInAnimation3 = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation3.fromValue = 0
        fadeInAnimation3.toValue = 1
        fadeInAnimation3.duration = 1
        fadeInAnimation3.beginTime = CACurrentMediaTime() + myDelay
        fadeInAnimation3.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation3.fillMode = CAMediaTimingFillMode.backwards
        fadeInAnimation3.autoreverses = true
        
        self.round3.layer.add(fadeInAnimation3, forKey: nil)
        self.round3.layer.add(fadeInAnimation3, forKey: nil)
        [CATransaction .commit()]
    }
    
    func performSeguetoLogin() {
        performSegue(withIdentifier: "toLoginScreenSegue", sender: nil)
   }

}
