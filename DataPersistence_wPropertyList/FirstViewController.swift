//
//  FirstViewController.swift
//  DataPersistence_wPropertyList
//
//  Created by Wismin Effendi on 6/19/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var person1FirstName: UITextField!
    @IBOutlet weak var person1LastName: UITextField!
    @IBOutlet weak var person1Bio: UITextView!
    
    @IBOutlet weak var person2FirstName: UITextField!
    @IBOutlet weak var person2LastName: UITextField!
    @IBOutlet weak var person2Bio: UITextView!
    
    var plistResource = "Couple"
    var plistFile: String {
        return plistResource + ".plist"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    // The show button will first save the data to plist 
    // before performing  Segue to  ShowViewController 
    @IBAction func showButtonTapped(_ sender: UIBarButtonItem) {
        saveTwoPersonsInfo()
        performSegue(withIdentifier: "ShowViewController", sender: sender)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowViewController",
            let viewController = segue.destination as? ShowViewController {
            
            viewController.plistFile = plistFile
        }
    }
 

    private func saveTwoPersonsInfo() {
        let fileManager = FileManager.default
        let p1firstName = person1FirstName.text ?? ""
        let p1lastName = person1LastName.text ?? ""
        let p1Bio = person1Bio.text ?? ""
        
        let p2firstName = person2FirstName.text ?? ""
        let p2lastName = person2LastName.text ?? ""
        let p2Bio = person2Bio.text ?? ""
        do {
            let firstPerson = ["First Name" : p1firstName, "Last Name": p1lastName, "Bio": p1Bio] as [String: String]
            let secondPerson = ["First Name" : p2firstName, "Last Name": p2lastName, "Bio": p2Bio] as [String: String]
            let coupleArray = [firstPerson, secondPerson]
            let serializedData = try PropertyListSerialization.data(fromPropertyList: coupleArray, format: PropertyListSerialization.PropertyListFormat.xml, options: 0)
            let document = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let file = document.appendingPathComponent(plistFile)
            try serializedData.write(to: file)
        } catch {
            print("****  Error saving two person data to plist")
        }
    }
}
