//
//  dataDetail.swift
//  FoodRecord
//
//  Created by AllenChang on 2016/12/22.
//  Copyright © 2016年 AllenChang. All rights reserved.
//

import Foundation
import UIKit

class Data: NSObject,NSCoding{
    var image: UIImage!
    var storeName: String!
    var storeAdd: String!
    var info: String!
    
    func fileInDocuments(_ fileName: String) -> URL{
        let fileManager = FileManager.default
        let urls = FileManager.urls(for:.documentDirectory, in:.userDomainMask)
        let fileUrl = urls[0].appendingPathComponent(fileName)
        return fileUrl
    }
    
    init(image:UIImage,storeName:String,storeAdd:String,info:String) {
        self.image = image
        self.storeName = storeName
        self.storeAdd = storeAdd
        self.info = info
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        let image = aDecoder.decodeObject(forKey: "image") as! Data
        self.image = UIImage(data: image)
        storeName = aDecoder.decodeObject(forKey: "storeName") as! String
        storeAdd = aDecoder.decodeObject(forKey: "storeAdd") as! String
        info = aDecoder.decodeObject(forKey: "info") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        let image = UIImageJPEGRepresentation(self.image!, 100)
        aCoder.encode(image, forKey: "image")
        aCoder.encode(storeName, forKey: "storeName")
        aCoder.encode(storeAdd, forKey: "storeAdd")
        aCoder.encode(info, forKey: "info")
    }
    
}
