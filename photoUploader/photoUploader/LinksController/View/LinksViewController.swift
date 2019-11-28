//
//  LinksViewController.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 28.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import UIKit

class LinksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let viewModel =  LinksControllerViewModel()
    private var links: [LinkBox] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        links = viewModel.fetchAllLinks()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension LinksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell", for: indexPath) as? LinkTableViewCell
        cell?.linkLabel.text = links[indexPath.row].link
        return cell ?? UITableViewCell()
    }
}
