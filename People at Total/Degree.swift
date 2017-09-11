//
//  Degree.swift
//  People at Total
//
//  Created by Florian Letellier on 31/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.

import UIKit

class Degree: NSObject, NSCoding {
    var degree_id: Int?
    var title: String?
    var entry_year: String?
    var graduation_year: String?
    var user_id: Int?
    var school_id: Int?
    var school: String?
    
    override init() {
        
    }
    
    init(degree_id: Int?, title: String?, entry_year: String?,graduation_year: String?,user_id: Int?,school_id: Int?,school: String?) {
        self.degree_id = degree_id
        self.title = title
        self.entry_year = entry_year
        self.graduation_year = graduation_year
        self.user_id = user_id
        self.school_id = school_id
        self.school = school
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let degree_id = aDecoder.decodeObject(forKey: "degree_id") as? Int
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let entry_year = aDecoder.decodeObject(forKey: "entry_year") as? String
        let graduation_year = aDecoder.decodeObject(forKey: "graduation_year") as? String
        let user_id = aDecoder.decodeObject(forKey: "user_id") as? Int
        let school_id = aDecoder.decodeObject(forKey: "school_id")  as? Int
        let school = aDecoder.decodeObject(forKey: "school")  as? String
        self.init(degree_id: degree_id, title: title, entry_year: entry_year,graduation_year: graduation_year,user_id: user_id,school_id: school_id,school: school)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(degree_id, forKey: "degree_id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(entry_year, forKey: "entry_year")
        aCoder.encode(graduation_year, forKey: "graduation_year")
        aCoder.encode(user_id, forKey: "user_id")
        aCoder.encode(school_id, forKey: "school_id")
        aCoder.encode(school, forKey: "school")
    }
    
}
