//
//  ChangePasswordViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 14.08.2024.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var passwordTextField: TextFieldWithPadding!
    @IBOutlet weak var passwordRepeatTextField: TextFieldWithPadding!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews(){
        passwordTextField.layer.cornerRadius = 12.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordRepeatTextField.layer.cornerRadius = 12.0
        passwordRepeatTextField.layer.borderWidth = 1.0
        passwordRepeatTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        changePasswordButton.layer.cornerRadius = 12.0
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
    
    @IBAction func changePassword(_ sender: Any) {
        let password = passwordTextField.text
        
        SVProgressHUD.show()
        
        if passwordTextField.text != passwordRepeatTextField.text{
            passwordTextField.text = ""
            passwordRepeatTextField.text = ""
            SVProgressHUD.showError(withStatus: "Passwords don't match")
        } else {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
            ]
            
            let parameters = ["password":password]
            
            AF.request(Urls.CHANGE_PASSWORD_URL,method: .put, parameters: parameters as Parameters,encoding: JSONEncoding.default, headers: headers).responseData { response in
                
                SVProgressHUD.dismiss()
                
                var resultString = ""
                if let data = response.data{
                    resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
                }
                
                if response.response?.statusCode == 200 {
                    let json = JSON(response.data!)
                    print("JSON: \(json)")
                    let alert = UIAlertController(title: "Password Succesfully Changed", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.navigationController?.popViewController(animated: true)}))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
