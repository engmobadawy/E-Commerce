//
//  LoginVC.swift
//  E-Commerce
//
//  Created by MohamedBadawi on 18/09/2025.
//


import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var userNameTF: CustomTextField!
    @IBOutlet weak var passwordTF: CustomTextField!
    @IBOutlet weak var forgetPassword: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var notHaveAccountTitle: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupColors()
        setupTexts()
        setupTextFields()
        setupButtons()
    }
    
    // MARK: - Setup Methods
    private func setupColors() {
        mainTitle.textColor = .orange
        subTitle.textColor = .darkGray
        forgetPassword.setTitleColor(.darkGray, for: .normal)
        signInBtn.setTitleColor(.white, for: .normal)
        notHaveAccountTitle.textColor = .gray
        signupBtn.setTitleColor(.systemBlue, for: .normal)
        
        signInBtn.backgroundColor = .orange
    }
    
    private func setupTexts() {
        mainTitle.text = "Sign In"
        subTitle.text = "Welcome back! Please login to your account."
        forgetPassword.setTitle("Forget Password?", for: .normal)
        signInBtn.setTitle("Sign In", for: .normal)
        notHaveAccountTitle.text = "Don't have an account?"
        signupBtn.setTitle("Sign Up", for: .normal)
    }
    
    private func setupTextFields() {
        userNameTF.placeholder = "Enter User Name"
        userNameTF.text = "512345627"
        userNameTF.delegate = self
    
        userNameTF.returnKeyType = .next
        
        if let customPasswordTF = passwordTF {
            customPasswordTF.placeholder = "Enter Password"
            customPasswordTF.text = "12345678"
            customPasswordTF.isSecureTextEntry = true
            customPasswordTF.showEyeButton = true  // Assuming your CustomTextField supports this
            
            customPasswordTF.delegate = self
            customPasswordTF.returnKeyType = .go
        }
    }
    
    private func setupButtons() {
        signInBtn.layer.cornerRadius = 15
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let username = userNameTF.text, !username.isEmpty,
              let password = passwordTF.text, !password.isEmpty else {
            showAlert(title: "Missing Info", message: "Please enter user name and password")
            return
        }
        
        // Step 1: Login first
        NetworkManager.shared.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loginResponse):
                    print("✅ Login successful!")
                    print("🔐 Token: \(loginResponse.token)")
                    
                 
                    
                case .failure(let error):
                    print("❌ Login failed: \(error.localizedDescription)")
                    self?.showAlert(title: "Login Failed", message: error.localizedDescription)
                }
            }
        }
    }

    

    // Add this navigation method
    private func navigateToTabBar() {
        let tabBarVC = TabBarVC()
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let windowSceneDelegate = scene.delegate as? SceneDelegate,
           let window = windowSceneDelegate.window {
            window.rootViewController = tabBarVC
            UIView.transition(with: window, duration: 0.4, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }

    

    
    @IBAction func signupTapped(_ sender: UIButton) {
        print("Sign Up tapped")
    }
    
    @IBAction func forgetPasswordTapped(_ sender: UIButton) {
        print("Forget Password tapped")
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            passwordTF.becomeFirstResponder()
        } else if textField == passwordTF {
            textField.resignFirstResponder()
            signInBtn.sendActions(for: .touchUpInside)
        }
        return true
    }
    
    // MARK: - Helper
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
