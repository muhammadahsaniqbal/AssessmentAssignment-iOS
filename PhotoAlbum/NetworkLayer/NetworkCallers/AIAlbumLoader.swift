//
//  AIAlbumLoader.swift
//  PhotoAlbum
//
//  Created by Ahsan Iqbal on 11/15/16.
//  Copyright © 2016 Ahsan. All rights reserved.
//

import UIKit

class AIAlbumLoader: NSObject {
    
    let networkManager: AINetworkManager = AINetworkManager.sharedInstance
    
    func getMovieList(parameters: Dictionary<String, AnyObject>,
                         successBlock success: ((_ complete: [AIAlbumItem]) -> Void)!,
                         failureBlock failure: ((_ error: NSError?) -> Void)!) {
        networkManager.GET(URLString: Service.GetMovieList,
                           parameters: parameters,
                           needAuthorization: true,
                           progress: nil,
                           success: { (sessionTask, response) -> Void in
                            self.parseAlbumResponse(response as AnyObject, successBlock: success, failureBlock: failure)
        }) { (sessionTask, error) -> Void in
            failure?(NSError())
        }
    }
    
    // MARK: - Helper method
    fileprivate func parseAlbumResponse(_ response: AnyObject, successBlock success: ((_ autoComplete: [AIAlbumItem]) -> Void)!,
                                           failureBlock failure: ((_ error: NSError?) -> Void)!) -> Void {
        let movieResponse: AIAlbumResponse = AIAlbumResponse(response: response)
        success?(movieResponse.arrRespose!)
    }

}
