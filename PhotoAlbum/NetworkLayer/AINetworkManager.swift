//
//  AINetworkManager.swift
//  PhotoAlbum
//
//  Created by Ahsan Iqbal on 11/15/16.
//  Copyright © 2016 Ahsan. All rights reserved.
//

import Foundation
import AFNetworking

enum Service: String {
    case GetMovieList = ""
}

class AINetworkManager: AFHTTPSessionManager {
    
    // MARK: - Singleton Property
    internal static let sharedInstance: AINetworkManager = AINetworkManager(baseURL: URL(string: baseUrl))
    
    // MARK: - Life Cycle
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(baseURL url: URL!) {
        super.init(baseURL: url, sessionConfiguration: nil)
        self.requestSerializer = AFHTTPRequestSerializer()
        self.responseSerializer = JSONResponseSerializerWithData()
    }
    
    // MARK: Instance Methods
    
    @discardableResult func GET(URLString: Service!,
                                parameters parameterDictionary: Dictionary<String, AnyObject>!, needAuthorization need: Bool,
                                progress: ((Progress) -> Void)?,
                                success: ((_ sessionTask :URLSessionDataTask?, _ response: Any?) -> Void)!,
                                failure: ((_ sessionTask: URLSessionDataTask?, _ error: Error?) -> Void)!) -> URLSessionDataTask! {
        print("GET\nURL: \(URLString.rawValue)")
        print("Parameters: \(parameterDictionary)")
        return super.get(URLString.rawValue, parameters: parameterDictionary, progress: progress, success: success, failure: failure)
    }
    
    @discardableResult func POST(URLString: Service!,
                                 parameters parameterDictionary: Dictionary<String, AnyObject>!,
                                 needAuthorization need: Bool,
                                 progress: ((Progress) -> Void)?,
                                 success: ((_ sessionTask: URLSessionDataTask?, _ response: Any?) -> Void)!,
                                 failure: ((_ sessionTask: URLSessionDataTask?, _ error: Error?) -> Void)!) -> URLSessionDataTask! {
        print("POST\nURL: \(URLString.rawValue)")
        print("Parameters: \(parameterDictionary)")
        return super.post(URLString.rawValue, parameters: parameterDictionary, progress: progress, success: success, failure: failure)
        
    }
    
    @discardableResult func POST(URLString: Service!,
                                 parameters parameterDictionary: Dictionary<String, AnyObject>!, needAuthorization need: Bool,
                                 constructingBodyWithBlock block: ((AFMultipartFormData?) -> Void)!,
                                 progress: ((Progress) -> Void)?,
                                 success: ((URLSessionDataTask?, Any?) -> Void)!,
                                 failure: ((URLSessionDataTask?, Error?) -> Void)!) -> URLSessionDataTask! {
        print("POST\nURL: \(URLString.rawValue)")
        print("Parameters: \(parameterDictionary)")
        return super.post(URLString.rawValue, parameters: parameterDictionary, constructingBodyWith: block , progress: progress, success: success, failure: failure)
    }
    
    // MARK: - Helping Methods
    
    func cancelAllTasks() -> Void {
        for task: URLSessionDataTask in (self.dataTasks) {
            task.cancel()
        }
    }
}


