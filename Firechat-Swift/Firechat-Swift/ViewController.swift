//
//  ViewController.swift
//  Firechat-Swift
//
//  Created by Ralph Cachero on 3/4/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameField: UIButton!
    
    var name: String?
    var firebase: Firebase!
    var chat = [AnyObject]()
    
    let kFirechatNS = "https://firechat-ios.firebaseio-demo.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Initialize the root of our Firebase namespace
        var firebaseRef = Firebase(url: kFirechatNS)
        
        //Pick a random number between 1 - 1000 for our username
        name = "Guest\(arc4random() % 1000)"
        nameField.setTitle(name, forState: .Normal)
        
        // Decide whether or not to reverse the messages
        let newMessagesOnTop = true;
        
        // This allows us to check if these were messages already stored on the server
        // when we booted up (YES) or if they are new messages since we've started the app.
        // This is so that we can batch together the initial messages' reloadData for a perf gain.
        var initialAdds: Bool = true
        self.firebase.observeEventType(FEventType.ChildAdded, withBlock: {(snapshot: FDataSnapshot!) -> Void in
            // Add the chat message to the array.
            if newMessagesOnTop {
                self.chat.insert(snapshot.value, atIndex: 0)
            }
            else {
                self.chat.append(snapshot.value)
            }
            // Reload the table view so the new message will show up.
            if (!initialAdds) {
                self.tableView.reloadData()
            }
        })
        
        // Value event fires right after we get the events already stored in the Firebase repo.
        // We've gotten the initial messages stored on the server, and we want to run reloadData on the batch.
        // Also set initialAdds=NO so that we'll reload after each additional childAdded event.
        self.firebase.observeSingleEventOfType(FEventType.Value, withBlock: {(snapshot: FDataSnapshot!) -> Void in
            
            self.tableView.reloadData()
            initialAdds = false;
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Text field handling
    
    // This method is called when the user enters text in the text field.
    // We add the chat message to our Firebase.
    func textFieldShouldReturn(aTextField: UITextField) -> Bool {
        
        aTextField.resignFirstResponder()
        
        // This will also add the message to our local array self.chat because
        // the FEventTypeChildAdded event will be immediately fired.
        self.firebase.childByAutoId().setValuesForKeysWithDictionary(["name": self.name!, "text": aTextField.text!])
        aTextField.text = ""
        return false
    }
    
    // MARK: Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // We only have one section in our table view.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var chatMessage: [NSObject:AnyObject] = self.chat[indexPath.row] as! [NSObject : AnyObject]
        
        var text: String = "text"
        
        // typical textLabel.frame = {{10, 30}, {260, 22}}
        let TEXT_LABEL_WIDTH: CGFloat = 260
        let constraint: CGSize = CGSizeMake(TEXT_LABEL_WIDTH, 20000)
        
        // typical textLabel.font = font-family: "Helvetica"; font-weight: bold; font-style: normal; font-size: 18px
        var font: UIFont = UIFont.systemFontOfSize(18)
        var attributedText: NSAttributedString = NSAttributedString(string: text, attributes: [NSFontAttributeName: font])
        var rect: CGRect = attributedText.boundingRectWithSize(constraint, options: .UsesLineFragmentOrigin, context: nil)
        var size: CGSize = rect.size
        // requires iOS 6+
        let CELL_CONTENT_MARGIN: CGFloat = 22
        var height: CGFloat = max(CELL_CONTENT_MARGIN + size.height, 44)
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var CellIdentifier: String = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)!
        
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: CellIdentifier)
            cell.textLabel.font = UIFont.systemFontOfSize(18)
            cell.textLabel.numberOfLines = 0
        }
        
        var chatMessage: [NSObject : AnyObject] = self.chat[indexPath.row] as! [NSObject : AnyObject]
        cell.textLabel?.text = chatMessage["text"]
        cell.detailTextLabel?.text = chatMessage["name"]
        return cell
    }

}

