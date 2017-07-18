//
//  TheOneAndOnlyEmailSource.swift
//  Delete&Destroy
//
//  Created by Connor on 12/1/16.
//  Copyright © 2016 CrunchTime. All rights reserved.
//

import Foundation

class EmailSingleton {
    static let sharedInstance = EmailSingleton()
    private init() {
    
    
    }
    var LDCE: [String] = []
    
    var Laptop: DeviceEmailCache?
    var Blackberry: DeviceEmailCache?
    var Ipad: DeviceEmailCache?
    var Phone: DeviceEmailCache?
    
    var devices: [DeviceEmailCache] = []
    
    func createDeviceEmail(spam: Int, classified: Int) -> DeviceEmailCache{
        return DeviceEmailCache(numberOfClassifed: classified, numberOfSpam: spam)
        
    }
    
    func countClassifiedEmail() -> Int {
        var count = 0
        
        for item in devices{
            count += item.classifiedEmail.count
        
        }
        return count
    }
    func removeAndReset(){
        for item in devices{
            item.classifiedEmail.removeAll()
            item.spamEmail.removeAll()
        }
        
    }
}
