//
//  AddMovieVC.swift
//  MyFavoriteMovies
//
//  Created by Ralph Cachero on 1/21/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit
import CoreData

class AddMovieVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieYear: UITextField!
    @IBOutlet weak var moviePlot: UITextField!
    @IBOutlet weak var movieReason: UITextField!
    @IBOutlet weak var movieLink: UITextField!
    @IBOutlet weak var movieImg: UIImageView!
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.delegate = self
        movieYear.delegate = self
        moviePlot.delegate = self
        movieReason.delegate = self
        movieLink.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        movieTitle.resignFirstResponder()
        movieYear.resignFirstResponder()
        moviePlot.resignFirstResponder()
        movieReason.resignFirstResponder()
        movieLink.resignFirstResponder()
        return true
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        movieImg.image = image
    }
    
    @IBAction func addImg(sender: AnyObject!) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addMovie(sender: AnyObject!) {
        if let title = movieTitle.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
            let movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
            movie.title = title
            movie.year = movieYear.text
            movie.plot = moviePlot.text
            movie.reason = movieReason.text
            movie.link = movieLink.text
            movie.setMovieImg(movieImg.image!)
            
            context.insertObject(movie)
            
            do {
                try context.save()
            } catch {
                print("Could not save movie!")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
