//
//  HomeCells.swift
//  MVVM
//
//  Created by Ratheesh on 23/10/18.
//  Copyright © 2018 Ratheesh. All rights reserved.
//

import UIKit

class HomeCells: NSObject {

}

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    func configure(_ model: HomeModel) {
        
        title.text = model.title
        activity.startAnimating()
        
        photo.image = UIImage()
        photo.loadImage(model.url) { [weak self] (loaded) in
            
            guard let weakSelf = self else {  return }
            
            if loaded {
                DispatchQueue.main.async {
                    weakSelf.activity.stopAnimating()
                }
            }
        }
    }
    
    deinit {
        debugPrint("UITableViewCell - deallocated")
    }

}
