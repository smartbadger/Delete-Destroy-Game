//
//  EmailTableViewCell.swift
//  Delete&Destroy
//
//  Created by Connor on 11/29/16.
//  Copyright © 2016 CrunchTime. All rights reserved.
//

import UIKit

// Displays the email
class EmailTableViewCell: UITableViewCell {
    
    // VARIABLES AND PROPERTIES
    //==================================================================================
    var boxChecked: Bool = false
    
    
    // OUTLET RESOURCES
    //==================================================================================
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var emailText: UILabel!
    @IBAction func checkBoxIsPressed(_ sender: AnyObject) {
        
        if boxChecked == false {
            boxChecked = true
            self.isSelected = true
            checkBoxButton.titleLabel?.text = "x"
            NSLog("Box is checked")
        }else{
            boxChecked = false
            self.isSelected = false
            checkBoxButton.titleLabel?.text = ""
            NSLog("Box is unchecked")
            
        }
    }
    
}

