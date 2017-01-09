//
//  storeDataEdit.swift
//  FoodRecord
//
//  Created by AllenChang on 2016/12/22.
//  Copyright © 2016年 AllenChang. All rights reserved.
//

import UIKit

class storeDataEdit: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    var data:[[String:String]]!
    var number:Int!

    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var editNameField: UITextField!
    @IBOutlet weak var editAddField: UITextField!
    @IBOutlet weak var editInfoText: UITextView!
    
    @IBAction func edifFinishButton(_ sender: Any) {
        data[number]["storeName"] = editNameField.text
        data[number]["storeAdd"] = editAddField.text
        data[number]["info"] = editInfoText.text
        
        let notificationdata = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.post(name: notificationdata, object: nil , userInfo: ["data":data])
        let notificationNumber = Notification.Name("GetUpdateNoti2")
        NotificationCenter.default.post(name: notificationNumber, object: nil, userInfo: ["number":number])
        
        navigationController?.popViewController(animated: true)
        
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
 
    @IBAction func editCameraButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("info\(info)")
        let image = info[UIImagePickerControllerOriginalImage]
        self.editImage.image = image as? UIImage
        
        if picker.sourceType == .camera{
            UIImageWriteToSavedPhotosAlbum(self.editImage.image!, nil, nil, nil)
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

    @IBAction func editPhotoButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editNameField.text = data[number]["storeName"]
        editAddField.text = data[number]["storeAdd"]
        editInfoText.text = data[number]["info"]
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let getName1 = data[number]["storeName"]! + ".jpg"
        let url = docUrl?.appendingPathComponent(getName1)
        let image = UIImage(contentsOfFile: (url?.path)!)
        editImage.image = image

        
        self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
