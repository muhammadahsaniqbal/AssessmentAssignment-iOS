//
//  AIAlbumItem.swift
//  PhotoAlbum
//
//  Created by Ahsan Iqbal on 11/15/16.
//  Copyright © 2016 Ahsan. All rights reserved.
//

import Foundation

class AIAlbumItem: NSObject {
    
    // MARK: - Properties
    var trackId: Int?
    var artistName: String?
    var trackName: String?
    var artworkUrl: String?
    var shortDescription: String?
    var longDescription: String?
    
    
    // MARK: - Parse Server Response
    
    init(parameters: [String: AnyObject]) {
        if let trackId = parameters["trackId"] {
            self.trackId = trackId as? Int
        }
        if let artistName = parameters["artistName"] {
            self.artistName = artistName as? String
        }
        if let trackName = parameters["trackName"] {
            self.trackName = trackName as? String
        }
        if let artworkUrl = parameters["artworkUrl100"] {
            self.artworkUrl = artworkUrl as? String
        }
        if let shortDescription = parameters["shortDescription"] {
            self.shortDescription = shortDescription as? String
        }
        if let longDescription = parameters["longDescription"] {
            self.longDescription = longDescription as? String
        }
    }
}
