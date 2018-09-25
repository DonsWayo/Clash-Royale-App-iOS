//
//  Player.swift
//  crapi
//
//  Created by wayo on 24/09/2018.
//  Copyright © 2018 juanjosecarracedo. All rights reserved.
//

import Foundation


public class Api{
    
    let endpoints = Endpoints()
    let token = AppSettings.init().Api_key
    
    func apiService(type:String,endPoint:String,option:String? = nil, completionHandler: @escaping (_ data:Data?) -> Void) {
        
        let urlReq: String
       
        if option != nil {
            urlReq = "https://api.royaleapi.com/\(endPoint)/\(type)/\(String(describing: option))"
        }else{
            urlReq = "https://api.royaleapi.com/\(endPoint)/\(type)"
        }
        
        let url = URL(string: urlReq)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil && data != nil else
            {
                print("error=\(String(describing: error))")
                completionHandler(data)
                return
            }
            
            completionHandler(data)
            }.resume()
       
        

    }
    
    
    
        
        
}
