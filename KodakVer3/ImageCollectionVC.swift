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
   
    
    var image : UIImage!
    var assetCount : Int = 0
    var asset : PHFetchResult<PHAsset>!
    var phFetchOption : PHFetchOptions!
    var requestOption : PHImageRequestOptions!
    var images = [UIImage]()
    var onlyOnce = false
    var selectedItems = [IndexPath]()
   
    
    @IBOutlet weak var printButton: UIButton!
 
    @IBAction func printImage(_ sender: UIButton) {
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            
       
            
        }
        
    }
    
    var collections : PHAssetCollection?
   
    
    var isMulti : Bool = false{
        didSet{
             printButton.alpha = isMulti ?  1.0 :  0.0
        }
    
    }
    
  
    
    func multi(){
        print("tapped")
        isMulti = !isMulti
        if isMulti{
            let item = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(self.multi))
            self.navigationItem.rightBarButtonItem = item
            //collectionView.allowsSelection = false
            collectionView.allowsMultipleSelection = true
            
        }else{
            let button = UIButton(type: .custom)
            button.addTarget(self, action: #selector(multi), for: .touchUpInside)
            button.setImage(#imageLiteral(resourceName: "multi_print"), for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            let item = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = item
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //let item = MultiPrintButton()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return assetCount
        //return imageLoader.cameraRoll.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCellId", for: indexPath) as! CustomCollectionViewCell
      
        if isMulti{
            for i in 0..<selectedItems.count{
                
                if selectedItems[i] == indexPath{
                    
                    collectionView.cellForItem(at: indexPath)?.isSelected = true
                    cell.label.text = "\(i + 1)"
                    
                    
                    print("item selected \(indexPath.item)")
                }else{
                    collectionView.cellForItem(at: indexPath)?.isSelected = false
                    
                }
                
                
        }
        
        }
        DispatchQueue.global(qos: .userInteractive).async {
            let iv = cell.viewWithTag(4) as! UIImageView
            
            PHCachingImageManager.default().requestImage(for: self.asset.object(at: indexPath.item), targetSize: CGSize.init(width: 50, height: 50), contentMode: .aspectFill, options: self.requestOption, resultHandler: {
                image, info in
                DispatchQueue.main.async(execute: {
                    iv.image = image!
                    
                })
            })
            
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 2
        return CGSize(width: width, height: width)
    
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if isMulti{
            selectedItems.append(indexPath)
            let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
            cell.isSelected = true
            cell.label.text = "\(selectedItems.count)"
        }
        
        
        
//        cell.layer.borderWidth = 2.0
//        cell.layer.borderColor = UIColor.yellow.cgColor
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //selectedItems
        if isMulti{
            let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
            cell.isSelected = false
            selectedItems.remove(at: selectedItems.index(of: indexPath)!)
            for i in 0..<selectedItems.count{
                print("remaining \(selectedItems.count)")
                
                let cell2 = collectionView.cellForItem(at: selectedItems[i]) as? CustomCollectionViewCell
                collectionView.cellForItem(at: selectedItems[i])?.isSelected = true
                cell2?.label.text = "\(i + 1)"
                cell2?.contentView.setNeedsDisplay()
                
                
                
                print("item selected \(indexPath.item)")
                
                
                
            }
        }
    

        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("called once")
        if !onlyOnce{
            let last = self.collectionView.numberOfItems(inSection: 0) - 1
            self.collectionView.scrollToItem(at: IndexPath.init(row: last, section: 0), at: .bottom, animated: false)
            onlyOnce = true
        }
        
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
                }
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !isMulti
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.collectionView?.removeObserver(self, forKeyPath: "contentSize")
//    }

    
    
}
