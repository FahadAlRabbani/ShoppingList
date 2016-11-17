//
//  Model+CoreDataProperties.swift
//  StuffList
//
//  Created by Achernar on 23/05/2016.
//  Copyright © 2016 Fahad Al Rabbani. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Model {

    @NSManaged var info: String?
    @NSManaged var item: String?
    @NSManaged var quantity: String?

}
