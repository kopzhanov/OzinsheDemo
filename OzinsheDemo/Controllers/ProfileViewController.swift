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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureViews()
    }
    
    
    func configureViews(){
        myProfileLabel.text = "MY_PROFILE".localized()
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
    
    @IBAction func LanguageShow(_ sender: Any) {
        let languageVC = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        
        languageVC.modalPresentationStyle = .overFullScreen
        
        languageVC.delegate = self
        
        present(languageVC, animated: true, completion: nil)
    }
    
    func languageDidChange() {
        configureViews()
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
