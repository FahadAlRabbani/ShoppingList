//
//  ViewController.swift
//  StuffList
//
//  Created by Achernar on 20/04/2015.
//  Copyright (c) 2015 Fahad Al Rabbani. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    // Outlets for the textfield
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var moreInfo: UITextField!
    
    var item = ""
    var qnt = ""
    var info = ""
    
    var existingItem : NSManagedObject!
    
    override func viewDidDisappear(animated: Bool) {
        
        // Reference to out app delegate
        let appDel = UIApplication.sharedApplication().delegate // as! AppDelegate
        //reference to context
        let context = appDel.managedObjectContext!
        let entity = NSEntityDescription.entityForName("List", inManagedObjectContext: context)!
        
        // If the user has added text in the field this clause will run,
        // if it has data it will update it else add a new item into database.
        // If text are empty then it will not save and if existing item data are removed
        // it will delete the item from database.
        if(itemName.text != "" || quantity.text != "" || moreInfo.text != ""){
            if (existingItem != nil) {
                existingItem.setValue(itemName.text! as String, forKey: "item")
                existingItem.setValue(quantity.text! as String, forKey: "quantity")
                existingItem.setValue(moreInfo.text! as String, forKey: "info")
                print(existingItem)
                print("Update existingItem data")
            } else {
                let newItem = Model(entity: entity, insertIntoManagedObjectContext: context)
                // Map the our properties
                newItem.item = itemName.text!
                newItem.quantity = quantity.text!
                newItem.info = moreInfo.text!
                print(newItem)
                print("New Item Added")
            }
            print("First")
            
        } else if (itemName.text == "" && quantity.text == "" && moreInfo.text == ""){
            if (existingItem != nil){
                print("Delete item")
                context.deleteObject(existingItem)
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Cannot delete item: \(error)")
                    abort()
                }
            }
            print("Second")
        }
        
        do {
            // Save the context
            try context.save()
        } catch let error as NSError {
            print(error)
            abort()
        }
        
        // Navigate back to table view
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (existingItem != nil) {
            itemName.text = item
            quantity.text = qnt
            moreInfo.text = info
        }
    }
    
}

