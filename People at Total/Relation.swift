//
//  Relation.swift
//  justOne
//
//  Created by Florian Letellier on 29/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation

class Relation: NSObject, NSCoding {
    var isRelationAvailable: Bool = false
    var relationshipID: Int = 0
    
    var managers: [Int] = []
    var assistant: [Int] = []
    var teamMember: [Int] = []
    var colleagues: [Int] = []
    var managers_profile: [Profile] = []
    var assistants_profile: [Profile] = []
    var teamMembers_profile: [Profile] = []
    var colleagues_profile: [Profile] = []
    
    override init() {
        
    }
    
    init(isRelationAvailable: Bool, relationshipID: Int, managers: [Int],assistant: [Int],teamMember: [Int],colleagues: [Int],managers_profile: [Profile],assistants_profile: [Profile],teamMembers_profile: [Profile],colleagues_profile: [Profile]) {
        self.isRelationAvailable = isRelationAvailable
        self.relationshipID = relationshipID
        self.managers = managers
        self.assistant = assistant
        self.teamMember = teamMember
        self.colleagues = colleagues
        self.managers_profile = managers_profile
        self.assistants_profile = assistants_profile
        self.teamMembers_profile = teamMembers_profile
        self.colleagues_profile = colleagues_profile
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let isRelationAvailable = aDecoder.decodeBool(forKey: "isRelationAvailable")
        let relationshipID = aDecoder.decodeInteger(forKey: "relationshipID")
        let managers = aDecoder.decodeObject(forKey: "managers") as! [Int]
        let assistant = aDecoder.decodeObject(forKey: "assistant") as! [Int]
        let teamMember = aDecoder.decodeObject(forKey: "teamMember") as! [Int]
        let colleagues = aDecoder.decodeObject(forKey: "colleagues")  as! [Int]
        let managers_profile = aDecoder.decodeObject(forKey: "managers_profile")  as! [Profile]
        let assistants_profile = aDecoder.decodeObject(forKey: "assistants_profile")  as! [Profile]
        let teamMembers_profile = aDecoder.decodeObject(forKey: "teamMembers_profile")  as! [Profile]
        let colleagues_profile = aDecoder.decodeObject(forKey: "colleagues_profile")  as! [Profile]
        self.init(isRelationAvailable: isRelationAvailable, relationshipID: relationshipID, managers: managers,assistant: assistant,teamMember: teamMember,colleagues: colleagues,managers_profile: managers_profile,assistants_profile: assistants_profile,teamMembers_profile: teamMembers_profile,colleagues_profile: colleagues_profile)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(isRelationAvailable, forKey: "isRelationAvailable")
        aCoder.encode(relationshipID, forKey: "relationshipID")
        aCoder.encode(managers, forKey: "managers")
        aCoder.encode(assistant, forKey: "assistant")
        aCoder.encode(teamMember, forKey: "teamMember")
        aCoder.encode(colleagues, forKey: "colleagues")
        aCoder.encode(managers_profile, forKey: "managers_profile")
        aCoder.encode(assistants_profile, forKey: "assistants_profile")
        aCoder.encode(teamMembers_profile, forKey: "teamMembers_profile")
        aCoder.encode(colleagues_profile, forKey: "colleagues_profile")
    }

}
