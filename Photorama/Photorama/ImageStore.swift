//
//  ImageStore.swift
//  Homepwner
//
//  Created by Ivan Cai on 3/11/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit

class ImageStore{
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key:String){
        cache.setObject(image, forKey: key)
        
        let imageURL = imageURLForKey(key)
        
        if let data = UIImagePNGRepresentation(image){
            data.writeToURL(imageURL, atomically: true)
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        if let exisitingImage = cache.objectForKey(key) as? UIImage{
            return exisitingImage
        }
        
        let imageURL=imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else{
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String){
        cache.removeObjectForKey(key)
        
        let imageURL = imageURLForKey(key)
        
        do{
            try NSFileManager.defaultManager().removeItemAtURL(imageURL)
        }
        catch let deleteError{
            print("Encounting error when removing the image from disk: \(deleteError)")
        }
    }
    
    func imageURLForKey(key: String)->NSURL{
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        return documentsDirectory.URLByAppendingPathComponent(key)
    }
}
