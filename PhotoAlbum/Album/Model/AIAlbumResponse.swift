//
//  AIAlbumResponse.swift
//  PhotoAlbum
//
//  Created by Ahsan Iqbal on 11/15/16.
//  Copyright © 2016 Ahsan. All rights reserved.
//

import Foundation

class AIAlbumResponse: NSObject {
    var arrRespose: [AIAlbumItem]?
    
    init(response: AnyObject) {
        let responseDic = response as! Dictionary<String, AnyObject>
            self.arrRespose = Array()
            if let _ = responseDic["results"] as? [Dictionary<String, AnyObject>] {
                let arrRes = responseDic["results"] as! [Dictionary<String, AnyObject>]
                for dic in arrRes {
                    let albumItem = AIAlbumItem(parameters: dic)
                    arrRespose?.append(albumItem)
                }
            }
    }
}
