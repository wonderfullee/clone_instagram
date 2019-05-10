//
//  SearchViewController.swift
//  instagram
//
//  Created by zhihao li on 4/21/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    var rowData = [String]()
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        
        var ref = Database.database().reference().child("User")
        
        ref.observe(.childAdded) {(snapShot) in
            let key = snapShot.key
            print(key)
            if let postDict = snapShot.value as? Dictionary<String , AnyObject> {
                let user = UserModel(userID: key, dictionary: postDict)
               
                self.rowData.append(user.title)
                self.rowData.append(user.imageURL)
                self.table.reloadData()
                
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = rowData[indexPath.row]
        return cell
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
