//
//  PhotoCollectionCell.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 26.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import UIKit
import Photos

class PhotoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    lazy var loadingSpinner:  UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .white
        return spinner
    }()
    
    lazy var backLoadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
    }
    
    func setupLoadingView() {
        addLoadingBackgroundView()
        addLoadingSpinner()
    }
    
    private func addLoadingBackgroundView() {
        self.addSubview(backLoadingView)
        backLoadingView.translatesAutoresizingMaskIntoConstraints = false
        backLoadingView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        backLoadingView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        backLoadingView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        backLoadingView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func addLoadingSpinner() {
        loadingSpinner.startAnimating()
        self.addSubview(loadingSpinner)
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        loadingSpinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
    func removeLoadingView() {
        loadingSpinner.removeFromSuperview()
        backLoadingView.removeFromSuperview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
