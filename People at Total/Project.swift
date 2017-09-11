//
//  Project.swift
//  justOne
//
//  Created by Florian Letellier on 29/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation

class Project: NSObject, NSCoding {
    var id: Int?
    var participation_id: Int?
    var title:String?
    var start_date: String?
    var end_date: String?
    var location: String?
    var members: [Int] = []
    var members_profile: [Profile] = []
    var objDescription: String?
    var owner: Bool = false
    
    override init() {
        
    }
    
    init(id: Int, participation_id: Int, title: String,start_date: String,end_date: String,location: String,members: [Int],members_profile: [Profile],objDescription: String,owner: Bool) {
        self.id = id
        self.participation_id = participation_id
        self.title = title
        self.start_date = start_date
        self.end_date = end_date
        self.location = location
        self.members = members
        self.members_profile = members_profile
        self.objDescription = objDescription
        self.owner = owner
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! Int
        let participation_id = aDecoder.decodeObject(forKey: "participation_id") as! Int
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let start_date = aDecoder.decodeObject(forKey: "start_date") as! String
        let end_date = aDecoder.decodeObject(forKey: "end_date") as! String
        let location = aDecoder.decodeObject(forKey: "location")  as! String
        let members = aDecoder.decodeObject(forKey: "members")  as! [Int]
        let members_profile = aDecoder.decodeObject(forKey: "members_profile")  as! [Profile]
        let objDescription = aDecoder.decodeObject(forKey: "objDescription")  as! String
        let owner = aDecoder.decodeObject(forKey: "owner")
        self.init(id: id, participation_id: participation_id, title: title,start_date: start_date,end_date: end_date,location: location,members: members,members_profile: members_profile,objDescription: objDescription,owner: (owner != nil))
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(participation_id, forKey: "participation_id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(start_date, forKey: "start_date")
        aCoder.encode(end_date, forKey: "end_date")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(members, forKey: "members")
        aCoder.encode(members_profile, forKey: "members_profile")
        aCoder.encode(objDescription, forKey: "objDescription")
        aCoder.encode(owner, forKey: "owner")
    }
}
