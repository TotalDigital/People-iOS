//
//  Profile.swift
//  justOne
//
//  Created by Florian Letellier on 29/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding {
    var id: Int = 0
    var user: User!
    var jobs: [Job] = []
    var degree: [Degree] = []
    var projects: [Project] = []
    var relations: Relation = Relation()
    var skills: Skill = Skill()
    var langues: Language = Language()
    var contact: Contact = Contact()
    
    override init() {
        
    }
    
    init(id: Int, user: User, jobs: [Job],projects: [Project],relations: Relation,skills: Skill,langues: Language,contact: Contact) {
        self.id = id
        self.user = user
        self.jobs = jobs
        self.projects = projects
        self.relations = relations
        self.skills = skills
        self.langues = langues
        self.contact = contact
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let user = aDecoder.decodeObject(forKey: "user") as! User
        let jobs = aDecoder.decodeObject(forKey: "jobs") as! [Job]
        let projects = aDecoder.decodeObject(forKey: "projects") as! [Project]
        let relations = aDecoder.decodeObject(forKey: "relations") as! Relation
        let skills = aDecoder.decodeObject(forKey: "skills") as! Skill
        let langues = aDecoder.decodeObject(forKey: "langues") as! Language
        let contact = aDecoder.decodeObject(forKey: "contact") as! Contact
        self.init(id: id, user: user, jobs: jobs,projects: projects,relations: relations,skills: skills,langues: langues,contact: contact)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(user, forKey: "user")
        aCoder.encode(jobs, forKey: "jobs")
        aCoder.encode(projects, forKey: "projects")
        aCoder.encode(relations, forKey: "relations")
        aCoder.encode(skills, forKey: "skills")
        aCoder.encode(langues, forKey: "langues")
        aCoder.encode(contact, forKey: "contact")
    }
    
}
