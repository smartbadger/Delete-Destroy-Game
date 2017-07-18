//
//  DeviceViewController.swift
//  Delete&Destroy
//
//  Created by Connor on 11/29/16.
//  Copyright © 2016 CrunchTime. All rights reserved.
//



import UIKit

// Shows Device and allows player to delete emails, resuseable
class DeviceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TransferTime {
    
    
    // VARIABLES AND PROPERTIES
    //==================================================================================
    
    @IBOutlet weak var timerview: UIProgressView!
    @IBOutlet weak var deviceTableView: UITableView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    var senderTag: Int?
    var deviceType : DeviceEmailCache?
    let singleton = EmailSingleton.sharedInstance
    
    
    // OVERRIDE FUNCTIONS
    //==================================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceTableView.delegate = self
        timerview.transform = timerview.transform.scaledBy(x: 1, y: 5)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if senderTag != nil {
        
        switch senderTag! {
            case 1 : deviceType = singleton.Laptop!
            case 2 : deviceType = singleton.Blackberry!
            case 3 : deviceType = singleton.Ipad!
            case 4 : deviceType = singleton.Phone!
            default:
            NSLog("default used" )
            deviceType = singleton.Laptop
            }
        }else{
            NSLog("Sender Tag is Nil")
        }
        
    }

    // DELEGATE PROTOCOLS
    //==================================================================================
    
    func progressHasChanged(_ progressData: Float){
        
        timerview.setProgress(progressData, animated: true)
    }
    func declareGameStatus(_ gameStatus: Bool) {
        if gameStatus == true || gameStatus == false {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // FUNCTIONS
    //==================================================================================
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return deviceType!.classifiedEmail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt: IndexPath) -> UITableViewCell {
        
        let cell = deviceTableView.dequeueReusableCell(withIdentifier: "email") as! EmailTableViewCell
        let person = deviceType!.classifiedEmail[cellForRowAt.row]
        cell.emailText.text = person
        
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        deleteButton.isEnabled = true
        
    }
    
    
    
    @IBAction func deleteButtonIsPressed(_ sender: AnyObject) {
        if let indexPaths = deviceTableView.indexPathsForSelectedRows! as? [IndexPath] {
            for indexPath in indexPaths {
                
                deviceType!.classifiedEmail.remove(at: indexPath.row)
            }
            deviceTableView.deleteRows(at: indexPaths, with: .automatic)
        }
        deleteButton.isEnabled = false
    }
    
    @IBAction func backbutton(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
//====================================================================================
//      ADDITIONAL NOTES AND RESOURCES
//====================================================================================

/*
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
 }
         let appDelegate = AppDelegate()
         let managedContext = appDelegate.managedObjectContext
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClassifiedEmail")
         do {
             let results =
                 try managedContext.executeFetchRequest(fetchRequest)
             emailObjects = results as? [NSManagedObject]
             NSLog("\(emailObjects)")
         } catch let error as NSError {
             print("Could not fetch \(error), \(error.userInfo)")
         }

 
 */
