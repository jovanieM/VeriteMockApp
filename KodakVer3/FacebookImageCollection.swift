//
//  FacebookImageCollection.swift
//  KodakVer3
//
//  Created by anarte on 04/05/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import Photos

class FacebookImageCollection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var name: String!
    var size: CGSize = CGSize(width: 50, height: 50)
    var collection: PHAssetCollection?
    var images = [UIImage]()
    var selectedItems = [IndexPath]()
    var assetCount: Int = 0
    var requestOption: PHImageRequestOptions!
    var phFetchOption: PHFetchOptions!
    var asset: PHFetchResult<PHAsset>!
    var onlyOnce = false
    
    @IBOutlet weak var btnPrint: UIButton!
    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var imageCollection: UICollectionView!{
        didSet{
            imageCollection.delegate = self
            imageCollection.dataSource = self
        }
    }
    
    var isMulti: Bool = false{
        didSet{
            btnPrint.alpha = isMulti ? 1.0 : 0.0
        }
    }
    
    func multi(){
        print("tapped")
        if selectedItems.count > 0{
            for i in 0..<selectedItems.count{
                imageCollection.deselectItem(at: selectedItems[i], animated: false)
                if let cell = imageCollection.cellForItem(at: selectedItems[i]){
                    let label = cell.contentView.viewWithTag(5) as! UILabel
                    label.alpha = 0.0
                    cell.customHighlight()
                }
            }
            selectedItems.removeAll()
        }
        
        isMulti = !isMulti
        if isMulti{
            let title = "cancel"
            
            let attrs: [String: Any] = [NSForegroundColorAttributeName: UIColor.gold, NSFontAttributeName: UIFont(name: "Arial", size: 12)!]
            
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.multi))
            item.setTitleTextAttributes(attrs, for: .normal)
            self.navigationItem.rightBarButtonItem = item
            imageCollection.allowsMultipleSelection = true
        }else{
            let button = UIButton(type: .custom)
            button.addTarget(self, action: #selector(multi), for: .touchUpInside)
            button.setImage(#imageLiteral(resourceName: "multi_print"), for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            let item = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = item
            imageCollection.allowsMultipleSelection = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(multi), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "multi_print"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        let item = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = item
        
        requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .fastFormat
        
        phFetchOption = PHFetchOptions()
        phFetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        phFetchOption.predicate = NSPredicate(format: "mediaType = %d", argumentArray: [PHAssetMediaType.image.rawValue])
        
        asset = PHAsset.fetchAssets(in: collection!, options: phFetchOption)
        assetCount = asset.count
        
        self.folderName.text = name
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCellId", for: indexPath)
        
        DispatchQueue.global(qos: .userInteractive).async {
            let iv = cell.viewWithTag(4) as! UIImageView
            
            PHCachingImageManager.default().requestImage(for: self.asset.object(at: indexPath.item), targetSize: CGSize.init(width: 50, height: 50), contentMode: .aspectFill, options: self.requestOption, resultHandler: {
                image, info in
                DispatchQueue.main.async(execute: { iv.image = image
                })
            })
        }
        
        if cell.isSelected && selectedItems.count != 0 && isMulti{
            let label = cell.contentView.viewWithTag(5) as! UILabel
            label.backgroundColor = .gold
            label.alpha = 1.0
            let num = selectedItems.index(of: indexPath)
            label.text = String(num! + 1)
            cell.customHighlight()
            return cell
        }else{
            let label = cell.contentView.viewWithTag(5) as! UILabel
            label.alpha = 0.0
            cell.customHighlight()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if isMulti{
//            selectedItems.append(indexPath)
//            let cell = collectionView.cellForItem(at: indexPath)
//            cell?.customHighlight()
//            
//            let label = cell?.viewWithTag(5) as! UILabel
//            label.backgroundColor = UIColor.gold
//            label.alpha = 1.0
//            label.text = String(selectedItems.count)
//            
//            let imageView = cell?.contentView.viewWithTag(4) as! UIImageView
//            images.append(imageView.image!)
//        }else{
//            collectionView.deselectItem(at: indexPath, animated: false)
//        }
    }
}
