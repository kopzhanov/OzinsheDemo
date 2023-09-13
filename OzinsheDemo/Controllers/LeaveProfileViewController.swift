//
//  LeaveProfileViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 09.09.2023.
//

import UIKit

class LeaveProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        backgroundView.layer.cornerRadius = 32
        backgroundView.clipsToBounds = true
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgroundView))!{
            return false
        }
        return true
    }
    
    @IBAction func leaveProfile(_ sender: Any) {
        let alert = UIAlertController(title: "You left from your profile", message: "You can always login back", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.dismissView()}))
        present(alert, animated: true)
        //Need to add appropriate functionality later
    }
    
    @IBAction func notLeave(_ sender: Any) {
        dismissView()
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
