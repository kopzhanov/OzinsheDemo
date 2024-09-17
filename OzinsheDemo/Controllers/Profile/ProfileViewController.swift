//
//  ProfileViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 07.08.2023.
//

import UIKit
import Localize_Swift

class ProfileViewController: UIViewController, LanguageProtocol {
    
    @IBOutlet weak var myProfileLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var personalDataButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var darkModeButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureViews()
    }
    
    
    func configureViews(){
        self.navigationItem.title = "PROFILE".localized()
        myProfileLabel.text = "MY_PROFILE".localized()
        personalDataButton.setTitle("PERSONAL_DATA".localized(), for: .normal)
        changePasswordButton.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
        termsAndConditionsButton.setTitle("TERMS_AND_CONDITIONS".localized(), for: .normal)
        notificationsButton.setTitle("NOTIFICATIONS".localized(), for: .normal)
        darkModeButton.setTitle("DARK_MODE".localized(), for: .normal)
        
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        
        if Localize.currentLanguage() == "en"{
            languageLabel.text = "English"
        }
        if Localize.currentLanguage() == "kk"{
            languageLabel.text = "Қазақша"
        }
        if Localize.currentLanguage() == "ru"{
            languageLabel.text = "Русский"
        }
    }
    
    @IBAction func LeaveProfile(_ sender: Any) {
        let leaveProfileVC = storyboard?.instantiateViewController(withIdentifier: "LeaveProfileViewController") as! LeaveProfileViewController
        
        leaveProfileVC.modalPresentationStyle = .overFullScreen
        
        present(leaveProfileVC, animated: true, completion: nil)
    }
    
    @IBAction func EditProfileShow(_ sender: Any) {
        let editProfileVC = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        navigationController?.show(editProfileVC, sender: self)
    }
    
    @IBAction func ChangePasswordShow(_ sender: Any) {
        let changePasswordVC = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        navigationController?.show(changePasswordVC,sender: self)
    }
    
    
    @IBAction func LanguageShow(_ sender: Any) {
        let languageVC = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        
        languageVC.modalPresentationStyle = .overFullScreen
        
        languageVC.delegate = self
        
        present(languageVC, animated: true, completion: nil)
    }
    
    func languageDidChange() {
        configureViews()
    }
    
    
    @IBAction func switcherChanged(_ sender: UISwitch) {
        if sender.isOn{
            UIApplication.shared.windows.forEach{ window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach{ window in
                window.overrideUserInterfaceStyle = .light
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
