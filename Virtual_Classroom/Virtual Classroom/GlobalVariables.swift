//
//  GlobalVariables.swift
//  Virtual Classroom
//
//  Created by Miles Friedman on 11/20/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Foundation

class GlobalVariables {
    
    //InstViewController variable for instructors courseList
    var associatedCourses: [String] = ["test"]
    
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
    
}
