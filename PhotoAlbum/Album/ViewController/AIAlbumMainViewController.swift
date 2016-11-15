//
//  AIAlbumMainViewController.swift
//  PhotoAlbum
//
//  Created by Ahsan Iqbal on 11/15/16.
//  Copyright © 2016 Ahsan. All rights reserved.
//

import UIKit
import SVProgressHUD

class AIAlbumMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var textViewImageDetails: UITextView!
    @IBOutlet weak var buttonNext: UIButton!
    
    // MARK: - Properties
    fileprivate let albumLoader: AIAlbumLoader = AIAlbumLoader()
    var albumContent =  Array<AIAlbumItem>()
    var currentAlbumItem: AIAlbumItem?
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        self.albumLoader.getMovieList(parameters: [:], successBlock: {[weak self] (movies) in
            SVProgressHUD.dismiss()
            if let strongSelf = self {
                strongSelf.albumContent = movies
                strongSelf.collectionView.reloadData()
                strongSelf.pageControl.numberOfPages = strongSelf.albumContent.count
                strongSelf.currentAlbumItem = strongSelf.albumContent.first
                strongSelf.setImageDetailsText(index: 0)
            }
            }) { (error) in
                print(error?.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Method
    
    func setImageDetailsText(index: Int) {
        var shortDescription = ""
        var trackName = ""
        if let shortDes = albumContent[index].shortDescription {
            shortDescription = shortDes
        }
        if let track = albumContent[index].trackName {
            trackName = track
        }
        textViewImageDetails.text = "\(trackName)\n\n\(shortDescription)"
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlbumSummarySegueId" {
            let albumSummaryViewController = segue.destination as! AIAlbumSummaryViewController
            albumSummaryViewController.albumItem = currentAlbumItem
        }
    }
    
}

extension AIAlbumMainViewController {
    
    // MARK: - UICollectionView DataSource & Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumContent.count
    }
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionCellId", for: indexPath) as! AIAlbumCollectionViewCell
        cell.updateCellData(albumContent[indexPath.row])
        return cell
    }
    
    // MARK: - UIScrollView Delegate Method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        pageControl.currentPage = Int(collectionView.contentOffset.x / pageWidth)
        
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        
        currentAlbumItem = albumContent[visibleIndexPath.row]
        setImageDetailsText(index: visibleIndexPath.row)
    }
    
}
