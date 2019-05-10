//
//  ProfileViewController.swift
//  instagram
//
//  Created by zhihao li on 3/26/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ProfileViewController: UIViewController {

    @IBOutlet weak var lbl_curEmail: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var text_email: UITextField!
    @IBOutlet weak var text_name: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapestrueRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(self.imageTapped(tapestrueRecognizer:)))
        // Do any additional setup after loading the view.
        LoadUserProfile()
       profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapestrueRecognizer)
       
    }
    @objc func imageTapped(tapestrueRecognizer: UITapGestureRecognizer){
        let tappedImaged = tapestrueRecognizer.view as! UIImageView
        
        //guard let user = Auth.auth().currentUser else {return}
       // guard let tapImage = profileImage.view as ! UIImageView
    }
    func LoadUserProfile(){
        guard let user = Auth.auth().currentUser else{ return }
        let userId = user.uid
        
        let ref = Database.database().reference().child("users").child(userId)
        ref.observe(.childAdded) { (snapShot) in
            print(snapShot)
            let key = snapShot.key
            guard let dictionary = snapShot.value as? Dictionary<String , AnyObject> else {return}
                let user = UserModel(userID: key, dictionary : dictionary)
                self.text_email.text = user.email
                self.text_name.text = user.name
               // self.rowData.append(post.title)
               // self.table.reloadData()
        }
        
        
        if let fullName = user.displayName{
            text_name.text = fullName
        }
        
        if let email = user.email{
            text_email.text = email
        }
        
        if let photoURL = user.photoURL{
            
        }
    }
    @IBAction func nameChanged(_ sender: Any) {
        guard let user = Auth.auth().currentUser else{return}
        let changedRequest = user.createProfileChangeRequest()
        
        changedRequest.displayName = text_name.text
        
        changedRequest.commitChanges{ error in
            if error != nil{
                self.lbl_status.text = error?.localizedDescription
                print(error.debugDescription)
                return
            }
            print("Profile Updated")
            
        }
    }
    @IBAction func uploadProfilePressed(_ sender: UIButton) {
        UploadProfilePic()
    }
    
    func UploadProfilePic(){
        guard let user = Auth.auth().currentUser else{return}
        guard let image = profileImage.image else{
            return
        }
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }//compress the image
        let userUID = user.uid
        
        SVProgressHUD.show()
        
        Storage.storage().reference().child("post_image").child(userUID).child("image.png").putData(data, metadata: nil) { (mataFromStorage, error) in
            
            SVProgressHUD.dismiss()
            if error != nil{
                print("Error Description: ")
                self.lbl_status.text = error?.localizedDescription
                //self.lbl_status.text =  error.debugDescription
               
                return;
            }

                guard let imageURL = mataFromStorage?.path else {return}
            let picURL = URL(string: imageURL)
            
            guard let user = Auth.auth().currentUser else{return}
            let changedRequest = user.createProfileChangeRequest()
            
            changedRequest.photoURL = picURL
            
            changedRequest.commitChanges{ error in
                if error != nil{
                    self.lbl_status.text = error?.localizedDescription
                    print(error.debugDescription)
                    return
                }
                print("Profile Updated")
                
                
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
}
