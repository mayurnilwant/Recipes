//
//  UIImageView+Extension.swift
//  Recipes
//
//  Created by Mayur Nilwant on 17/01/2024.
//

import Foundation
import UIKit


extension UIImageView {
    
    func circularImage(withBorderWidth bWidth: Float, andBorderColor bColor : UIColor = .black) {
        
        let cons = self.constraints.filter {
            $0.firstAttribute == NSLayoutConstraint.Attribute.width
        }
        
        let widthCon = cons.first
        self.layer.cornerRadius = (widthCon?.constant ?? 100.0)/2
        self.layer.borderWidth = CGFloat(bWidth)
        self.layer.borderColor = bColor.cgColor
        
    }
    
    func downLoadImageInBackground(withUrl url: String)  {
        
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        let session = URLSession.shared
        
        Task {
            let (imgData, httpResponse) = try await session.data(from: imageUrl)
            
            guard (httpResponse as? HTTPURLResponse)?.statusCode == 200 else {
                    return
            }
            self.image = UIImage(data: imgData)
        }
        
        
        
        
//        let _ = session.dataTask(with: URLRequest(url: imageUrl)) {[weak self] imageData, response, error in
//            
//            guard let status = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(status) else {
//                
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self?.image = UIImage(data: imageData ?? Data())
//            }
//            
//            
//        }.resume()
        
    }
    
}
