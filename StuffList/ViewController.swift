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
    //outlets for the textfield
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var moreInfo: UITextField!
    
    var item : String = ""
    var qnt : String = ""
    var info : String = ""
    
    var existingItem : NSManagedObject!
    
    override func viewDidDisappear(animated: Bool) {
        
        //reference to out app delegate
        let appDel : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //reference to context
        let context : NSManagedObjectContext = appDel.managedObjectContext!
        let entity = NSEntityDescription.entityForName("List", inManagedObjectContext: context)
        
        //
        if(itemName.text != "" || quantity.text != "" || moreInfo.text != ""){
            if (existingItem != nil) {
                existingItem.setValue(itemName.text as String, forKey: "item")
                existingItem.setValue(quantity.text as String, forKey: "quantity")
                existingItem.setValue(moreInfo.text as String, forKey: "info")
                print(existingItem)
                print("Update current data")
            } else {
                var newItem = Model(entity: entity!, insertIntoManagedObjectContext: context)
                //map the our properties
                newItem.item = itemName.text
                newItem.quantity = quantity.text
                newItem.info = moreInfo.text
                print(newItem)
                print("New Item Added")
            }
            print("First")
            
        } else if (itemName.text == "" && quantity.text == "" && moreInfo.text == ""){
            if (existingItem != nil){
                print("Delete item")
                context.deleteObject(existingItem)
                var error : NSError? = nil
                do {
                    try context.save()
                } catch var error1 as NSError {
                    error = error1
                    abort()
                }
            }
            print("Second")
        }
        
        do {
            //save the context
            try context.save()
        } catch _ {
        }
        
        //navigate to table view
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

