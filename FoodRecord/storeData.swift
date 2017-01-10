//
//  storeData.swift
//  FoodRecord
//
//  Created by AllenChang on 2016/12/22.
//  Copyright © 2016年 AllenChang. All rights reserved.
//

import UIKit

class storeData: UIViewController,UIImagePickerControllerDelegate,UINavigationBarDelegate {

    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var infoLabel: UITextView!
    
    var data1:[Dictionary<String, String>]!
    var storeName:String!
    var storeAdd:String!
    var storeinfo:String!
    var data:[Dictionary<String, String>]!
    var number:Int!
    var number2:Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let notificationData = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(storeData.getUpdateNoti(noti:)), name: notificationData, object: nil)
        let notificationNumber = Notification.Name("GetUpdateNoti2")
        NotificationCenter.default.addObserver(self, selector: #selector(storeData.getUpdateNoti2(noti:)), name: notificationNumber, object: nil)
        nameLabel.text = data[number]["storeName"]
        addLabel.text = data[number]["storeAdd"]
        infoLabel.text = data[number]["info"]
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let getName1 = data[number]["storeName"]! + ".jpg"
        let url = docUrl?.appendingPathComponent(getName1)
        let image = UIImage(contentsOfFile: (url?.path)!)
        picView.image = image
        
        
        //內容是否可選
        infoLabel.isSelectable = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! storeDataEdit
        controller.data = data
        controller.number = number
    }
    
    func getUpdateNoti(noti:Notification){
        data = noti.userInfo!["data"] as! [Dictionary<String, String>]!
    }
    
    func getUpdateNoti2(noti:Notification){
        number = noti.userInfo!["number"] as! Int!
        nameLabel.text = data[number]["storeName"]
        addLabel.text = data[number]["storeAdd"]
        infoLabel.text = data[number]["info"]
        writeData()
    }
    
    func writeData(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("店名.txt")
        (data as NSArray).write(to: url!, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButton(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "storeData", sender: data)
    }
    
    func loadPicture(name:String)->UIImage{
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let gatName1 = name + ".jpg"
        let url = docUrl?.appendingPathComponent(gatName1)
        let image = UIImage(contentsOfFile: (url?.path)!)
        return image!
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("info \(info)")
        let image = info[UIImagePickerControllerOriginalImage]
        self.picView.image = image as? UIImage
        if picker.sourceType == .camera{
            UIImageWriteToSavedPhotosAlbum(self.picView.image!, nil, nil, nil)
        }
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let getData = self.data[number]["storeName"]
        let name = "\(getData!).jpg"
        let url = docUrl?.appendingPathComponent(name)
        let data = UIImageJPEGRepresentation(image as! UIImage, 0.9)
        try! data?.write(to: url!)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //每次畫面現身都被呼叫，但畫面未現身前執行
    override func viewWillAppear(_ animated: Bool) {
        
        let notificationData = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(storeData.getUpdateNoti(noti:)), name: notificationData, object: nil)
        let notificationNumber = Notification.Name("GetUpdateNoti2")
        NotificationCenter.default.addObserver(self, selector: #selector(storeData.getUpdateNoti2(noti:)), name: notificationNumber, object: nil)
        nameLabel.text = data[number]["storeName"]
        addLabel.text = data[number]["storeAdd"]
        infoLabel.text = data[number]["info"]
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let getName1 = data[number]["storeName"]! + ".jpg"
        let url = docUrl?.appendingPathComponent(getName1)
        let image = UIImage(contentsOfFile: (url?.path)!)
        picView.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
