//
//  ViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 14.08.2021.
//

import UIKit

class LoginViewController: UIViewController {

    

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginTitleView: UILabel!
    @IBOutlet var passwordTitleView: UILabel!
    @IBOutlet var titleView: UIImageView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            animateTitlesAppearing()
            animateTitleAppearing()
            animateFieldsAppearing()
            animateAuthButton()
        }
    
    @IBAction func loginScreen(unwindSegue: UIStoryboardSegue) {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if isValid() {
            print("Login")
            performSegue(
                withIdentifier: "loginSegue",
                sender: nil)
        } else {
            showAlert()
        }
    }
    
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: "Error",
            message: "Incorrect username or password",
            preferredStyle: .alert)
        let alertItem = UIAlertAction(
            title: "Ok:(",
            style: .cancel)
        { _ in
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        }
        alertController.addAction(alertItem)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            return isValid()
        } else {
            return false
        }
    }

    
    func isValid() -> Bool {
        if loginTextField.text == ""
            && passwordTextField.text == "" {
            return true
        } else {
            return false
        }
    }
    // --- Блок анимации
    func animateTitlesAppearing() {
        let offset = view.bounds.width
        loginTitleView.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordTitleView.transform = CGAffineTransform(translationX: offset, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
                           self.loginTitleView.transform = .identity
                           self.passwordTitleView.transform = .identity
                       },
                       completion: nil)
    }
    
    func animateTitleAppearing() {
        self.titleView.transform = CGAffineTransform(translationX: 0,
                                                     y: -self.view.bounds.height/2)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                           self.titleView.transform = .identity
                       },
                       completion: nil)
    }
    
    func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginTextField.layer.add(fadeInAnimation, forKey: nil)
        self.passwordTextField.layer.add(fadeInAnimation, forKey: nil)
    }
    
    func animateAuthButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(animation, forKey: nil)
    }
    

//    private let duration = 2.0
//    private let delay = 0.5
//
//    private func animate0() {
//        UIView.animate(withDuration: duration,
//                       delay: delay,
//                       options: [.repeat, .autoreverse, .curveEaseInOut],
//                       completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//    }
}

