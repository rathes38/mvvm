//
//  HomeModel.swift
//  MVVM
//
//  Created by Ratheesh on 23/10/18.
//  Copyright © 2018 Ratheesh. All rights reserved.
//

import UIKit


struct HomeModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case title
        case url
        case thumbnailUrl
    }
    
    let title: String?
    let thumbnailUrl: String?
    let url: String?
    
}


extension UIImageView {
    
    func loadImage(_ url: String?, completion: @escaping ((Bool) -> ())) {
        
        guard let urlString = url, let imageUrl = URL(string: urlString) else {
            completion(false)
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            
            guard let weakSelf = self, error == nil, let imageData = data else {
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                weakSelf.image = UIImage(data: imageData)
            }
            completion(true)
        }.resume()
    }
}
