//
//  newStore.swift
//  FoodRecord
//
//  Created by AllenChang on 2016/12/22.
//  Copyright © 2016年 AllenChang. All rights reserved.
//

import UIKit

class newStore: UIViewController {

    @IBOutlet weak var newStoreImage: UIImageView!
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var newAddTextField: UITextField!
    @IBOutlet weak var newInfoTextField: UITextView!
    
    var addData = [Data]()
    
    @IBAction func finishButton(_ sender: Any) {
        func saveData(){
            let data = Data(image:newStoreImage.image!,storeName:newNameTextField.text!,storeAdd:newAddTextField.text!,info:newInfoTextField.text!)
            let dataUrl = fileInDocuments("addData")
            addData.insert(data, at:0)
            print("addData \(addData.count)")
            let result = NSKeyedArchiver.archiveRootObject(addData, toFile: dataUrl.path)
            print("result\(result)")
        }
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
