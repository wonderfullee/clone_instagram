//
//  ViewController.swift
//  instagram
//
//  Created by zhihao li on 3/19/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

class LoginViewController: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var lbl_status: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       // lbl_status.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = KeyChainService().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    func AddKeyChainAfterLogin(uid: String){
        let keyChain = KeyChainService().keyChain
        keyChain.set(uid, forKey: "uid")
    }
    @IBAction func LoginPressed(_ sender: UIButton) {
        let email = textEmail.text!
        let password = textPassword.text!
        if email.isEmail == false {
            lbl_status.text = "Invalid Email"
            return
        }
        if password.count < 6 {
            lbl_status.text = "Invalid Password"
            return
        }
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            if error == nil {
                strongSelf.AddKeyChainAfterLogin(uid: user!.user.uid)
                //perform segue to signinview controller
                SVProgressHUD.dismiss()
                strongSelf.performSegue(withIdentifier: "LoginSegue", sender: strongSelf)
            }else {
                SVProgressHUD.dismiss()
                strongSelf.lbl_status.isHidden = false
                strongSelf.lbl_status.text = error?.localizedDescription
                return
            }
        }
    }
    
    @IBAction func ForgetPassPress(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgetPasswordSegue", sender: self)
    }
    
    @IBAction func SigUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SignUpSegue", sender: self)
    }
}

