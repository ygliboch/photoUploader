//
//  PhotosControllerViewModel.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 26.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import Foundation
import UIKit
import Photos

final class PhotosControllerViewModel {
    let repository = OnlineRepository()
    var imageManager: PHCachingImageManager!
    var successUploadPhoto: ((String, IndexPath)->Void)?
    var failedUploadPhoto: ((IndexPath)->Void)?
    
    func fetchImagesFromGallary() -> PHFetchResult<PHAsset> {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        let assetsFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
        imageManager = PHCachingImageManager()
        imageManager.stopCachingImagesForAllAssets()
        return assetsFetchResult
    }
    
    func setImageFromAsset(asset: PHAsset, imageView: UIImageView) {
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200),
                                  contentMode: PHImageContentMode.aspectFill,
                                  options: nil) { (image, nfo) in
                                    imageView.image = image
        }
    }
    
    func uploadPhoto(asset: PHAsset, indexPath: IndexPath) {
        let photo = getPhotoFromAsset(asset: asset)
        repository.uploadPhoto(data: (photo?.jpegData(compressionQuality: 0.5))!, name: "photoName") { (response, error) in
            guard error == nil else {
                self.failedUploadPhoto?(indexPath)
                return
            }
            if let link = self.getLink(json: response!) {
                self.successUploadPhoto?(link, indexPath)
            } else {
                self.failedUploadPhoto?(indexPath)
            }
        }
    }
    
    private func getLink(json: [String: Any]) -> String? {
        if let data = json["data"] as? [String : Any]{
            return (data["link"] as? String)
        }
        return nil
    }
    
    func saveNewLink(link: String) {
//        guard link != "" else { return }
        let newLinkBox = LinkBox()
        newLinkBox.link = link
        OfflineRepository.instance.saveContext()
    }
    
    func getPhotoFromAsset(asset: PHAsset) -> UIImage? {
        var res : UIImage?
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.resizeMode = .none
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: CGSize(width: 1000, height: 1000) , contentMode: .aspectFill,
                                              options: options, resultHandler: {
                                                (image, _) in
                                                res = image
        })
        return res
    }
}
