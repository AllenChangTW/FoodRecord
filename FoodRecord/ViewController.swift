//
//  ViewController.swift
//  FoodRecord
//
//  Created by AllenChang on 2016/12/20.
//  Copyright © 2016年 AllenChang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var data = [["storeName":"楊寶寶","storeAdd":"高雄楠梓","info":"info"],["storeName":"黑輪伯","storeAdd":"高雄大社","info":"info"]]
    var number:Int!
    
    @IBOutlet weak var name1: UIButton!
    @IBOutlet weak var name2: UIButton!
    @IBOutlet weak var name3: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! storeData
        controller.data = data
        controller.number = number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationData = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(storeData.getUpdateNoti(noti:)), name: notificationData, object: nil)
        
        let notificationNumber = Notification.Name("GetUpdataNoti2")
        NotificationCenter.default.addObserver(self, selector: #selector(storeData.getUpdateNoti2(noti:)), name: notificationNumber, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func getUpdateNoti(noti:Notification){
        data = noti.userInfo!["data"] as! [Dictionary<String,String>]!
    }
    
    func getUpdateNoti2(noti:Notification){
        number = noti.userInfo!["number"] as! Int!
        if number == 0 {
            name1.setTitle(data[number]["storeName"], for: .normal)
        }
        if number == 1 {
            name2.setTitle(data[number]["storeName"], for: .normal)
        }
        if number == 2 {
            name3.setTitle(data[number]["storeName"], for: .normal)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPageButton(_ sender: Any) {

        
        let but = sender as! UIButton
        number = but.tag
        self.performSegue(withIdentifier: "storeAata", sender: data )
    }
    

}

