//
//  newStore.swift
//  FoodRecord
//
//  Created by AllenChang on 2016/12/22.
//  Copyright © 2016年 AllenChang. All rights reserved.
//

import UIKit
class newStore: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var data:[[String:String]]!
    var number:Int!
    
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!

    @IBAction func finishButton(_ sender: Any) {
        let dic = ["storeName":self.nameField.text!,"storeAdd":self.addField.text!,"info":self.infoTextView.text!]
        let notificationName = Notification.Name("addStoreNoti")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: dic)
        
        self.navigationController?.popViewController(animated: true)
                
    }
    
    func loadPicture(name:String)->UIImage{
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let gatName = name + ".jpg"
        let url = docUrl?.appendingPathComponent(gatName)
        let image = UIImage(contentsOfFile: (url?.path)!)
        return image!
    }
 
    @IBAction func cameraButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("info\(info)")
        let image = info[UIImagePickerControllerOriginalImage]
        self.newImage.image = image as? UIImage
        
        if picker.sourceType == .camera{
            UIImageWriteToSavedPhotosAlbum(self.newImage.image!, nil, nil, nil)
        }
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let getdata = self.data[number]["storeName"]
        let name = "\(getdata!).jpg"
        let url = docUrl?.appendingPathComponent(name)
        let data = UIImageJPEGRepresentation(image as! UIImage, 0.9)
        try! data?.write(to: url!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
