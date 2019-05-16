//
//  ImageProvider.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 15/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

final class ImageProvider {
    
    var cache: NSCache<AnyObject, AnyObject>!
    
    func setImage(with url: URL, id: Int) -> UIImage {
//        let dictionnary = dataSource[indexPath.row] as! [String: Any]
//
//        if let image = cache.object(forKey: indexPath.row as AnyObject) as? UIImage {
//            //            cell.image = image
//        } else {
//            let session = URLSession.shared
//            let url = URL(string: "")!
//            let task = session.downloadTask(with: url, completionHandler: { location, response, error in
//                if let data = try? Data(contentsOf: url) {
//                    DispatchQueue.main.async {
//                        let image = UIImage(data: data)!
//                        //                        cell.image = image
//                        self.cache.setObject(image, forKey: indexPath.row as AnyObject)
//                    }
//                }
//            })
//            task.resume()
//        }
        
        
        
        return UIImage()
    }
}

