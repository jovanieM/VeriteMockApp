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
    
    
    var folderInfoArray = (image : [UIImage?](), name : [String](), contents : [String]())
    //var phFetchResults = [PHFetchResult<PHAssetCollection>]()
    var phAssetCollections = [PHAssetCollection]()
    var imagesArray = [UIImage]()
    var imageCollections = [[UIImage]]()
    var phAsset : PHFetchResult<PHAsset>!
    var authStatus : Bool!
    //var il :ImageLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if PHPhotoLibrary.authorizationStatus() == .denied{
            popUpInstruction()
        }
        if PHPhotoLibrary.authorizationStatus() == .notDetermined{
            requestAccess()
        }
        if PHPhotoLibrary.authorizationStatus() == .authorized{
            grabPhoto()
        }
        
    }
    @IBAction func unwindAfterPrintingDone(segue: UIStoryboardSegue){
        
    }
    func requestAccess(){
        
        
        PHPhotoLibrary.requestAuthorization { (status : PHAuthorizationStatus) in
            switch status{
            case .authorized:
                
                DispatchQueue.main.async(execute: { 
                    self.grabPhoto()

                })
                
            case .denied:
                return
            case .notDetermined:
                return
            case .restricted:
                return
            }
           
        }
        
    }
    
    func popUpInstruction(){
        
        let alert = UIAlertController(title: "Cannot access to Photos", message: "Open the Settings > Privacy > Photos and Turn ON Kodak Verite", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {(ok) in
            self.perform(#selector(self.dismissVC))
        }
        alert.addAction(okAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
    
    }
    func dismissVC(){
        
        let nav = self.navigationController as! MyNavController
        nav.pop()
    }
  
    
    func grabPhoto(){
    
        let imgManager = PHImageManager.default()
        
        let phFetchOption = PHFetchOptions()
        phFetchOption.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: true)]
        
        let requestOp = PHImageRequestOptions()
        requestOp.isSynchronous = true
        requestOp.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", argumentArray: [PHAssetMediaType.image.rawValue])
        
        let res1 = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: phFetchOption)
        if let cam = res1.firstObject{
            phAssetCollections.append(cam)
        }

        let res4 = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .smartAlbumUserLibrary, options: phFetchOption)
       
        for i in 0..<res4.count{
            
            if res4[i].estimatedAssetCount != 0{
                phAssetCollections.append(res4[i])
            
            }
      
        }

        if phAssetCollections.count > 0{
            
            
            for i in 0..<phAssetCollections.count{
             
                
                let phAsset = PHAsset.fetchAssets(in: phAssetCollections[i], options: fetchOptions)
                
               
                    imgManager.requestImage(for: phAsset.object(at: 0), targetSize: CGSize.init(width: 150, height: 150), contentMode: .aspectFill, options: requestOp, resultHandler: {
                        image, info in
             
                        self.folderInfoArray.image.append(image)
                        
                        
                    })
        
                self.folderInfoArray.name.append(phAssetCollections[i].localizedTitle!)
                let temp: String = String(phAsset.count)
                self.folderInfoArray.contents.append(temp)
                self.tableView.reloadData()
                
            }
        }else{
            print("no photo")
            
            //self.tableView.reloadData()
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
        
       
        let img = cell.contentView.viewWithTag(2) as! UIImageView
        img.contentMode = .scaleAspectFill
        

        img.image = folderInfoArray.image[indexPath.row]
        let title = cell.contentView.viewWithTag(1) as! UILabel
    
        title.text = "\(folderInfoArray.name[indexPath.row]) (\(folderInfoArray.contents[indexPath.row]))"
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: title.frame.minX, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ImageCollectionVC
        vc.name = folderInfoArray.name[(tableView.indexPathForSelectedRow?.row)!]

        vc.collections = phAssetCollections[(tableView.indexPathForSelectedRow?.row)!]
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
       self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    
    
    
    
}
