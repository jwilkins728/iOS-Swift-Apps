//
//  StoreDetailsVC.swift
//  SomeJunk
//
//  Created by Ralph Cachero on 3/24/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit
import CoreData

class StoreDetailsVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: CustomTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
    }
    
    // MARK: Dismiss Keyboard
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return true
    }

    
    @IBAction func savePressed(sender: AnyObject) {
        
        let store = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
        
        if let name = nameField.text {
            store.name = name
        }
        
        ad.saveContext()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
