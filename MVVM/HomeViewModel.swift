//
//  HomeViewModel.swift
//  MVVM
//
//  Created by Ratheesh on 23/10/18.
//  Copyright © 2018 Ratheesh. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {

    let baseURL = "https://jsonplaceholder.typicode.com/photos"
    
    var items: [HomeModel]? = []
    var errorMessage: String?
    
    func getApiData(completion: @escaping (([HomeModel]?) -> ())) {
        
        guard let url = URL(string: baseURL) else { return }
        let request = URLRequest(url: url)
        
        WebService.serviceRequest(request, [HomeModel].self) { [weak self] (data, error) in
            
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                weakSelf.errorMessage = error?.localizedDescription
                completion(nil)
                return
            }
            
            guard let data = data as? [HomeModel] else {
                weakSelf.errorMessage = "No items, please try again"
                completion(nil)
                return
            }
            weakSelf.items = data
            completion(data)
        }
        
    }
    
    deinit {
        debugPrint("HomeViewModel - deallocated")
    }

}
