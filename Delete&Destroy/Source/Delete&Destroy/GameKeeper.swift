//
//  GameKeeper.swift
//  Delete&Destroy
//
//  Created by Connor on 11/29/16.
//  Copyright © 2016 CrunchTime. All rights reserved.
//

import Foundation

import CoreData
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


// Passes current progress and win condition if met
protocol TransferTime {
    
    func progressHasChanged(_ progressData: Float)
    func declareGameStatus(_ gameStatus: Bool)
}

// Keeps game time, determines win condition, and updates timer progress
class GameKeeper {
    
    // VARIABLES AND PROPERTIES
    //==================================================================================
    
    // Delegates
    var delegate: TransferTime? = nil
    var maindelegate:TransferTime? = nil
    
    // Variables
    var emailObjects: [NSManagedObject]?
    var emailCount: Int?
    var interval: TimeInterval?
    var timerWithInterval: Timer?
    var progress: Float?
    var denomonator: Float?
    var currentTime: Float?
    var gameStatus: Bool?
    
    let singleton = EmailSingleton.sharedInstance
    
    // INIT
    //==================================================================================
    
    // start off with these values
    init (interval: TimeInterval, timeDenominator: Float, emailCount: Int) {
        // prepare emailCount to be populated
        retrieveEmailFromCoreData()
        
        self.interval = interval
        self.timerWithInterval = Timer()
        self.progress = Float(1.0)
        self.denomonator = timeDenominator
        self.currentTime = timeDenominator
        self.emailCount = singleton.Laptop?.classifiedEmail.count
    }
    
    // FUNCTIONS
    //==================================================================================
    
    // creates timer used to delegate game progress and win condition
    func createTimer(){
        timerWithInterval = Timer.scheduledTimer(timeInterval: self.interval!, target: self, selector: #selector(GameKeeper.updateTime), userInfo: nil, repeats: true)
    }
    
    // updates time and progress
    @objc func updateTime() {
        currentTime!-=Float(1.0)
        progress = currentTime!/denomonator!
        
        if progress != nil {
            if delegate != nil {
                delegate?.progressHasChanged(progress!)
            }
            if maindelegate != nil{
                maindelegate?.progressHasChanged(progress!)
            }
        }
        
        checkEmailCount()
        checkForWin()
    }
    
    // checks for win condition, if met, sends to delegates
    func checkForWin(){
        if progress > 0 && emailCount == 0 {
            timerWithInterval?.invalidate()
            NSLog("Player Win")
            gameStatus = true
        }else if (progress <= 0 && emailCount != 0) {
            timerWithInterval?.invalidate()
            NSLog("Player Lose")
            gameStatus = false
        }else{
            NSLog("No Win")
        }
        if gameStatus != nil {
            delegate?.declareGameStatus(gameStatus!)
            maindelegate?.declareGameStatus(gameStatus!)
        }
        
    }
    // resets inital values
    func reset(){
        gameStatus = nil
        progress = Float(1.0)
        currentTime = denomonator
        checkEmailCount()
    }
    //counts the objects from core data
    func checkEmailCount(){
        retrieveEmailFromCoreData()
        emailCount = singleton.countClassifiedEmail()
        
    }
    // retrives emails from core data and puts them into a list
    func retrieveEmailFromCoreData(){
        
//        let appDelegate = AppDelegate()
//        let managedContext = appDelegate.managedObjectContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClassifiedEmail")
//        do {
//            let results =
//                try managedContext.executeFetchRequest(fetchRequest)
//            emailObjects = results as? [NSManagedObject]
//            NSLog("\(emailObjects)")
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
    }
    func clearAllEmails(){
        //
        //        let appDelegate = AppDelegate()
        //        let managedContext = appDelegate.managedObjectContext
        //        for item in emailObjects!{
        //            context.deleteObject(emailObjects![indexPath.row] as NSManagedObject)
        //            emailObjects!.removeAtIndex(indexPath.row)
        //            do {
        //                try context.save()
        //            } catch let error as NSError  {
        //                print("Could not save \(error), \(error.userInfo)")
        //            }
        //
        //            
        //        }
        //        
        //        }
    }
}
