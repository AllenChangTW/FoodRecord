//
//  TableViewController.swift
//  FoodRecord
//
//  Created by AllenChang on 2016/12/28.
//  Copyright © 2016年 AllenChang. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var data:[[String:String]]!
    var number:Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = [["storeName":"楊寶寶","storeAdd":"高雄楠梓","info":"info"],["storeName":"黑輪伯","storeAdd":"高雄大社","info":"info"]]
        
        let notificationName = Notification.Name("addStoreNoti")
        
        NotificationCenter.default.addObserver(self, selector: #selector(TableViewController.addStoreNoti(noti:)), name: notificationName, object: nil)
        
        let notificationData = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(storeData.getUpdateNoti(noti:)), name: notificationData, object: nil)
        
        let notificationNumber = Notification.Name("GetUpdateNoti2")
        NotificationCenter.default.addObserver(self, selector: #selector(storeData.getUpdateNoti2(noti:)), name: notificationNumber, object: nil)
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("店名.txt")
        let loadData = NSArray(contentsOf:url!) as! [[String:String]]!
        if loadData != nil{
            data = loadData
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func writeData(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("店名.txt")
        (data as NSArray).write(to: url!, atomically: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storeData"{
            let controller = segue.destination as! storeData
            controller.data = data
            controller.number = number
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func addStoreNoti(noti:Notification){
        let storeDic = noti.userInfo as! [String:String]
        self.data.insert(storeDic, at: 0)
        let indexPath = IndexPath(row:0 , section:0)
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        writeData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        let dic = self.data[indexPath.row]
        cell.textLabel?.text = dic["storeName"]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        number = indexPath.row
        self.performSegue(withIdentifier: "storeData", sender: data)
    }
    
    func getUpdateNoti(noti:Notification){
        data = noti.userInfo!["data"] as! [Dictionary<String, String>]!
        
    }

    func getUpdateNoti2(noti:Notification){
        number = noti.userInfo!["number"] as! Int!
        self.tableView.reloadData()
        writeData()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        writeData()

    }
 

}
