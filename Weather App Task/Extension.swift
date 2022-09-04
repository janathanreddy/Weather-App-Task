//
//  Extension.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation
import UIKit

extension ViewController{
    
    func showAlert(_ tit:String,_ msg:String){
       let alert = UIAlertController.init(title: tit, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated:true)
    }
    
}




let imageCache = NSCache<AnyObject, AnyObject>()
var imageURL: URL?
let activityIndicator = UIActivityIndicatorView()


extension UIImageView {

   
    func loadImageWithUrl(from urls: URL) {

        // setup activityIndicator...
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true


        image = nil
        activityIndicator.startAnimating()

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: urls as AnyObject) as? UIImage {

            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: urls, completionHandler: { (data, response, error) in

            if error != nil {
                print(error as Any)
                
                return
            }

            DispatchQueue.main.async(execute: {

                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {

                        self.image = imageToCache

                    imageCache.setObject(imageToCache, forKey: urls as AnyObject)
                }
            })
        }).resume()
    }
}

