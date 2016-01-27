//
//  ListTableViewController.swift
//  StuffList
//
//  Created by Achernar on 20/04/2015.
//  Copyright (c) 2015 Fahad Al Rabbani. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
    
    var myList : Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let appDel : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context : NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "List")
        
        myList = try! context.executeFetchRequest(freq)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID : String  = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(CellID, forIndexPath: indexPath) 

        // Configure the cell...
        if indexPath != 0 {
            let data : NSManagedObject = myList[indexPath.row] as! NSManagedObject
            cell.textLabel?.text = data.valueForKeyPath("item") as? String
            let qnt = data.valueForKeyPath("quantity") as? String
            let info = data.valueForKeyPath("info") as? String
            cell.detailTextLabel?.text = "\(qnt!) item/s - \(info!)"
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDel : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context : NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == .Delete {
           
            context.deleteObject(myList[indexPath.row] as! NSManagedObject)
            myList.removeAtIndex(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            var error : NSError? = nil
            do {
                try context.save()
            } catch let error1 as NSError {
                error = error1
                abort()
            }
        }
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Update" {
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
            let selectedCell: NSManagedObject = myList[indexPath.row] as! NSManagedObject
            let itemViewCont :  ViewController = segue.destinationViewController as! ViewController
            itemViewCont.item = selectedCell.valueForKeyPath("item") as! String
            itemViewCont.qnt = selectedCell.valueForKeyPath("quantity") as! String
            itemViewCont.info = selectedCell.valueForKeyPath("info") as! String
            itemViewCont.existingItem = selectedCell as NSManagedObject
        }
    }
    

}
