//
//  ApiManager.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    
    func requestAPI(url: String, method: HTTPMethod, parameters: [String: Any]?, callback:@escaping (_ json: JSON?, _ message: String, _ error: Bool)->()) {
        // Confirmamos si tenemos conexión a internet
        if Reachability.isConnectedToNetwork(){
            Alamofire.request(url, method: method, parameters: parameters, headers:  nil).responseJSON { response in
                switch(response.result)
                {
                case .success(let data):
                    let jsonResult = response.result.value as! NSDictionary
                    let dataJson = JSON(data)
                    if let httpStatusCode = response.response?.statusCode
                    {
                        switch(httpStatusCode){
                        case 201, 200:
                            callback(dataJson, "exito", false)
                        default:
                            print("Code: \(httpStatusCode) Mensaje: \(jsonResult["message"] ?? "N/A")")
                            if let messageResponse = jsonResult["message"] {
                                let message = messageResponse as! String
                                callback(nil, message, true)
                            }
                        }
                    }
                case .failure(let error):
                    if let httpStatusCode = response.response?.statusCode {
                        print("Error \(httpStatusCode)")
                        callback(nil, "Error \(httpStatusCode)", true)
                    }
                    else {
                        print(error.localizedDescription)
                        callback(nil, error.localizedDescription, true)
                    }
                }
            }
        } else {
            callback(nil, "Sin internet", true)
        }
    }
}

