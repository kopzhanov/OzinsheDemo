//
//  SignUpViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 05.10.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class SignUpViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: TextFieldWithPadding!
    @IBOutlet weak var passwordTextField: TextFieldWithPadding!
    @IBOutlet weak var passwordRepeatTextField: TextFieldWithPadding!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews(){
        emailTextField.layer.cornerRadius = 12.0
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordTextField.layer.cornerRadius = 12.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordRepeatTextField.layer.cornerRadius = 12.0
        passwordRepeatTextField.layer.borderWidth = 1.0
        passwordRepeatTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        signUpButton.layer.cornerRadius = 12.0
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    
    @IBAction func textFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @IBAction func showPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        passwordRepeatTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func signUp(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        SVProgressHUD.show()
        
        if passwordTextField.text != passwordRepeatTextField.text{
            passwordTextField.text = ""
            passwordRepeatTextField.text = ""
            SVProgressHUD.showError(withStatus: "Passwords don't match")
        } else {
            let parameters = ["email":email, "password":password]
            
            AF.request(Urls.SIGNUP_URL,method: .post, parameters: parameters,encoding: JSONEncoding.default).responseData { response in
                
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
    }
    
    func startApp() {
        let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
        tabViewController?.modalPresentationStyle = .fullScreen
        self.present(tabViewController!,animated: true,completion: nil)
    }
}
