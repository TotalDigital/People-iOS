//
//  AppData
//  People at Total
//
//  Created by Florian Letellier on 13/02/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation
import SwiftyJSON

class AppData {
    
    class var sharedInstance: AppData {
        struct Static {
            static let instance = AppData()
        }
        return Static.instance
    }
    var profiles: [Profile] = []
    var projects: [Project] = []
    

    var currentUser = Profile() {
        didSet {
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: currentUser)
            userDefaults.set(encodedData, forKey: "currentUser")
            userDefaults.synchronize()
            
            //print("saved object: \(userDefaults.object(forKey: "currentUser"))")
            
            if let data = userDefaults.object(forKey: "currentUser") {
                //let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
               // print("myPeopleList: \(myPeopleList)")
            }else{
                print("There is an issue")
            }
            //dump("currentUser : \(NSKeyedUnarchiver.unarchiveObject(with: encodedData))")
            
        }
    }
    
    var relation = Relation() {
        didSet {
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: relation)
            userDefaults.set(encodedData, forKey: "relation")
            userDefaults.synchronize()
            
            //print("saved object: \(userDefaults.object(forKey: "currentUser"))")
            
            if let data = userDefaults.object(forKey: "relation") {
                //let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
                 //print("myPeopleList: \(myPeopleList)")
            }else{
                print("There is an issue")
            }
            //dump("currentUser : \(NSKeyedUnarchiver.unarchiveObject(with: encodedData))")
            
        }
    }
    
    var project = Project() {
        didSet {
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: project)
            userDefaults.set(encodedData, forKey: "project")
            userDefaults.synchronize()
            
            //print("saved object: \(userDefaults.object(forKey: "currentUser"))")
            
            if let data = userDefaults.object(forKey: "project") {
                //let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
                //print("myPeopleList: \(myPeopleList)")
            }else{
                print("There is an issue")
            }
            //dump("currentUser : \(NSKeyedUnarchiver.unarchiveObject(with: encodedData))")
            
        }
    }


    
    /*func getProjects() -> [Project] {
        let param: NSDictionary = [:]
        let url = "projects"
        APIUtility.sharedInstance.getAPICall(url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                let json = JSON(response)
                
                for i in 0..<json.count {
                    var project = Project()
                    project.id = json[i]["id"].intValue
                    project.title = json[i]["name"].stringValue
                    project.location = json[i]["project"].stringValue
                    self.projects.append(project)
                }
            }
        }
        return self.projects
    }
    
    func getProfiles() -> [Profile]{
        let param: NSDictionary = [:]
        let url = "users"
        APIUtility.sharedInstance.getAPICall(url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                //let status : Int = response?.value(forKey: "status") as! Int
                let json = JSON(response)
                print(json)
                var users: [User]
                for i in 0..<json.count {
                    //Do something you want
                    var projects: [Project] = []
                    var jobs: [Job] = []
                    var user = User()
                    
                    if let first_name = json[i]["first_name"].stringValue as? String, let last_name = json[i]["last_name"].stringValue as? String {
                        user.first_name = first_name
                        user.last_name = last_name
                    }
                    if let job = json[i]["job_title"].stringValue as? String {
                        user.job = "\(job)"
                    }
                    if let location = json[i]["office_address"].stringValue as? String {
                        user.location = "\(location)"
                    }
                    if let image = json[i]["profile_picture_url"].stringValue as? String {
                        user.image = image 
                    }
                    if let entity = json[i]["entity"].stringValue as? String {
                        user.entities = "\(entity)"
                    }
                    var skill = Skill()
                    for j in 0..<json[i]["skills"].count {
                        print("skill : \(json[i]["skills"][j]["name"].stringValue)")
                        if let s = json[i]["skills"][j]["name"].stringValue as? String {
                            skill.skills.append(s)
                            print(s)
                        }
                    }
                    var language = Language()
                    for j in 0..<json[i]["languages"].count {
                        if let l = json[i]["languages"][j].stringValue as? String {
                            language.langues.append(json[i]["languages"][j].stringValue)
                        }
                    }
                    var relations = Relation()
                    
                    for j in 0..<json[i]["relationships"].count {
                        if let relation = (json[i]["relationships"][j].dictionaryValue) as? Dictionary{
                            
                            let id = relation["id"]?.int
                            
                            switch ((relation["kind"]?.stringValue)!) {
                            case "is_manager_of":
                                print("kind : \((relation["kind"]?.stringValue)!)")
                                relations.managers.append(Int(id!))
                            case "is_managed_by":
                                relations.teamMember.append(id!)
                            case "is_colleague_of":
                                relations.colleagues.append(id!)
                            case "is_assistant_of":
                                relations.assistant.append(id!)
                            default:
                                break
                            }
                        }
                    }
                    
                    for j in 0..<json[i]["project_participations"].count {
                        var project = Project()
                        if let proj = (json[i]["project_participations"][j].dictionaryValue) as? Dictionary {
                            //project.title = proj["name"]?.stringValue
                            //project.location = proj["location"]?.stringValue
                            
                            project.id = proj["id"]?.intValue
                            project.start_date = proj["start_date"]?.stringValue
                            project.end_date = proj["end_date"]?.stringValue
                            project.description = proj["role_description"]?.stringValue
                            projects.append(project)
                        }
                    }
                    
                    for j in 0..<json[i]["jobs"].count {
                        var job = Job()
                        if let j = (json[i]["job"][j].dictionaryValue) as? Dictionary {
                            job.title = j["title"]?.stringValue
                            job.location = j["location"]?.stringValue
                            job.id = j["id"]?.intValue
                            job.start_date = j["start_date"]?.stringValue
                            jobs.append(job)
                        }
                    }
                    var contact = Contact()
                    if let email = json[i]["email"].stringValue as? String {
                        contact.email = email
                    }
                    if let phone = json[i]["phone"].stringValue as? String {
                        contact.phone_number = json[i]["phone"].stringValue
                    }
                    if let linkedin = json[i]["linkedin"].stringValue as? String {
                        contact.linkedin_profile = linkedin
                    }
                    if let wat = json[i]["wat_link"].stringValue as? String {
                        contact.wat_profile = wat
                    }
                    if let twitter = json[i]["twitter"].stringValue as? String {
                        contact.twitter_profile = twitter
                    }
                    if let agil = json[i]["agil"].stringValue as? String {
                        contact.agil_profile = agil
                    }
                    if let skype = json[i]["skype"].stringValue as? String {
                        contact.skipe = skype
                    }
                    let profile = Profile()
                    profile.user = user
                    profile.jobs = jobs
                    profile.contact = contact
                    profile.projects = projects
                    profile.langues = language
                    profile.skills = skill
                    profile.relations = relations
                    if let id = json[i]["id"].intValue as? Int {
                        profile.id = id
                    }
                    //dump(profile)
  
                    self.profiles.append(profile)
                    //defaults.set(self.profiles, forKey: "profiles")
                }
  
                
            }
            else {
                
            }
        }
        return self.profiles
    }*/

    func generateRelations() -> [String:[Int]] {
        
        var relations = self.profiles[0].relations
        var relationsArray: [String: [Int]] = [:]
        if relations.managers.count > 0 {
            relationsArray["Managers"] = relations.managers
        }
        if relations.assistant.count > 0 {
            relationsArray["Assistant"] = relations.assistant
        }
        if relations.teamMember.count > 0 {
            relationsArray["Team Members"] = relations.teamMember
        }
        if relations.colleagues.count > 0 {
            relationsArray["Colleagues"] = relations.colleagues
        }
        return relationsArray
    }
   /* func generateProfiles () -> [Profile] {
        let user1 = User()
        let user2 = User()
        let user3 = User()
        let user4 = User()
        let user5 = User()
        
        user1.name = "Gregori Fabre"
        user1.job = "Digital Advisor"
        user1.location = "Coupole, 12E41"
        user1.image = "gregori"
        user1.entities = "EP/SCR/TF-DIGITAL"
        
        user2.name = "Virginie fromaget"
        user2.job = "Performance and Innovation Manager"
        user2.location = "Michelet 1735"
        user2.image = "virginie"
        user2.entities = "MS/RH/GC"
        
        user3.name = "Yves Le Stunff"
        user3.job = "Digital Officer Subsurface"
        user3.location = "Paris"
        user3.image = "yves"
        user3.entities = "EP/SCR/TF-DIGITAL"
        
        user4.name = "Gilles Cochevelou"
        user4.job = "CDO"
        user4.location = "Michelet A1215"
        user4.image = "gilles"
        user4.entities = "STI/CDO"
        
        user5.name = "Pierre de Milly"
        user5.job = "Schoolab consultant"
        user5.location = "Paris"
        user5.image = "pierre"
        user5.entities = "EP/SCR/TF-DIGITAL"
        
        var users = [user1, user2, user3, user4, user5]
        
        // Job greg
        var jobs: [Job] = []
        let job1 = Job()
        job1.title = "Digital advisor E&P"
        job1.company = "Total"
        job1.date = "From May 2016"
        job1.description = "Advisor for digital initiatives in subsurface"
        job1.location = "Tour Coupole, Paris"
        
        // Job fromaget
        let job2 = Job()
        job2.title = "Exploration Geoscientist"
        job2.date = "September 2014 - May 2016"
        job2.description = "Deep & ultra deep offshore exploration  Haute Mer geophysics MTPS geology & geophysics Nkossa geology & geophysics Publications : AAPG ICE 2013 speaker : A Lobe Story Through Spectral Decomposition AAPG ICE 2013 poster presenter : Illumination Using RTM and Kirchhoff Depth Processing to Enlighten the Geoscientists in Subsalt Domain"
        job2.location = "Tour Coupole, Paris"
        
        let job3 = Job()
        job3.title = "Performance and Innovation Manager"
        job3.date = "From September 2016"
        job3.description = "Innovation and Performance project manager for Career Managers Team in MS Branch"
        job3.location = "Michelet 1735"
        
        let job4 = Job()
        job4.title = "Gestionnaire de Carrières"
        job4.date = "From July 2012 to August 2016"
        job4.description = "En charge de la population OETAM de Michelet + stations d'aviation + dépôts pétroliers en France"
        
        let job5 = Job()
        job5.title = "Responsable du Service Clients GR"
        job5.date = "From October 2008 to June 2011"
        job5.location = "Spazio"
        job5.description = "Responsable du service clients GR + responsable Qualité + en charge du suivi des fraudes et pertes/profits"
        
        let job6 = Job()
        job6.title = "Chef de Secteur Cartes GR"
        job6.date = "From October 2005 to September 2008"
        job6.location = "Lyon"
        job6.description = "En charge du développement commercial des cartes GR sur le département du Rhône"
        
        // job yves
        
        let job7 = Job()
        job7.title = "Subsurface Digital Officer (EP/SCR)"
        job7.date = "From September 2015 (current)"
        job7.location = "Paris"
        job7.description = "Responsible of Digital Transformation of Subsurface domain(Geosciences + Drilling) Coordination of E&P Digital Transformation"
        
        let job8 = Job()
        job8.title = "Research and Development Strategy and Prospective Senior Manager (EP/SCR/RD)"
        job8.date = "From September 2012 to September 2015"
        job8.location = "Paris"
        job8.description = "In charge of defining E&P R&D strategy. Responsible of Prospective Labs (Nanotechnology, Robotics, Biotechnology, Numerical Methods, Image Processing)"
        
        let job9 = Job()
        job9.title = "Architect (APP)"
        job9.date = "From September 2009 to September 2012"
        job9.location = "Paris"
        job9.description = "In charge of development studies for APC area (Indonesia, Malysia, Vietnam,..)"
        
        // job gilles
        
        let job10 = Job()
        job10.title = "CDO"
        job10.date = "From September 2015"
        job10.location = "Paris (Michelet)"
        job10.description = "In charge of the Group digital transformation"
        
        let job11 = Job()
        job11.title = "VP Learning, Education, University"
        job11.date = "From January 2010 to September 2015"
        job11.location = "Paris"
        job11.description = "In charge of learning & development for the Group"
        
        let job12 = Job()
        job12.title = "VP R&D Gas & Power"
        job12.date = "From October 2007 to December 2009"
        job12.location = "Paris"
        job12.description = "In charge of R&D for solar energy, biotechnologies, energy storage, CO2 capture and transformation"
        
        let job13 = Job()
        job13.title = "VP Renewables"
        job13.date = "From September 2003 to September 2007"
        job13.location = "Paris"
        job13.description = "In charge of solar business and wind projects"
        
        // job pierre
        
        let job14 = Job()
        job14.title = "TOI Project Manager"
        job14.date = "From April 2016"
        job14.location = "21 rue de Clery, Paris"
        job14.description = "Leading the team working on the TOI aka JustOne project. We worked for 3 months inside the Schoolab incubator, designing and prototyping."
        
        
        var projects: [Project] = []
        let project1 = Project()
        project1.title = "Just One Total"
        project1.date = "From May 2016"
        project1.location = "Paris, France"
        project1.description = "Sponsor for Just One Project"
        project1.members = [user2, user3]
        
        let project2 = Project()
        project2.title = "Benchmark visio conferencing tools"
        project2.date = "February 2015 - July 2015"
        project2.description = "In-house interpretation plateform"
        project2.location = "CSTJF, Pau"
        project2.members = [user1, user3]
        
        let project3 = Project()
        project3.title = "ATLAS"
        project3.date = "From March 2010 to June 2012"
        project3.location = "Spazio"
        project3.members = [user5, user4]
        
        let project4 = Project()
        project4.title = "People"
        project4.date = "From July 2016"
        project4.description = "Building the JustOne PLatform prototype"
        project4.members = [user1, user3, user4]
        
        
        let relations1: Relation = Relation()
        relations1.managers = [user3, user4]
        relations1.colleagues = [user2, user3]
        relations1.assistant = [user5, user2]
        relations1.teamMember = [user5, user4]
        
        let relations2: Relation = Relation()
        relations2.managers = []
        relations2.colleagues = [user1]
        relations2.assistant = [user4]
        relations2.teamMember = [user5]
        
        let relations3: Relation = Relation()
        relations3.managers = [user4]
        relations3.colleagues = []
        relations3.assistant = []
        relations3.teamMember = [user1]
        
        let relations4: Relation = Relation()
        relations4.managers = []
        relations4.colleagues = []
        relations4.assistant = [user3]
        relations4.teamMember = []
        
        let relations5: Relation = Relation()
        relations5.managers = [user1]
        relations5.colleagues = []
        relations5.assistant = []
        relations5.teamMember = []
        
        var skill1: Skill = Skill()
        skill1.skills = ["digital", "structural", "geology", "geophysics", "innovation","braii"]
        
        var skill2: Skill = Skill()
        skill2.skills = ["digital", "marketing", "hr", "sales"]
        
        var skill3: Skill = Skill()
        skill3.skills = ["digital", "geophysics", "exploration", "geosciences", "seismic imaging", "r&d", "petroleum engineering"]
        
        var skill4: Skill = Skill()
        skill4.skills = ["digital",
                         "innovation",
                         "renewable energy",
                         "solar energy",
                         "wind energy",
                         "power plant"]
        
        var skill5: Skill = Skill()
        skill5.skills = ["ruby on rails",
                         "html",
                         "css",
                         "web development",
                         "web design",
                         "digital"]
        
        let langue1: Language = Language()
        langue1.langues = ["French", "English", "German"]
        
        let langue2: Language = Language()
        langue2.langues = ["French", "English"]
        
        let langue3: Language = Language()
        langue3.langues = ["French", "English", "Spanish"]
        
        let contact1: Contact = Contact()
        contact1.email = "gregori.fabre@total.com"
        contact1.phone_number = "+33 6 13 71 41 79"
        contact1.linkedin_profile = "https://fr.linkedin.com/in/fletelli"
        contact1.agil_profile = "agil/gregori"
        contact1.twitter_profile = "https://twitter.com/fletelli"
        contact1.wat_profile = "wat/gregori"
        contact1.skipe = "skype/gregori"
        
        let profile1 = Profile()
        profile1.user = user1
        profile1.jobs = [job1, job2]
        profile1.projects = [project1, project2]
        profile1.relations = relations1
        profile1.skills = skill1
        profile1.langues = langue1
        profile1.contact = contact1
        
        let profile2 = Profile()
        profile2.user = user2
        profile2.jobs = [job3, job4]
        profile2.projects = [project3]
        profile2.relations = relations2
        profile2.skills = skill2
        profile2.langues = langue2
        profile2.contact = contact1
        
        let profile3 = Profile()
        profile3.jobs = [job7, job8, job9]
        profile3.user = user3
        profile3.projects = [project3, project4]
        profile3.relations = relations3
        profile3.skills = skill3
        profile3.langues = langue3
        profile3.contact = contact1
        
        let profile4 = Profile()
        profile4.jobs = [job10, job11, job12, job13]
        profile4.user = user4
        profile4.projects = [project1, project2]
        profile4.relations = relations4
        profile4.skills = skill4
        profile4.langues = langue1
        profile4.contact = contact1
        
        let profile5 = Profile()
        profile5.user = user5
        profile5.jobs = [job14]
        profile5.projects = [project4, project1]
        profile5.relations = relations5
        profile5.skills = skill5
        profile5.langues = langue2
        profile5.contact = contact1
        
        var profiles = [profile1, profile2, profile3, profile4, profile5]
        return profiles
    }*/
}
