//
//  ViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 21.07.2023.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class SignInViewController: UIViewController {

   
    @IBOutlet weak var emailTextField: TextFieldWithPadding!
    @IBOutlet weak var passwordTextField: TextFieldWithPadding!
    @IBOutlet weak var signinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViews()
        
        hideKeyboardWhenTappedAround()
    }
    
    func configureViews(){
        emailTextField.layer.cornerRadius = 12.0
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordTextField.layer.cornerRadius = 12.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        signinButton.layer.cornerRadius = 12.0
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @IBAction func showPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func signin(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.isEmpty || password.isEmpty{
            return
        }
        
        SVProgressHUD.show()
        
        let parameters = ["email":email, "password":password]
        
        AF.request(Urls.SIGNIN_URL,method: .post, parameters: parameters,encoding: JSONEncoding.default).responseData { response in
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    self.startApp()
                } else{
                    SVProgressHUD.show(withStatus: "Connection Error")
                }
            } else {
                var ErrorString = "Connection Error"
                if let sCode = response.response?.statusCode{
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    func startApp() {
        let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
        tabViewController?.modalPresentationStyle = .fullScreen
        self.present(tabViewController!,animated: true,completion: nil)
    }
    
    @IBAction func signUptransition(_ sender: Any) {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.show(signUpVC, sender: self)
    }
    
}

