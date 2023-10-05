//
//  EditProfileViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 13.08.2023.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getProfileInfo()
    }
    
    func configureViews(profile:Profile){
        nameTextField.text = profile.name
        emailTextField.text = profile.email
        phoneNumberTextField.text = profile.phoneNumber
        birthDateTextField.text = profile.birthDate
    }
    
    func getProfileInfo(){
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(Storage.sharedInstance.accessToken)"]
        
        AF.request(Urls.PROFILE_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                let profile = Profile(json: json)
                self.configureViews(profile: profile)
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
    
    @IBAction func changeInfo(_ sender: Any) {
        let alert = UIAlertController(title: "Saved", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.navigationController?.popViewController(animated: true)}))
        present(alert, animated: true)
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
