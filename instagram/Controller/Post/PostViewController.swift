//
//  PostViewController.swift
//  instagram
//
//  Created by zhihao li on 3/26/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lbl_postStatus: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    @IBAction func UploadImagePressed(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet) // 3 dirrerent item
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {//check if camera are able to use
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else {
                print("Camera is not available")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage//when a user finish select a image pass that as a UIimage
        
        userImage.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func SharePostPressed(_ sender: UIButton) {
        guard let image = userImage.image else {
            self.lbl_postStatus.text = "Please upload a image"
            return
        } //guard like i want to run this code but return if null
        
        guard let data = image.pngData() else { return }
        guard
            
            let title = textField.text,
            let userID = Auth.auth().currentUser?.uid
            
        else{
            return
        }
        
        let creationData = Int(NSDate().timeIntervalSince1970)
        
        var fileName = NSUUID().uuidString
        
        fileName.append(".png")
        
        SVProgressHUD.show()
       
        Storage.storage().reference().child("post_image").child(fileName).putData(data, metadata: nil) { (mataFromStorage, error) in
            
            SVProgressHUD.dismiss()
            if error != nil{
                print("Error Description: ")
                print(error.debugDescription)
                self.lbl_postStatus.text = error.debugDescription
                return;
            }
            print(mataFromStorage)
            
            guard let imageURL = mataFromStorage?.path else{return}
            
            let values = [
                
                "title" :title,
                    "creationData" : creationData,
                    "like": 0,
                    "imageURL": imageURL,
                    "ownerUID": userID
                
                ]as [String: Any]
            
            let postID = Database.database().reference().child("Posts").childByAutoId()
            SVProgressHUD.show()
            postID.updateChildValues(values){(err,ref) in
                SVProgressHUD.dismiss()
                if err != nil{
                    self.lbl_postStatus.text = err.debugDescription
                    print(err.debugDescription)
                    
                }
                self.tabBarController?.selectedIndex = 0
                
            }
        }//find the filepath. when the file finish upload it will return meta or error
        //completion mean when it done then what to do
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
