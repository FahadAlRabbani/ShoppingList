//
//  Model.swift
//  StuffList
//
//  Created by Achernar on 20/04/2015.
//  Copyright (c) 2015 Fahad Al Rabbani. All rights reserved.
//

import UIKit
import CoreData

@objc(model)

class Model: NSManagedObject {
    
    //properties feeding the attritbutes with the entity
    //must match the entity attribute name
    @NSManaged var item: String
    @NSManaged var quantity: String
    @NSManaged var info: String
}
