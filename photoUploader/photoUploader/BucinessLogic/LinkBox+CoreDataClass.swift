//
//  LinkBox+CoreDataClass.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 28.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//
//

import Foundation
import CoreData

@objc(LinkBox)
public class LinkBox: NSManagedObject {

    convenience init() {
        let entity = NSEntityDescription.entity(forEntityName: "LinkBox", in: OfflineRepository.instance.managedObjectContext)
    
        self.init(entity: entity!, insertInto: OfflineRepository.instance.managedObjectContext)
     }
}
