//
//  ForgetPasswordViewController.swift
//  instagram
//
//  Created by zhihao li on 3/27/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var text_email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_status.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPasswordPressed(_ sender: UIButton) {
        let email = text_email.text!
        
        SVProgressHUD.show()
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil{
                SVProgressHUD.dismiss()
                self.lbl_status.isHidden = false
                self.lbl_status.text = error?.localizedDescription
            }else{
                SVProgressHUD.dismiss()
                self.lbl_status.isHidden = false
                self.lbl_status.text = "A reset password link will be send to your email shortly"
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
