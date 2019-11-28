//
//  LinksControllerViewModel.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 28.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import Foundation
import CoreData

final class LinksControllerViewModel {
    func fetchAllLinks() -> [LinkBox] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LinkBox")
        do {
            let results = try OfflineRepository.instance.persistentContainer.viewContext.fetch(fetchRequest)
            return results as? [LinkBox] ?? []
        } catch {
            return []
        }
    }
}
