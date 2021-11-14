//
//  FirebaseLoginController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 11.11.2021.
//

import UIKit
import Firebase

class FirebaseLoginController: UIViewController {
    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let authService = Auth.auth()
    
    private var token: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = authService.addStateDidChangeListener { auth, user in
            
            //если есть юзер значит авторизованы
            guard user != nil else { return }
            self.showHomeVC()
        }
    }
    
    @IBAction func signInAction(_ sender: Any?) {
        
        guard let email = emailTextField.text, emailTextField.hasText,
              let password = passwordTextField.text, passwordTextField.hasText
        else {
            showAlert(title: "Ошибка клиентская", text: "Логин или Пароль не введены")
            return
        }
        
        authService.signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                self.showAlert(title: "Ошибка Firebase", text: error.localizedDescription)
                return
            }
            self.showHomeVC()
        }
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        guard let email = emailTextField.text, emailTextField.hasText,
              let password = passwordTextField.text, passwordTextField.hasText
        else {
            showAlert(title: "Ошибка клиентская", text: "Логин или Пароль не введены")
            return
        }
        
        authService.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                self.showAlert(title: "Ошибка Firebase", text: error.localizedDescription)
                return
            }
            
            self.signInAction(nil)
        }
        
    }
    
    //MARK: - Private
    
    private func showHomeVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "loginVC") else { return }
        guard let window = self.view.window else { return }
        window.rootViewController = vc
    }
    
    private func showAlert(title: String?, text: String?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
}
