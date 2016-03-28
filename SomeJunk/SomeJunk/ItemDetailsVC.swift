//
//  ItemDetailsVC.swift
//  SomeJunk
//
//  Created by Ralph Cachero on 3/22/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var itemImage: UIImageView!

    var imagePicker: UIImagePickerController!
    var stores = [Store]()
    var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        titleField.delegate = self
        priceField.delegate = self
        detailsField.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        
        getStores()
        
//        if stores.count == 0 {
//            generateTestStores()
//        }
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        getStores()
        storePicker.reloadAllComponents()
    }
    
    // MARK: Dismiss Keyboard
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        priceField.resignFirstResponder()
        detailsField.resignFirstResponder()
        return true
    }
    
    // MARK: Load Data
    
    func loadItemData() {
        if let item = itemToEdit {
            
            if let title = item.title {
                titleField.text = title
            }
            
            if let price = item.price {
                priceField.text = "\(price)"
            }
            
            if let details = item.details {
                detailsField.text = details
            }
            
            if let store = item.store {
                
                var index = 0
                repeat {
                    let s = stores[index]
                    
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
            
            if let image = item.image?.getItemImg() {
                itemImage.image = image
            }
        }
    }
    
    func getStores() {
        let fetchRequest = NSFetchRequest(entityName: "Store")
        
        do {
            self.stores = try ad.managedObjectContext.executeFetchRequest(fetchRequest) as! [Store]
            self.storePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print("\(error), \(error.userInfo)")
        }
    }
    
    // MARK: Image Picker View
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        itemImage.image = image
    }
    
    
    // MARK: Store Picker View

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
    
    // MARK: Test Data
    
    func generateTestStores() {
        let store1 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
        store1.name = "Amazon"
        
        let store2 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
        store2.name = "Walmart"
        
        let store3 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
        store3.name = "Best Buy"
        
        ad.saveContext() 
    }
    
    
    
    // MARK: IBActions
    @IBAction func addImage(sender: UIButton) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    

    @IBAction func savePressed(sender: AnyObject) {
        
        var item: Item!
        var image: Image!
        
        if itemToEdit == nil {
            item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
            image = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: ad.managedObjectContext) as! Image
            item.image = image
        } else {
            item = itemToEdit
        }
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            let priceStr = NSString(string: price)
            let priceDbl = priceStr.doubleValue
            item.price = NSNumber(double: priceDbl)
        }
        
        if let details = detailsField.text {
            item.details = details
        }
        
        item.store = stores[storePicker.selectedRowInComponent(0)]
        
        if let descImage = itemImage.image {
            item.image?.setItemImage(descImage)
        }
        
        ad.saveContext()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func deletePressed(sender: AnyObject) {
        
        if itemToEdit != nil {
            ad.managedObjectContext.deleteObject(itemToEdit!)
            ad.saveContext()
        }
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    @IBAction func addStorePressed(sender: AnyObject) {
        
    }
}
