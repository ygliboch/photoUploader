//
//  LinkBox+CoreDataProperties.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 28.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//
//

import Foundation
import CoreData


extension LinkBox {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LinkBox> {
        return NSFetchRequest<LinkBox>(entityName: "LinkBox")
    }

    @NSManaged public var link: String?

}
