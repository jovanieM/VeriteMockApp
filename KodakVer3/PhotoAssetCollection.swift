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
    
    
    
    var folderInfoArray = (image : [UIImage](), name : [String](), contents : [String]())
    var phFetchResults = [PHFetchResult<PHAssetCollection>!]()
    //var phAsset : PHFetchResult<PHAsset>!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grabPhoto()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
  
    
    func grabPhoto(){
        let imgManager = PHImageManager.default()
        
        let requestOp = PHImageRequestOptions()
        requestOp.isSynchronous = true
        requestOp.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", argumentArray: [PHAssetMediaType.image.rawValue])
        
        
        // fetchResults from folder locations
        phFetchResults.append(PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil))
        phFetchResults.append(PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumCloudShared, options: nil))
        phFetchResults.append(PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumMyPhotoStream, options: nil))
        
        if phFetchResults.count > 0{
            print(phFetchResults.count)
        
        for i in 0..<phFetchResults.count{
            let phAsset = PHAsset.fetchAssets(in: phFetchResults[i].firstObject!, options: fetchOptions)
            
            imgManager.requestImage(for: phAsset.firstObject!, targetSize: CGSize.init(width: 150, height: 150), contentMode: .aspectFill, options: requestOp, resultHandler: {
                image, error in
                self.folderInfoArray.image.append(image!)
                
            })
            self.folderInfoArray.name.append(phFetchResults[i].firstObject!.localizedTitle!)
            let temp: String = String(phAsset.count)
            self.folderInfoArray.contents.append(temp)
        }
        }else{
            print("no photo")
            self.tableView.reloadData()
        }
        
        

        
    }
    

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return phFetchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let img = cell.viewWithTag(2) as! UIImageView
                // Configure the cell...
        //img.image = imageArray[indexPath.row]
        img.image = folderInfoArray.image[indexPath.row]
        let title = cell.viewWithTag(1) as! UILabel
        //title.text = phFetchResults[indexPath.row].firstObject!.localizedTitle
        //title.text = "\(phFetchResults[indexPath.row].count)"
        title.text = "\(folderInfoArray.name[indexPath.row]) (\(folderInfoArray.contents[indexPath.row]))"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ImageCollectionVC
        vc.name = folderInfoArray.name[(tableView.indexPathForSelectedRow?.row)!]
        vc.collections = phFetchResults[(tableView.indexPathForSelectedRow?.row)!]
    }
    
 


}
