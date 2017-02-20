//
//  ImageCollectionVC.swift
//  KodakVer3
//
//  Created by jmolas on 2/16/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import Photos

class ImageCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var folderName: UILabel!
    var name: String!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        
        }
        
    }
    
    var collections : PHFetchResult<PHAssetCollection>!
    
    var imageArray = [UIImage!]()
    
    func loadPhotos(){
    
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let phFetchOptions = PHFetchOptions()
        phFetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        phFetchOptions.predicate = NSPredicate(format: "mediaType = %d", argumentArray: [PHAssetMediaType.image.rawValue])
        
        //let collectionRes = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        let fetchAssetResult = PHAsset.fetchAssets(in: collections.firstObject!, options: phFetchOptions)
        
        if fetchAssetResult.count > 0{
            let imageManager = PHImageManager.default()
            for i in 0..<fetchAssetResult.count{
                
                imageManager.requestImage(for: fetchAssetResult.object(at: i), targetSize: CGSize.init(width: 150, height: 150), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                    image, error in
                    self.imageArray.append(image)
                
                })
            
            }
            print(fetchAssetResult.count)
        
        }else{
            collectionView.reloadData()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        let iv = cell.viewWithTag(4) as! UIImageView
        iv.image = imageArray[indexPath.row]
        print("reloaded")
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPhotos()
        self.folderName.text = name
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 2
        return CGSize(width: width, height: width)
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    override func viewDidLayoutSubviews() {
        let last = self.collectionView.numberOfItems(inSection: 0) - 1
        self.collectionView.scrollToItem(at: IndexPath.init(row: last, section: 0), at: .bottom, animated: false)
    }
    
}
