//
//  AddEntryViewController.swift
//  DiaryApp
//
//  Created by James O'Connor on 7/20/16.
//  Copyright © 2016 James O'Connor. All rights reserved.
//

import UIKit
import CoreData

protocol AddEntryDelegate :class {
    
    func addEntry(newEntry :String)
    
}

class AddEntryViewController: UIViewController {

    var diaryEntry :NSManagedObject!
    var managedObjectContext :NSManagedObjectContext!
    weak var delegate :AddEntryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var addEntryTextField :UITextField!
    
    @IBAction func saveButton() {
    
        self.delegate!.addEntry(self.addEntryTextField.text!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
