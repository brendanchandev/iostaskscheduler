//
//  Goal.swift
//  Task Scheduling App
//
//  Created by Brendan Chan on 2023-12-03.
//

import CoreData

class Goal: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var dueDate: Date
    // ... other properties ...
}