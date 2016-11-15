//
//  AIAlbumSummaryViewController.swift
//  PhotoAlbum
//
//  Created by Ahsan Iqbal on 11/15/16.
//  Copyright © 2016 Ahsan. All rights reserved.
//

import UIKit

class AIAlbumSummaryViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageViewAlbumItem: UIImageView!
    @IBOutlet weak var textViewImageDetails: UITextView!
    
    // MARK: - Properties
    var albumItem: AIAlbumItem?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Album Image and Long Description from model 
        
        if let item = albumItem {
            textViewImageDetails.text = item.longDescription
            imageViewAlbumItem.setImageWith(URL(string:item.artworkUrl!)!, placeholderImage: UIImage(named: "Sample.jpg"))
            //imageViewAlbumItem.downloadedFrom(url: URL(string:item.artworkUrl!)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction Methods
    @IBAction func backAction(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
}
