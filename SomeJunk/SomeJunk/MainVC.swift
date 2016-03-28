//
//  MainVC.swift
//  SomeJunk
//
//  Created by Ralph Cachero on 3/20/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var fetchedResultsController: NSFetchedResultsController!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        attemptFetch()
        
//        if let objs = fetchedResultsController.fetchedObjects?.count {
//            if objs == 0 {
//                generateTestData()
//            }
//        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        attemptFetch()
        tableView.reloadData()
    }
    
    
    // MARK: TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections {
            return sections[section].name
        }
        return "Unassigned Items"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let objs = fetchedResultsController.fetchedObjects where objs.count > 0 {
            
                let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Item
                performSegueWithIdentifier("ItemDetailsVC", sender: item)
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        
        switch(type) {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break
        case .Update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemCell
                configureCell(cell, indexPath: indexPath)
            }
            break
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch(type) {
        case .Insert:
            let sectionIndexSet = NSIndexSet(index: sectionIndex)
            tableView.insertSections(sectionIndexSet, withRowAnimation: .Fade)
        case .Delete:
            let sectionIndexSet = NSIndexSet(index: sectionIndex)
            tableView.deleteSections(sectionIndexSet, withRowAnimation: .Fade)
        default:
            ""
        }
        
    }
    
    func controller(controller: NSFetchedResultsController, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    // MARK: Fetch data from CoreData and Configure Cell
    
    func attemptFetch() {
        setFetchedResults()
        
        do {
          try self.fetchedResultsController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error), \(error.userInfo)")
        }
    }
    
    func setFetchedResults() {
        let section: String? = segment.selectedSegmentIndex == 1 ? "store.name" : nil
        
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        
        
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: section, cacheName: nil)
        
        controller.delegate = self
        fetchedResultsController = controller
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        if let item = fetchedResultsController.objectAtIndexPath(indexPath) as? Item {
            cell.configureCell(item)
        }
    }
    
    
    // MARK: Test Data
    
    func generateTestData() {
        
        let image = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: ad.managedObjectContext) as! Image
        image.setItemImage(UIImage(named: "filler")!)
        
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
        item.title = "Cool LEGO Set"
        item.price = 45.99
        item.details = "This is a super cool Star Wars LEGO set with 1000 pieces"
        item.image = image
        
        let item2 = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
        item2.title = "He-Man vs Skeletor"
        item2.price = 89.99
        item2.details = "Skeletor is the man! (kind of)"
        item2.image = image
        
        let item3 = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
        item3.title = "Audi R8"
        item3.price = 108000
        item3.details = "I'm probably going to die in this car. But I'll buy it anyway"
        
        ad.saveContext()
    }
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ItemDetailsVC" {
            let vc = segue.destinationViewController as! ItemDetailsVC
            vc.itemToEdit = sender as? Item
        }
    }
    
    // MARK: IBActions
    
    @IBAction func segmentedControlActionChanged(sender: AnyObject) {
        attemptFetch()
        tableView.reloadData()
    }

}

