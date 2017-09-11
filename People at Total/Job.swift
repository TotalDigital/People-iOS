//
//  Job.swift
//  justOne
//
//  Created by Florian Letellier on 29/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation

class Job: NSObject, NSCoding {
    var id: Int?
    var title: String?

    var start_date: String?
    var end_date: String?
    var objDescription: String?
    var location: String?
    
    override init() {
        
    }
    
    init(id: Int?, title: String?,start_date: String?,end_date: String?,objDescription: String?,location: String?) {
        self.id = id
        self.title = title

        self.start_date = start_date
        self.end_date = end_date
        self.objDescription = objDescription
        self.location = location
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let start_date = aDecoder.decodeObject(forKey: "start_date") as? String
        let end_date = aDecoder.decodeObject(forKey: "end_date") as? String
        let objDescription = aDecoder.decodeObject(forKey: "objDescription")  as? String
        let location = aDecoder.decodeObject(forKey: "location")  as? String
        self.init(id: id, title: title,start_date: start_date,end_date: end_date,objDescription: objDescription,location: location)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(start_date, forKey: "start_date")
        aCoder.encode(end_date, forKey: "end_date")
        aCoder.encode(objDescription, forKey: "objDescription")
        aCoder.encode(location, forKey: "location")
    }
    
}

