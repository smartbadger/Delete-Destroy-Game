//
//  DeviceEmailCache.swift
//  Delete&Destroy
//
//  Created by Connor on 12/3/16.
//  Copyright © 2016 CrunchTime. All rights reserved.
//

import Foundation

class DeviceEmailCache {
    
    let textSetter = EmailTitleText()
    var classifiedEmail: [String] = []
    var spamEmail: [String] = []
    var combinedEmail: [[String]] = []
    
    init(numberOfClassifed: Int, numberOfSpam: Int) {
        createEmail(classified: true, number: numberOfClassifed)
        createEmail(classified: false, number: numberOfSpam)
        
        //combinedEmail.append(classifiedEmail)
        //combinedEmail.append(spamEmail)
        randomizeEmails()
        
    }
    func randomizeEmails() {
        //combinedEmail.shuffleInPlace()
        
    }
    
    func createEmail(classified: Bool, number: Int){
        if number > 0 {
        for _ in 1...number{
            let random = Int(arc4random_uniform(UInt32(textSetter.classifiedTitle.count)))
                if classified == true {
                    classifiedEmail.append(textSetter.classifiedTitle[random])
                }else {
                spamEmail.append(textSetter.classifiedTitle[random])
                }
            
            }
        }
    }
    func countTotalEmails () -> Int {
        let count = classifiedEmail.count + spamEmail.count
        return count
    }
    
   
}

//extension MutableCollection where Index == Int {
//    mutating func shuffleInPlace(){
//        if count < 2 {return}
//        
//        for i in startIndex ..< endIndex - 1  {
//            let j = Int(arc4random_uniform(UInt32(endIndex - i ))) + i
//            guard i != j else {continue}
//            swap(&self[i], &self[j])
//        }
//    }
//    
//}
