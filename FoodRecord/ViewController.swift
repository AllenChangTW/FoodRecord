//
//  ViewController.swift
//  FoodRecord
//
//  Created by AllenChang on 2016/12/20.
//  Copyright © 2016年 AllenChang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var addData = [Data]()
    
    
    func loadData(){
        let fileManager = FileManager()
        let dataUrl = fileInDocuments("addData")
        if fileManager.fileExists(atPath: dataUrl.path){
            let data = NSKeyedUnarchiver.unarchiveObject(with: dataUrl.path) as! [Data]
            addData = data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

