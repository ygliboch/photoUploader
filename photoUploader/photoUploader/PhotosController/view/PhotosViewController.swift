//
//  PhotosViewController.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 26.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import UIKit
import Photos

class PhotosViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var allUserPhotos: PHFetchResult<PHAsset>!
    var photosInUpload: [IndexPath] = []
    
    private let viewModel = PhotosControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        allUserPhotos = viewModel.fetchImagesFromGallary()
        layoutCollectionView()
        collectionView.allowsSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupViewModel() {
        viewModel.successUploadPhoto = { (link, indexPath) in
            self.viewModel.saveNewLink(link: link)
            self.configureUploadingCell(indexPath: indexPath)
        }
        viewModel.failedUploadPhoto = { (indexPath) in
            self.configureUploadingCell(indexPath: indexPath)
            self.showAlert(indexPath: indexPath)
        }
    }
    
    private func configureUploadingCell(indexPath: IndexPath) {
        let index = photosInUpload.lastIndex(where: { (item) -> Bool in
            return item == indexPath
        })
        if index != nil {
            photosInUpload.remove(at: index!)
        }
        (collectionView.cellForItem(at: indexPath) as? PhotoCollectionCell)?.removeLoadingView()
    }
    
    private func showAlert(indexPath: IndexPath) {
        let alert = AlertControllerWithPhoto(title: "", message: "", preferredStyle: .alert)
        alert.titleLabel.text = "Failed to upload photo"
        alert.subtitleLabel.text = "Please try again"
        alert.imageView.image = viewModel.getPhotoFromAsset(asset: allUserPhotos[indexPath.row])
        present(alert, animated: true, completion: nil)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        print("rotate")
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func layoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let length = view.frame.width / 3
        layout.itemSize = CGSize(width: length, height: length)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allUserPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as? PhotoCollectionCell
        let asset = allUserPhotos[indexPath.row]
        viewModel.setImageFromAsset(asset: asset, imageView: cell?.imageView ?? UIImageView())
        if photosInUpload.contains(indexPath) {
            cell?.setupLoadingView()
        }
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photosInUpload.append(indexPath)
        (collectionView.cellForItem(at: indexPath) as? PhotoCollectionCell)?.setupLoadingView()
        viewModel.uploadPhoto(asset: allUserPhotos[indexPath.row], indexPath: indexPath)
    }
}
