//
//  ShowViewController.swift
//  DataPersistence_wPropertyList
//
//  Created by Wismin Effendi on 6/19/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var person1Name: UILabel!
    @IBOutlet weak var person1Bio: UILabel!
    
    @IBOutlet weak var person2Name: UILabel!
    @IBOutlet weak var person2Bio: UILabel!
    
    var plistFile: String!
    
    lazy var couple: [[String: String]]? = {
        do {
            let fileManager = FileManager.default
            let document = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let file = document.appendingPathComponent(self.plistFile)
            
            
            var plistFormat = PropertyListSerialization.PropertyListFormat.xml
            
            
            let plistData = try Data(contentsOf: file)
            let people = try PropertyListSerialization.propertyList(from: plistData, options: [], format: &plistFormat) as! [[String: String]]
            
            return people
        } catch {
            print("Error reading the plist couple information")
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Couple Information"
        populateCoupleInfo()
    }


    private func populateCoupleInfo() {
        guard let coupleInfo = couple else { return }
        
        if let firstPersonInfo = coupleInfo.first,
            let person1FirstName = firstPersonInfo["First Name"],
            let person1LastName = firstPersonInfo["Last Name"],
            let person1Bio = firstPersonInfo["Bio"] {

            self.person1Name.text = person1FirstName + " " + person1LastName
            self.person1Bio.text = person1Bio
            
            if let secondPersonInfo = coupleInfo.dropFirst().first,
                let person2FirstName = secondPersonInfo["First Name"],
                let person2LastName = secondPersonInfo["Last Name"],
                let person2Bio = secondPersonInfo["Bio"] {
                
                self.person2Name.text = person2FirstName + " " + person2LastName
                self.person2Bio.text  = person2Bio
            }
        
        
        }
    }


}
