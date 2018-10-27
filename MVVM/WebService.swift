//
//  WebService.swift
//  MVVM
//
//  Created by Ratheesh on 23/10/18.
//  Copyright © 2018 Ratheesh. All rights reserved.
//

import UIKit

enum ServiceError: Error {
    case urlError(_ reason: String)
    case objectSerialization(_ reason: String)
}

class WebService: NSObject {

    static func serviceRequest<T: Decodable>(_ urlRequest: URLRequest?,_ resultModel: T.Type, completion: @escaping ((Any?, Error?) -> ())) {
        
        guard let request = urlRequest, let _ = request.url else  {
            let error = ServiceError.urlError("Could not find URL")
            completion(nil, error)
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                let error = ServiceError.objectSerialization("No data in response")
                completion(nil, error)
                return
            }
            debugPrint(httpResponse.statusCode)
            
            do {
                let resultantModel = try JSONDecoder().decode(resultModel.self, from: responseData)
                completion(resultantModel, nil)
            } catch {
                debugPrint("error trying to convert data to JSON")
                debugPrint(error)
                completion(nil, error)
            }
        }
        
        task.resume()
        
    }
}
