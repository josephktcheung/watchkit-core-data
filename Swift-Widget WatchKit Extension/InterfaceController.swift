//
//  InterfaceController.swift
//  Swift-Widget WatchKit Extension
//
//  Created by Joseph Cheung on 21/11/14.
//  Copyright (c) 2014 AnyTap. All rights reserved.
//

import WatchKit
import Foundation
import CoreData
import SwiftWidgetKit

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var countLabel: WKInterfaceLabel!
    
    let context = CoreDataStore.mainQueueContext()
    var counter: Counter?
    
    override init(context: AnyObject?) {
        super.init(context: context)
        self.fetchData()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }
    
    
    func fetchData () {
        let counter = NSManagedObject.findAllInContext("Counter", context: self.context)
        
        if let last: AnyObject = counter?.last {
            let count = last as Counter
            self.counter = count
        }else{
            // Create new one
            self.counter = NSEntityDescription.insertNewObjectForEntityForName("Counter", inManagedObjectContext: self.context) as? Counter
            self.counter?.name = ""
            self.counter?.count = 0
        }
        
        self.updateData()
    }
    
    func updateData () {
        
        self.titleLabel.setText(self.counter?.name)
        self.countLabel.setText(self.counter?.count.stringValue)
    }    
}
