//
//  GameAtEnd.swift
//  Delete&Destroy
//
//  Created by Connor on 12/5/16.
//  Copyright © 2016 CrunchTime. All rights reserved.
//

import UIKit

protocol Restart {
    func viewDismissed()
}

class GameAtEnd: UIViewController {

    @IBOutlet var cell: UIImageView!
    @IBOutlet var gameOver: UIImageView!
    @IBOutlet var playAgain: UIButton!
    @IBOutlet var Quit: UIButton!
    
    var delegate: Restart?
    var levelWin: Bool?
    

    @IBAction func quitPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Menu")
        self.present(controller, animated: false, completion: nil)

        
        
    }
    
    
    
    @IBAction func playAgainPressed(_ sender: Any) {
        reset()
        let delayTime = DispatchTime.now() + Double(Int64( 3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime){
            if self.delegate != nil {
                self.delegate?.viewDismissed()
                self.dismiss(animated: false, completion: nil)
                
            }
        }
        
        
        

    }
    
    func reset() {
//        if levelWin == false {
//          
            playAgain.isHidden = true
            Quit.isHidden = true
        
            UIView.animate(withDuration: 3.0,
                           //delay: 0.2,
                animations: {
                    self.cell.center.x -= self.view.bounds.width
                    
//
//                    
//                    
//            })
//        }
//        if levelWin == true {
//            
//            UIView.animate(withDuration: 3.0,
//                           //delay: 0.1,
//                animations: {
                    self.gameOver.center.x -= self.view.bounds.width
                    self.playAgain.center.y += self.view.bounds.height
                    
                    
            })
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        cell.center.x -= view.bounds.width
        playAgain.isHidden = true
        Quit.isHidden = true
        gameOver.isHidden = true
        self.playAgain.center.y += self.view.bounds.height
        self.Quit.center.y += self.view.bounds.height //last stopping point need to add quit button features below
            }
    override func viewDidAppear(_ animated: Bool) {
        if levelWin == false {
            gameOver.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            playAgain.titleLabel!.text = "Play Again!"
            UIView.animate(withDuration: 3.0,
                           //delay: 0.2,
                           animations: {
                           self.cell.center.x += self.view.bounds.width
                           self.gameOver.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                           self.playAgain.isHidden = false
                           self.Quit.isHidden = false
                           self.gameOver.isHidden = false
                           self.Quit.center.y -= self.view.bounds.height
                           self.playAgain.center.y -= self.view.bounds.height
                            
            
            })
        }
        if levelWin == true {
            gameOver.center.x += view.bounds.width
            playAgain.titleLabel?.text = "Next Level"
            gameOver.image = UIImage(named: "levelcomplete")
            UIView.animate(withDuration: 3.0,
                           //delay: 0.1,
                           animations: {
                            self.Quit.isHidden = false
                            self.gameOver.center.x -= self.view.bounds.width
                            self.Quit.center.y -= self.view.bounds.height
                            self.playAgain.isHidden = false
                            self.gameOver.isHidden = false
                            self.playAgain.center.y -= self.view.bounds.height
                            
                            
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
