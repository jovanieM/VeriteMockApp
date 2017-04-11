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
    let size: CGSize = CGSize(width: 50, height: 50)
    var assetCount : Int = 0
    var asset : PHFetchResult<PHAsset>!
    var phFetchOption : PHFetchOptions!
    var requestOption : PHImageRequestOptions!
    var onlyOnce = false
    var selectedItems = [IndexPath]()
    var collections : PHAssetCollection?
    @IBOutlet weak var dimmerView: UIView!
    @IBOutlet weak var printButton: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
        
    }

    var isMulti : Bool = false{
        didSet{
            printButton.alpha = isMulti ?  1.0 :  0.0
        }
        
    }
    
    var images = [UIImage]()
    
    func multi(){
        print("tapped")
        if selectedItems.count > 0{
            for i in 0..<selectedItems.count{
                
                collectionView.deselectItem(at: selectedItems[i], animated: false)
                if let cell = collectionView.cellForItem(at: selectedItems[i]){
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
            
            let attrs: [String: Any] = [NSForegroundColorAttributeName : UIColor.gold, NSFontAttributeName : UIFont(name : "Arial", size : 12)!]
            
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.multi))
            item.setTitleTextAttributes(attrs, for: .normal)
            self.navigationItem.rightBarButtonItem = item
            collectionView.allowsMultipleSelection = true
            
        }else{
            let button = UIButton(type: .custom)
            button.addTarget(self, action: #selector(multi), for: .touchUpInside)
            button.setImage(#imageLiteral(resourceName: "multi_print"), for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            let item = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = item
            collectionView.allowsMultipleSelection = false
            
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
        
        asset = PHAsset.fetchAssets(in: collections!, options: phFetchOption)
        assetCount = asset.count
        
        
        self.folderName.text = name
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        if !onlyOnce{
            
            let last = self.collectionView.numberOfItems(inSection: 0) - 1
            
            self.collectionView.scrollToItem(at: IndexPath.init(row: last, section: 0), at: .bottom, animated: false)
            
            onlyOnce = true
        }
        
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
                DispatchQueue.main.async(execute: {
                    iv.image = image
                    
                })
            })
            
        }
        
        if isMulti && selectedItems.count != 0{
            
            for i in 0..<selectedItems.count{
                
                if cell.isSelected{
                    
                    if selectedItems[i] == indexPath{
                        
                        let label = cell.contentView.viewWithTag(5) as! UILabel
                        label.backgroundColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
                        
                        label.alpha = 1.0
                        
                        label.text = String(i + 1)
                        
                        cell.customHighlight()
                        
                    }
                    
                }else{
                    
                    let label = cell.contentView.viewWithTag(5) as! UILabel
                    
                    label.alpha = 0.0
                    
                    cell.customHighlight()
                }
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print(indexPath.row)
        
        if isMulti{
            
            selectedItems.append(indexPath)
            
            let cell = collectionView.cellForItem(at: indexPath)
            
            cell?.customHighlight()
            
            let label = cell?.viewWithTag(5) as! UILabel
            label.backgroundColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
            
            label.alpha = 1.0
            
            label.text = String(selectedItems.count)
            
            
            let imageView = cell?.contentView.viewWithTag(4) as! UIImageView
            
            images.append(imageView.image!)
            
        }else{
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if isMulti {
            if selectedItems.count > 0 {
                let arrayIndex = selectedItems.index(of: indexPath)!
                selectedItems.remove(at: arrayIndex)
                images.remove(at: arrayIndex)
                
                let label = collectionView.cellForItem(at: indexPath)!.viewWithTag(5) as! UILabel
                
                
                label.alpha = 0.0
                
                collectionView.cellForItem(at: indexPath)?.customHighlight()
                
                
                for i in 0..<selectedItems.count {
                    let cell = collectionView.cellForItem(at: selectedItems[i])!
 //                   let iv = cell.contentView.viewWithTag(4) as! UIImageView
                   
                    
                    cell.customHighlight()
                    
                    let label = cell.contentView.viewWithTag(5) as! UILabel
                    
                    label.text = String(i + 1)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 2
        
        return CGSize(width: width, height: width)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "singlePrint"{
            
            let vc = segue.destination as! FlickPrintViewController
            
            let reqOptions = PHImageRequestOptions()
            
            reqOptions.isSynchronous = true
            
            reqOptions.deliveryMode = .highQualityFormat
            
            PHCachingImageManager.default().requestImageData(for: asset.object(at: collectionView.indexPathsForSelectedItems![0].item), options: reqOptions, resultHandler:{
                    imageData, dataUTI, orientation, info in
                
                
                    
                    vc.image = UIImage(data: imageData!)
            })
        }
        
        if segue.identifier == "multiPrint" && selectedItems.count != 0{
            
            dimmerView.alpha = 0.5
            
            
            
//            for index in 0..<selectedItems.count{
//                
//                let cell = collectionView.cellForItem(at: selectedItems[index])
//                
//                let imageView = cell?.contentView.viewWithTag(4) as! UIImageView
//                
//                images.append(imageView.image!)
//            }
            
            let vc2 = segue.destination as! PrintMultiViewController
            vc2.onDone = {
                self.dimmerView.alpha = 0.0
            }
            
            vc2.onPrint = {
                self.dimmerView.alpha = 0.0
                let sb = UIStoryboard(name: "PrintQueueStoryboard", bundle: nil)
                let vc = sb.instantiateInitialViewController() as! PrintQueueViewController
                
                for i in 0..<self.images.count{
                    let pd = PrintData()
                    pd.thumbNail = self.images[i]
                    vc.printData.append(pd)
                }
                
                self.show(vc, sender: self)
                
            }
            vc2.onSettings = {
                
                self.dimmerView.alpha = 0.0
                let sb = UIStoryboard(name: "PhotoPrintSettingsStoryboard", bundle: nil)
                let vc = sb.instantiateInitialViewController() as! PrintPhotoVC
                self.show(vc, sender: self)
            
            }
            
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool){
      self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{
        if identifier == "multiPrint" && selectedItems.count != 0{
            return true
        }
        
        if identifier == "singlePrint"{
            
            if isMulti{
                return false
            }else{
                return true
            }
        }
        return !isMulti
    }
    
}

extension UICollectionViewCell{
    func customHighlight(){
        
        if isSelected{
            self.layer.borderWidth = 3.0
            
            self.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0).cgColor
        }else{
            self.layer.borderWidth = 0.0
        }
    }
}
