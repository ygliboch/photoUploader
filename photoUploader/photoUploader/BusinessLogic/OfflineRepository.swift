//
//  OfflineRepository.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 26.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class OfflineRepository {
    
    static let instance = OfflineRepository()
    
    private init () {}
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "photoUploader")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
