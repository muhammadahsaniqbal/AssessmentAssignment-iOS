//
//  JSONResponseSerializerWithData.swift
//  MaqtaGateway
//
//  Created by Umair Aamir on 12/08/2015.
//  Copyright (c) 2015 ADPC. All rights reserved.
//

import UIKit
import AFNetworking
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


let AFNetworkingOperationFailingWithDataKey: String = "AFNetworkingOperationFailingWithDataKey"
let AFNetworkingOperationFailingErrorStatusCode: String = "AFNetworkingOperationFailingErrorStatusCode"

class JSONResponseSerializerWithData: AFJSONResponseSerializer {
    
    
    func responseObject(for response: URLResponse!, data: Data!) throws -> AnyObject {
        
        do {
            try self.validate(response as? HTTPURLResponse, data: data)
        } catch let error1 as NSError {
            let errorMemory: NSError! = error1
            var userInfo: Dictionary<String, AnyObject>! = errorMemory.userInfo as? Dictionary<String, AnyObject>
                
            let responseDictionary: Dictionary<String, AnyObject>? = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? Dictionary<String, AnyObject>
            if responseDictionary?.count > 0 {                    
                userInfo[AFNetworkingOperationFailingWithDataKey] = responseDictionary as AnyObject?
                userInfo[AFNetworkingOperationFailingErrorStatusCode] = (response as? HTTPURLResponse)?.statusCode as AnyObject?
            }
            throw NSError(domain: errorMemory.domain, code: errorMemory.code, userInfo: userInfo)
        }
        var error: NSError?
        return super.responseObject(for: response, data: data, error: &error) as AnyObject
    }
}
