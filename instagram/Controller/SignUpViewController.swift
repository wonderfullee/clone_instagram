//
//  SignUpViewController.swift
//  instagram
//
//  Created by zhihao li on 3/27/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var text_email: UITextField!
    @IBOutlet weak var text_password: UITextField!
    @IBOutlet weak var text_repassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_status.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SigUpPressed(_ sender: UIButton) {
        let email = text_email.text!
        let password = text_password.text!
        let rePassword = text_repassword.text!
        
        if email.isEmail == false {
            lbl_status.isHidden = false
            lbl_status.text = "Invalid Email"
        }
        
        if password != rePassword && password.count < 6 {
            lbl_status.isHidden = false
            lbl_status.text = "Password less than 6 digit or not equal passwords"
        }
        
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                // todo
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                SVProgressHUD.dismiss()
                self.lbl_status.isHidden = false
                self.lbl_status.text = error?.localizedDescription
                return
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
