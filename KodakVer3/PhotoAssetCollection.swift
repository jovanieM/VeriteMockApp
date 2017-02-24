//
//  PhotoAssetCollection.swift
//  KodakVer3
//
//  Created by jmolas on 2/15/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import Photos

class PhotoAssetCollection: UITableViewController {
    
    
    var folderInfoArray = (image : [UIImage!](), name : [String](), contents : [String]())
    //var phFetchResults = [PHFetchResult<PHAssetCollection>]()
    var phAssetCollections = [PHAssetCollection]()
    var imagesArray = [UIImage]()
    var imageCollections = [[UIImage]]()
    var phAsset : PHFetchResult<PHAsset>!
    var authStatus : Bool!
    //var il :ImageLoader!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        grabPhoto()
     
        
    }
  
    
    func grabPhoto(){
    
        let imgManager = PHImageManager.default()
        
        let requestOp = PHImageRequestOptions()
        requestOp.isSynchronous = true
        requestOp.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", argumentArray: [PHAssetMediaType.image.rawValue])
        
        let res1 = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        if let cam = res1.firstObject{
            phAssetCollections.append(cam)
        }
        let res2 = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumCloudShared, options: nil)
        if let cloud = res2.firstObject{
            phAssetCollections.append(cloud)
        }
        let res3 = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumMyPhotoStream, options: nil)
        if let stream = res3.firstObject{
            phAssetCollections.append(stream)
        }
 
        if phAssetCollections.count > 0{
            print(phAssetCollections.count)
            
            
            for i in 0..<phAssetCollections.count{
                
                print(phAssetCollections.count)
               
                
                
                let phAsset = PHAsset.fetchAssets(in: phAssetCollections[i], options: fetchOptions)
                
               
                    imgManager.requestImage(for: phAsset.object(at: 0), targetSize: CGSize.init(width: 150, height: 150), contentMode: .aspectFill, options: requestOp, resultHandler: {
                        image, info in
                        
                        //self.imagesArray.append(image!)
                        
                        
                        self.folderInfoArray.image.append(image)
                        
                        
                    })
        
                self.folderInfoArray.name.append(phAssetCollections[i].localizedTitle!)
                let temp: String = String(phAsset.count)
                self.folderInfoArray.contents.append(temp)
                self.tableView.reloadData()
                
            }
        }else{
            print("no photo")
            
            self.tableView.reloadData()
        }
        
        
        
        
    }
   
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return phAssetCollections.count
        //return il.imageData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let img = cell.viewWithTag(2) as! UIImageView
        // Configure the cell...
//        img.image = il.imageData[indexPath.row][0]
        img.image = folderInfoArray.image[indexPath.row]
        let title = cell.contentView.viewWithTag(1) as! UILabel
        //title.text = phFetchResults[indexPath.row].firstObject!.localizedTitle
        //title.text = "\(phFetchResults[indexPath.row].count)"
        title.text = "\(folderInfoArray.name[indexPath.row]) (\(folderInfoArray.contents[indexPath.row]))"
//        title.text = "\(il.folderInfoArray.name[indexPath.row]) (\(il.folderInfoArray.contents[indexPath.row]))"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ImageCollectionVC
        vc.name = folderInfoArray.name[(tableView.indexPathForSelectedRow?.row)!]
//        vc.imageArray = il.imageData[(tableView.indexPathForSelectedRow?.row)!]
        vc.collections = phAssetCollections[(tableView.indexPathForSelectedRow?.row)!]
        //(tableView.indexPathForSelectedRow?.row)!
    }
    
    
    
    
}
