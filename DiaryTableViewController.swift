//
//  DiaryTableViewController.swift
//  DiaryApp
//
//  Created by James O'Connor on 7/20/16.
//  Copyright © 2016 James O'Connor. All rights reserved.
//

import UIKit
import CoreData

class DiaryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, AddEntryDelegate {

    var managedObjectContext :NSManagedObjectContext!
    var fetchedResultsController :NSFetchedResultsController!
    var diaryEntry :DiaryEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest(entityName: "DiaryEntry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "entryTitle", ascending:true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchedResultsController.delegate = self
        
        try! self.fetchedResultsController.performFetch()

        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue:UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddEntrySegue" {
            
            guard let navigationController = segue.destinationViewController as? UINavigationController else {fatalError("Navigation Controller Not Found")}
            
            guard let addEntryViewController = navigationController.viewControllers.first as? AddEntryViewController else {fatalError("Add Entry View Controller Not Found")}
            
            addEntryViewController.delegate = self
            
        }
        //guard let indexPath = self.tableView.indexPathForSelectedRow else {fatalError("Invalid IndexPath")}
      
        
        //let diaryEntry = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        
        //guard let addEntryViewController = segue.destinationViewController as? AddEntryViewController else {fatalError("Add Entry View Controller Not Found")}
        
        //addEntryViewController.diaryEntry = diaryEntry
        
        //addEntryViewController.managedObjectContext = self.managedObjectContext
        
        
    }
    
    func addEntry(newEntry: String) {
        
        print(newEntry)
        
        guard let diaryEntry = NSEntityDescription.insertNewObjectForEntityForName("DiaryEntry", inManagedObjectContext: self.managedObjectContext) as? DiaryEntry else {fatalError("DiaryEntry Does Not Exist")}
        
        diaryEntry.entryTitle = newEntry
        
        try! self.managedObjectContext.save()
        
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject:AnyObject, atIndexPath indexPath:NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch(type) {
            
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            
        case .Delete:
            break
            
        case .Update:
            break
            
        case .Move:
            break
            
            
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = self.fetchedResultsController.sections else {fatalError("Error Getting Sections")}
        
        return sections[section].numberOfObjects
        
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let diaryEntry = self.fetchedResultsController.objectAtIndexPath(indexPath)
        
        cell.textLabel?.text = diaryEntry.entryTitle

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            let entry = self.fetchedResultsController.objectAtIndexPath(indexPath) as! DiaryEntry
            
            self.managedObjectContext.deleteObject(entry)
            
            try! self.managedObjectContext.save()
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
