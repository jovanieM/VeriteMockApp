//
//  FacebookPhotoAssetCollection.swift
//  KodakVer3
//
//  Created by anarte on 04/05/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import Photos

class FacebookPhotoAssetCollection: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
//  var timelinePhotos: [UIImage] = [UIImage(named: "airprint_setting.png")!, UIImage(named: "airprint_setting.png")! ]
//  var list: [String] = ["List 1", "List 2", "List 3"]
  
  var folderInfoArray = (image: [UIImage!](), name:[String](), contents: [String]())
  var phAssetCollections = [PHAssetCollection]()
  
  @IBOutlet weak var tableViewFacebook: UITableView!
  override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    grabPhoto()
    
    tableViewFacebook.delegate = self
    tableViewFacebook.dataSource = self
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
        imgManager.requestImage(for: phAsset.object(at: 0), targetSize: CGSize.init(width: 150, height: 150), contentMode: .aspectFill, options: requestOp, resultHandler: { image, info in
          
          self.folderInfoArray.image.append(image)
        })
        
        self.folderInfoArray.name.append(phAssetCollections[i].localizedTitle!)
        let temp: String = String(phAsset.count)
        self.folderInfoArray.contents.append(temp)
        self.tableViewFacebook.reloadData()
      }
    }else{
    
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return phAssetCollections.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    let vc = segue.destination as! FacebookImageCollection
    vc.name = folderInfoArray.name[(tableViewFacebook.indexPathForSelectedRow?.row)!]
    
    vc.collection = phAssetCollections[(tableViewFacebook.indexPathForSelectedRow?.row)!]
    tableViewFacebook.deselectRow(at: tableViewFacebook.indexPathForSelectedRow!, animated: false)
  }
  
}
