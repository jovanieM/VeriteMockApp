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
    
   
    
    var image : UIImage!
    var assetCount : Int = 0
    var asset : PHFetchResult<PHAsset>!
    var phFetchOption : PHFetchOptions!
    var requestOption : PHImageRequestOptions!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        
        }
        
    }
    
    var collections : PHAssetCollection?
    var count : Int!
    
    var imageArray = [UIImage!]()
    
    
//    func loadPhotos(){
//    
//        let requestOptions = PHImageRequestOptions()
//        requestOptions.isSynchronous = true
//        requestOptions.deliveryMode = .highQualityFormat
//        
//        let phFetchOptions = PHFetchOptions()
//        phFetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
//        phFetchOptions.predicate = NSPredicate(format: "mediaType = %d", argumentArray: [PHAssetMediaType.image.rawValue])
//        
//        //let collectionRes = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
//        
//        if let _ = collections?.localizedTitle{
//            
//            let fetchAssetResult = PHAsset.fetchAssets(in: collections!, options: phFetchOptions)
//            
//            if fetchAssetResult.count > 0{
//                let imageManager = PHImageManager.default()
//                
//                for i in 0..<fetchAssetResult.count{
//                    
//                    imageManager.requestImage(for: fetchAssetResult.object(at: i), targetSize: CGSize.init(width: 150, height: 150), contentMode: .aspectFill, options: requestOptions, resultHandler: {
//                        image, error in
//                        
//                        self.imageArray.append(image)
//
//                        
//                        
//                    })
//                    
//                }
//                print(fetchAssetResult.count)
//                
//            }else{
//                collectionView.reloadData()
//            }
//
//        }
//        
//        
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return assetCount
        //return imageLoader.cameraRoll.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        let iv = cell.viewWithTag(4) as! UIImageView
       
        
        PHCachingImageManager.default().requestImage(for: self.asset.object(at: indexPath.item), targetSize: CGSize.init(width: 100, height: 100), contentMode: .aspectFill, options: self.requestOption, resultHandler: {
                image, info in
            
                iv.image = image
            
            
        })
        
//iv.image = image
        
        //iv.image = imageArray[indexPath.row]
        //iv.image = imageLoader.cameraRoll[indexPath.row]
       
        
        return cell
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadPhotos()
        //self.imageLoader = ImageLoader()
        
        requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .fastFormat
        
        phFetchOption = PHFetchOptions()
        phFetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        phFetchOption.predicate = NSPredicate(format: "mediaType = %d", argumentArray: [PHAssetMediaType.image.rawValue])
        
        asset = PHAsset.fetchAssets(in: collections!, options: phFetchOption)
        assetCount = asset.count
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FlickPrintViewController
        let reqOptions = PHImageRequestOptions()
        reqOptions.isSynchronous = true
        reqOptions.deliveryMode = .highQualityFormat
        PHCachingImageManager.default().requestImageData(for: asset.object(at: collectionView.indexPathsForSelectedItems![0].item), options: reqOptions, resultHandler: {
            imageData, dataUTI, orientation, info in
        
                vc.image = UIImage(data: imageData!)
            
        })
            //imageArray[(collectionView.indexPathsForSelectedItems?[0].row)!]
    }
    
}
