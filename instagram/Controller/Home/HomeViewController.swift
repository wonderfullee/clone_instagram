//
//  HomeViewController.swift
//  instagram
//
//  Created by zhihao li on 3/26/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import KeychainSwift

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var rowData = [String]()
    let list = ["list1", "list2"]
    @IBOutlet weak var table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text  = rowData[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        var ref = Database.database().reference().child("Posts")
        
        ref.observe(.childAdded){ (snapShot) in
            
            let key = snapShot.key
            print(snapShot.key)
            if let postDict = snapShot.value as? Dictionary<String , AnyObject> {
                let post = PostModel(postID: key, diction: postDict)
                print(post.title)
                self.rowData.append(post.postID)
                self.rowData.append(post.title)
               // self.rowData.append(post.likes)
                self.rowData.append(post.imageURL)
               // self.rowData.append(post.creationDate)
                self.table.reloadData()
                
            }
            
        }
    }


    @IBAction func LogoutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try
                firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return
        }
        KeyChainService().keyChain.delete("uid")
        self.navigationController?.popViewController(animated: true)
        
        

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
