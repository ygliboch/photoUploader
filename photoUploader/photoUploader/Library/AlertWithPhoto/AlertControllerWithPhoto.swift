//
//  AlertControllerWithPhoto.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 27.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import UIKit

class AlertControllerWithPhoto: UIAlertController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        configureTitleLabel()
        configureSubtitleLabel()
        addAction()
    }
    
    private func configureImageView() {
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func configureTitleLabel() {
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func configureSubtitleLabel() {
        self.view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
    }
    
    private func addAction() {
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        self.addAction(action)
    }

}
