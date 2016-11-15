//
//  AIAlbumCollectionViewCell.swift
//  PhotoAlbum
//
//  Created by Ahsan Iqbal on 11/15/16.
//  Copyright © 2016 Ahsan. All rights reserved.
//

import UIKit

class AIAlbumCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageViewAlbumItem: UIImageView!
    
    // MARK: - LifeCycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: Update Cell Data
    
    func updateCellData (_ data: AIAlbumItem?) {
        if let imageUrl = URL(string: (data?.artworkUrl!)!) {
            imageViewAlbumItem.setImageWith(imageUrl, placeholderImage: UIImage(named: "Sample.jpg"))
            //imageViewAlbumItem.downloadedFrom(url: imageUrl)
        }
    }
}
