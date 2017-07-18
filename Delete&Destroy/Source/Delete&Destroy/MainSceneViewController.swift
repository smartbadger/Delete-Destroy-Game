//
//  MainSceneViewController.swift
//  Delete&Destroy
//
//  Created by Connor on 11/29/16.
//  Copyright © 2016 CrunchTime. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController, Restart, TransferTime {

    
    // OUTLET RESOURCES
    //==================================================================================
    

    @IBOutlet var IpadImage: UIImageView!
    @IBOutlet var timerview: UIProgressView!
    @IBOutlet var laptopImage: UIImageView!
    @IBOutlet var countdownlabel: UILabel!
    @IBOutlet var blackberryImage: UIImageView!
    @IBOutlet var buttonImageCollection: [UIImageView]!
    @IBOutlet var level: UILabel!
    
   
    
    
    // VARIABLES AND PROPERTIES
    //==================================================================================
    
    var LaptopVC: UIViewController?
    var gameActive: Bool?

    var countdowntimer = Timer()
    var totalEmail = 1
    var currentLevel = 1
    var leveltime = 30.0
    var den = 30.0
    var count = 3
    var inGame: Bool?
    
    
    let singleton = EmailSingleton.sharedInstance
    let textSetter = EmailTitleText()
    let gametimer = GameKeeper(interval: TimeInterval(1.0), timeDenominator: Float(30), emailCount: 0)
    
    
    // OVERRIDE FUNCTIONS
    //==================================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the maindelegate of MainSceneViewController, delegate will change depending on current view controller
        gametimer.maindelegate = self
        level.text = "Level \(currentLevel)"
        // Create the initial wave of emails, consider moving to seperate function
        if (gameActive == nil || gameActive == false) {
            singleton.Laptop = singleton.createDeviceEmail(spam: 0, classified: 3)
            singleton.devices.append(singleton.Laptop!)
            singleton.Ipad = singleton.createDeviceEmail(spam: 0, classified: 3)
            singleton.devices.append(singleton.Ipad!)
            singleton.Blackberry = singleton.createDeviceEmail(spam: 0, classified: 3)
            singleton.devices.append(singleton.Blackberry!)
            gameActive = true
            gametimer.emailCount = singleton.countClassifiedEmail()
            
        }
        // Make the timer larger for easier viewing
        timerview.transform = timerview.transform.scaledBy(x: 1, y: 5)
        
        //Create tap recognize
        // Add recogniser to images
        laptopImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainSceneViewController.tap)))
        blackberryImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainSceneViewController.tap)))
        IpadImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainSceneViewController.tap)))
        
        
        
        // Run game
        checkstart()
        
    }
    
    // DELEGATE PROTOCOLS
    //==================================================================================
    
    // Called when game ends
    func declareGameStatus(_ gameStatus: Bool) {
        for item in buttonImageCollection {
            item.isUserInteractionEnabled = false
        }
        timerview.isHidden = true
        //Game Win, level Advancement, reset values, play animations
        if gameStatus == true {
        NSLog("Win")
        currentLevel += 1
            
            // Game Lose, reset level/ values, play animations
        }else{
        NSLog("Lose")
        currentLevel = 1
        }
        let storyboard: UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "GameAtEnd") as! GameAtEnd
        controller.levelWin = gametimer.gameStatus!
        controller.delegate = self
        self.present(controller, animated: false, completion: nil)
    }
    
    // Used to update the progress bar
    func progressHasChanged(_ progressData: Float){
        
        timerview.setProgress(progressData, animated: true)
    }
    
    func viewDismissed() {
        reset()
    }
    
    
    
    // FUNCTIONS
    //==================================================================================
    
    // Creates Emails Both Spam or Classfied depeding on input
    func createEmail(){//_ deviceType: String, text: String) {
        for item in singleton.devices {
            item.createEmail(classified: true, number: 1)
            
            
        }

    }
    

    
    // Is Called When the View has loaded
    func startCountDown(){
        
        
        timerview.isHidden = false
        inGame = true
        // Show countdown label and start countdown process
        countdownlabel.text = String(count)
        countdownlabel.isHidden = false
        countdowntimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MainSceneViewController.countdown), userInfo: nil, repeats: true)
        timerview.setProgress(1.0, animated: true) // might not be needed
        // In
        callForWait(3, method: startGame)
        
    }
    
    // Delay timer for excecuting events after an amount of time
    func callForWait(_ number: Double, method: @escaping (()->())){
        
        let delayTime = DispatchTime.now() + Double(Int64(number * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime){
            method()
        }
    }
    // Starts the GameKeeperTimer
    func startGame(){
        
        gametimer.createTimer()
        // Allow the User to Interact With the Images
        for item in buttonImageCollection{
            item.isUserInteractionEnabled = true
        }
        
    }
    
    // Change ViewController based on image tapped, also change the current delegate to the view controller being presented
    func tap(_ sender: UIGestureRecognizer){ //MIGHT NEED TO PASS IN SENDER.TAG PARAMETER
        let storyboard: UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
        let tag = sender.view!.tag
        // Add statment to differentiate between UIImages
        let controller = storyboard?.instantiateViewController(withIdentifier: "DeviceViewController") as! DeviceViewController
        controller.senderTag = Int(tag)
        
        self.present(controller, animated: true, completion: nil)
        gametimer.delegate = controller
    }
    
    // Incrementally displays the time until the game starts
    func countdown(){
        // once the time is up, hide the label and invalidate timer
        if (count <= 0) {
            
            countdownlabel.isHidden = true
            countdowntimer.invalidate()
            count = 4
            
        }else{
            countdownlabel.text = String(count)
        }
        
        count-=1
    }
    
    // Reset all the values to their begining condition
    func reset(){
       
       singleton.removeAndReset()
       createEmail()
       gametimer.reset()
       startCountDown()
       level.text = "Level \(currentLevel)"
        
        
    }
    
    // Check to see if the games is running or needs to be started
    func checkstart(){
        if (inGame == true){
            NSLog("Game running")
        }else{
            startCountDown()
            NSLog("game did start")
        }
        
    }
    
    //=======================================================================================
    //   ADDITIONAL NOTES / RESOURCES
    //=======================================================================================
    
    
    /* KEEP THIS SECTION FOR NOW...
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     
     
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // If using segues add destination segue here
     }
     */
}

