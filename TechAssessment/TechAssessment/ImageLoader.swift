//
//  ImageLoader.swift
//  TechAssessment
//
//  Created by Darshana  on 14/04/24.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        
        DispatchQueue.global().async {
            if let url = URL(string: urlString),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
