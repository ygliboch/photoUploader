//
//  LinkTableViewCell.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 28.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

    @IBOutlet weak var linkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        linkLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func openLink() {
        guard let url = URL(string: linkLabel.text ?? "") else { return }
        UIApplication.shared.open(url)
    }

}
