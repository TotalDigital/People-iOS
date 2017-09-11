//
//  Info.swift
//  justOne
//
//  Created by Florian Letellier on 29/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation

class Skill: NSObject, NSCoding {
    var skills: [String] = []
    var skillsIds: [Int] = []
    
    override init() {
        
    }
    
    init(skills: [String], skillsIds: [Int]) {
        self.skills = skills
        self.skillsIds = skillsIds
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let skills = aDecoder.decodeObject(forKey: "skills") as! [String]
        let skillsIds = aDecoder.decodeObject(forKey: "skillsIds") as! [Int]
        self.init(skills: skills, skillsIds: skillsIds)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(skills, forKey: "skills")
        aCoder.encode(skillsIds, forKey: "skillsIds")
    }

}
