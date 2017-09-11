//
//  MyRelationViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 5/19/17.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit
import SwiftyJSON


class MyRelationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, relationsMemberTableViewCellDelegate {

    internal func closeFriendsTapped(at index: IndexPath, sender: AnyObject, user_id : Int) {
        getUserFromIDForRelationship(user_id: user_id,sender:sender)
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewMember: UITableView!
    
    @IBOutlet var tableViewManager: UITableView!
    
    @IBOutlet var tableViewColleague: UITableView!
    
    @IBOutlet var tableViewRelationMember: UITableView!
    
    @IBOutlet var tableViewTeam: UITableView!
    
    @IBOutlet var tableViewAssitant: UITableView!
    
    var relations: [String: [Profile]] = [:]
    
    var currentRelation: String = ""
    
    var access_token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello from relations")
        if Reachability.isConnectedToNetwork() == false {
            print("no network")
            let userDefaults = UserDefaults.standard
            
            if let data = userDefaults.object(forKey: "currentUser") {
                let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
                print("myPeopleList: \(myPeopleList)")
                AppData.sharedInstance.currentUser = (myPeopleList as? Profile)!
            }else{
                print("There is an issue")
            }
            
            //AppData.sharedInstance.currentUser = (decodedDataObject as? Profile)!
            /*if let decoded : Data = userDefaults.object(forKey: "currentUser") as? Data {
                print("currendUser : ")
                NSKeyedUnarchiver.setClass(Profile.self, forClassName: "Profile")
                
                NSKeyedArchiver.setClassName("Profile", for: Profile.self)
                AppData.sharedInstance.currentUser = (NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Profile)!
                
               
            }*/
            
        }
        print("relations view")
        self.relations = relationsArray(relations: AppData.sharedInstance.currentUser.relations)
        
        let defaults = UserDefaults.standard
        if let objAccess_token = defaults.string(forKey: "accessToken") {
            access_token = objAccess_token
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewManager.delegate = self
        tableViewManager.dataSource = self
        
        tableViewColleague.delegate = self
        tableViewColleague.dataSource = self
        
        tableViewAssitant.delegate = self
        tableViewAssitant.dataSource = self
        
        tableViewTeam.delegate = self
        tableViewTeam.dataSource = self
        
        tableViewMember.delegate = self
        tableViewMember.dataSource = self
        
        tableViewManager.separatorStyle = .none
        tableViewColleague.separatorStyle = .none
        tableViewAssitant.separatorStyle = .none
        tableViewTeam.separatorStyle = .none
        tableViewMember.separatorStyle = .none
        
        tableView.reloadData()
        tableViewManager.reloadData()
        tableViewColleague.reloadData()
        tableViewAssitant.reloadData()
        tableViewTeam.reloadData()
        tableViewMember.reloadData()
        
        
        //Swift 3 Change
        tableView.contentInset = UIEdgeInsets.zero
        tableViewManager.contentInset = UIEdgeInsets.zero
        tableViewColleague.contentInset = UIEdgeInsets.zero
        tableViewAssitant.contentInset = UIEdgeInsets.zero
        tableViewTeam.contentInset = UIEdgeInsets.zero
        tableViewMember.contentInset = UIEdgeInsets.zero
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCurrentUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
//            return self.relations.count
            if self.relations.count > 0 {
                return 4
            }
            return 0
        }
        else if tableView == tableViewManager {
            if relations["Managers"] != nil {
                return (relations["Managers"]?.count)!
            }
        }
        else if tableView == tableViewAssitant {
            if relations["Assistant"] != nil {
                return (relations["Assistant"]?.count)!
            }
        }
        else if tableView == tableViewTeam {
            if relations["Team Members"] != nil {
                return (relations["Team Members"]?.count)!
            }
        }
        else if tableView == tableViewColleague {
            if relations["Colleagues"] != nil {
                return (relations["Colleagues"]?.count)!
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.tableView {
            return 55.0
        }
        else if tableView == self.tableViewMember {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section:Int) -> UIView? {
        
        let headerView = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.frame.width, height: 55)))
        if tableView == self.tableView {
            
            let label = NewLabel2(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
            label.font = UIFont(name: "HelveticaNeue-bold", size: 14)!
            label.textColor = UIColor(red: 112/255, green: 113/255, blue: 115/255, alpha: 1.0)
            
            label.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
            label.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), thickness: 1.0)
            label.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), thickness: 1.0)
            
            
            //headerView.bringSubview(toFront: label)
            // headerView.backgroundColor = UIColor.red/*(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)*/
            switch (section) {
            case 0:
                label.text = "RELATIONS"
            case 1:
                label.text = "PROJECTS"
            case 2:
                label.text = "RELATIONS"
            case 3:
                label.text = "MORE INFOS"
            default:
                label.text = "Extra Testing"
                break
            }
            headerView.addSubview(label)
            headerView.layoutIfNeeded()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "RELATIONS"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAtIndexPath 222")
        //        self.selectedCellIndexPath = nil
        
        if tableView == tableViewManager {
            if let user_id = relations["Managers"]?[indexPath.row].user?.user_id {
                //in value you will get non optional value
                pushUserFromID(user_id: user_id)
            }
        }
        else if tableView == tableViewAssitant {
            if let user_id = relations["Assistant"]?[indexPath.row].user?.user_id {
                //in value you will get non optional value
                pushUserFromID(user_id: user_id)
            }
        }
        else if tableView == tableViewTeam {
            if let user_id = relations["Team Members"]?[indexPath.row].user?.user_id {
                //in value you will get non optional value
                pushUserFromID(user_id: user_id)
            }
        }
        else if tableView == tableViewColleague {
            
            if let user_id = relations["Colleagues"]?[indexPath.row].user?.user_id {
                //in value you will get non optional value
                pushUserFromID(user_id: user_id)
            }
            //            return (relations["Colleagues"]?.count)!
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == self.tableViewColleague {
            return 50 /*+ 20.0 * CGFloat(relations["Colleagues"]!.count)*/
        }
        if tableView == self.tableViewManager {
            return 50 /*+ 20.0 * CGFloat(relations["Managers"]!.count)*/
            
        }
        if tableView == self.tableViewTeam {
            return 50 /*+ 20.0 * CGFloat(relations["Team Members"]!.count)*/
            
        }
        if tableView == self.tableViewAssitant {
            return 50 /*+ 20.0 * CGFloat(relations["Assistant"]!.count)*/
        }
        
        if tableView == self.tableView && indexPath.section == 0 {
//            switch Array(relations.keys)[indexPath.row] {
//            case "Managers":
//                return 40 + CGFloat(relations["Managers"]!.count) * 50.0
//            case "Assistant":
//                return 40 + CGFloat(relations["Assistant"]!.count) * 50.0
//            case "Colleagues":
//                return 40 + CGFloat(relations["Colleagues"]!.count) * 50.0
//            case "Team Members":
//                return 40 + CGFloat(relations["Team Members"]!.count) * 50.0
//            default: break
//            }
            if relations.count > 0 {
                if indexPath.row == 0 {
                    if (relations["Managers"] != nil) {
                        return 40 + CGFloat(relations["Managers"]!.count) * 50.0
                    }
                }
                else if indexPath.row == 1 {
                    if (relations["Assistant"] != nil) {
                        return 40 + CGFloat(relations["Assistant"]!.count) * 50.0
                    }
                }
                else if indexPath.row == 2 {
                    if (relations["Team Members"] != nil) {
                        return 40 + CGFloat(relations["Team Members"]!.count) * 50.0
                    }
                }
                else if indexPath.row == 3 {
                    if (relations["Colleagues"] != nil) {
                        return 40 + CGFloat(relations["Colleagues"]!.count) * 50.0
                    }
                }
            }
            return 0
        }
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = UITableViewCell()
        if tableView == self.tableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "relationCell", for: indexPath as IndexPath) as! relationTableViewCell
            switch (indexPath.row) {
            case 0:
                if (relations["Managers"] != nil) {
                    var tableViewRelation: UITableView = UITableView()
                    var height: CGFloat = 0
                    //                    switch Array(relations.keys)[indexPath.row] {
                    //                    case "Managers":
                    tableViewRelation = tableViewManager
                    height = CGFloat(relations["Managers"]!.count) * 50.0
                    //                    case "Assistant":
                    //                        tableViewRelation = tableViewAssitant
                    //                        height = CGFloat(relations["Assistant"]!.count) * 50.0
                    //                    case "Colleagues":
                    //                        tableViewRelation = tableViewColleague
                    //                        height = CGFloat(relations["Colleagues"]!.count) * 50.0
                    //                    case "Team Members":
                    //                        tableViewRelation = tableViewTeam
                    //                        height = CGFloat(relations["Team Members"]!.count) * 50.0
                    //                    default: break
                    //                    }
                    tableViewRelation.frame = CGRect(x:0,y: 40,width: Int(UIScreen.main.bounds.width),height: Int(height))
                    //                    cell.relationType.text = Array(relations.keys)[indexPath.row]
                    //                    self.currentRelation = Array(relations.keys)[indexPath.row]
                    tableViewRelation.reloadData()
                    cell.relationType.text = "Managers"
                    self.currentRelation = "Managers"
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation)
                }
            case 1:
                if (relations["Assistant"] != nil) {
                    var tableViewRelation1: UITableView = UITableView()
                    var height: CGFloat = 0.0
                    //                    switch Array(relations.keys)[indexPath.row] {
                    //                    case "Managers":
                    //                        tableViewRelation1 = tableViewManager
                    //                        height = CGFloat(relations["Managers"]!.count) * 50.0
                    //                    case "Assistant":
                    tableViewRelation1 = tableViewAssitant
                    height = CGFloat(relations["Assistant"]!.count) * 50.0
                    //                    case "Colleagues":
                    //                        tableViewRelation1 = tableViewColleague
                    //                        height = CGFloat(relations["Colleagues"]!.count) * 50.0
                    //                    case "Team Members":
                    //                        tableViewRelation1 = tableViewTeam
                    //                        height = CGFloat((relations["Team Members"]?.count)!) * 50.0
                    //                    default: break
                    //                    }
                    tableViewRelation1.frame = CGRect(x:0,y: 40,width: Int(UIScreen.main.bounds.width),height: Int(height))
                    tableViewRelation1.reloadData()
                    cell.relationType.text = "Assistant"
                    self.currentRelation = "Assistant"
                    
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation1)
                }
            case 2:
                if (relations["Team Members"] != nil) {
                    var tableViewRelation2: UITableView = UITableView()
                    var height: CGFloat = 0.0
                    //                    switch Array(relations.keys)[indexPath.row] {
                    //                    case "Managers":
                    //                        tableViewRelation2 = tableViewManager
                    //                        height = CGFloat(relations["Managers"]!.count) * 50.0
                    //                    case "Assistant":
                    //                        tableViewRelation2 = tableViewAssitant
                    //                        height = CGFloat(relations["Assistant"]!.count) * 50.0
                    //                    case "Colleagues":
                    //                        tableViewRelation2 = tableViewColleague
                    //                        height = CGFloat(relations["Colleagues"]!.count) * 50.0
                    //                    case "Team Members":
                    tableViewRelation2 = tableViewTeam
                    height = CGFloat(relations["Team Members"]!.count) * 50.0
                    //                    default: break
                    //                    }
                    tableViewRelation2.frame = CGRect(x:0,y: 40,width: Int(UIScreen.main.bounds.width),height: Int(height))
                    tableViewRelation2.reloadData()
                    cell.relationType.text = "Team Members"
                    self.currentRelation = "Team Members"
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation2)
                }
            case 3:
                if (relations["Colleagues"] != nil) {
                    var tableViewRelation3: UITableView = UITableView()
                    var height: CGFloat = 0.0
                    //                    switch Array(relations.keys)[indexPath.row] {
                    //                    case "Managers":
                    //                        tableViewRelation3 = tableViewManager
                    //                        height = CGFloat(relations["Managers"]!.count) * 50.0
                    //                    case "Assistant":
                    //                        tableViewRelation3 = tableViewAssitant
                    //                        height = CGFloat(relations["Assistant"]!.count) * 50.0
                    //                    case "Colleagues":
                    tableViewRelation3 = tableViewColleague
                    height = CGFloat(relations["Colleagues"]!.count) * 50.0
                    //                    case "Team Members":
                    //                        tableViewRelation3 = tableViewTeam
                    //                        height = CGFloat(relations["Team Members"]!.count) * 50.0
                    //                    default: break
                    //                    }
                    tableViewRelation3.frame = CGRect(x:0,y: 40,width: Int(UIScreen.main.bounds.width),height: Int(height))
                    tableViewRelation3.reloadData()
                    cell.relationType.text = "Colleagues"
                    self.currentRelation = "Colleagues"
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation3)
                }
            default:
                return cell
            }
            return cell
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "relationMemberCell", for: indexPath as IndexPath) as! relationsMemberTableViewCell
            cell.delegate = self
            cell.indexPath = indexPath
            
            if let user_id = relations[self.currentRelation]?[indexPath.row].user?.user_id {
                cell.user_id = user_id
            }
            
            cell.relationMemberJob.text = relations[self.currentRelation]?[indexPath.row].user?.job
            cell.relationMemberName.text = "\((relations[self.currentRelation]?[indexPath.row].user?.first_name)!) \((relations[self.currentRelation]?[indexPath.row].user?.last_name)!)"
            //cell.relationMemberPicture.image = UIImage(named: (relations[self.currentRelation]?[indexPath.row].user?.image!)!)?.circleMasked
            if ((relations[self.currentRelation]?[indexPath.row].user?.image!) != nil) {
                cell.relationMemberPicture.downloadedFrom(link: (relations[self.currentRelation]?[indexPath.row].user?.image!)!)
            }
            cell.relationMemberPicture.setImageForName(string: "\((relations[self.currentRelation]?[indexPath.row].user?.first_name)!) \((relations[self.currentRelation]?[indexPath.row].user?.last_name)!)", backgroundColor: nil, circular: true, textAttributes: nil)

            cell.closeFriendsBtn.isHidden = true
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
            var titleText = "Remove"
            let Relation = UITableViewRowAction(style: .normal, title: titleText) { action, index in
            let cell = tableView.cellForRow(at: index) as! relationsMemberTableViewCell;
            let row = index.row
            let section = index.section
            var profile: Profile = Profile()
    
                if tableView == self.tableViewManager {
                    profile = (self.relations["Managers"]?[row])!
                }
                else if tableView == self.tableViewAssitant {
                    profile = (self.relations["Assistant"]?[row])!
                }
                else if tableView == self.tableViewTeam {
                    profile = (self.relations["Team Members"]?[row])!
                }
                else if tableView == self.tableViewColleague {
                    profile = (self.relations["Colleagues"]?[row])!
                    
                }
            self.toConnect(profile: profile, index: index)
            
                
            tableView.endEditing(true)
            tableView.reloadData()
        }
        Relation.backgroundColor = .lightGray
        
        return [Relation]
    }
    
    func toConnect(profile: Profile, index: IndexPath) {
        
   
            let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Do you want to remove your relationship?", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            let removeAction: UIAlertAction = UIAlertAction(title: "Remove", style: .destructive) { action -> Void in
                //Just dismiss the action sheet
                 print("here : \(dump(profile.user.first_name))")
                self.removeRelationShipWithID(relationship_id: profile.relations.relationshipID)
            }
            actionSheetController.addAction(cancelAction)
            actionSheetController.addAction(removeAction)
            self.present(actionSheetController, animated: true, completion: nil)

    }
    
    func pushUserFromID(user_id : Int) {
        
        if let profileVC = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "profileViewController") as? profileViewController {
            
            profileVC.profile_id = user_id
            profileVC.access_token = self.access_token
            
            if let navigator = self.navigationController {
                navigator.pushViewController(profileVC, animated: true)
            }
        }
    }
    
    func getUserFromID(user_id : Int) {
        
        let param: NSDictionary = [:]
        
        let url = "users/" + "\(user_id)"
        var profiles:[Profile] = []
        
        APIUtility.sharedInstance.getAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                //let status : Int = response?.value(forKey: "status") as! Int
                dump(response)
                let json = JSON(response)[0]
                //dump(response)
                //dump("json : \(json)")
                var users: [User]
                
                //Do something you want
                var projects: [Project] = []
                var jobs: [Job] = []
                var degrees: [Degree] = []
                var user = User()
                var isRelationAvailable: Bool = false
                var relationshipID: Int = 0
                
                if let first_name = json["first_name"].stringValue as? String, let last_name = json["last_name"].stringValue as? String {
                    user.first_name = "\(first_name)"
                    user.last_name = "\(last_name)"
                }
                if let job = json["job_title"].stringValue as? String {
                    user.job = "\(job)"
                }
                if let location = json["office_address"].stringValue as? String {
                    user.location = "\(location)"
                }
                if let image = json["picture_url"].stringValue as? String {
                    user.image =  image
                }
                if let entity = json["entity"].stringValue as? String {
                    user.entities = "\(entity)"
                }
                var skill = Skill()
                for j in 0..<json["skills"].count {
                    print("s : \(json["skills"][j]["name"].stringValue)")
                    
                    if let s = json["skills"][j]["name"].stringValue as? String {
                        skill.skills.append(s)
                    }
                }
                print("skills : \(skill.skills)")
                var language = Language()
                for j in 0..<json["languages"].count {
                    if let l = json["languages"][j]["name"].stringValue as? String {
                        language.langues.append(l)
                    }
                }
                var relations = Relation()
                
                for j in 0..<json["relationships"].count {
                    if let relation = json["relationships"][j].dictionaryObject{
                        
                        //let id = relation["target"]?["user_id"].int
                        let profile = Profile()
                        let user = User()
                        
                        if let target = relation["target"] as? Dictionary<String, AnyObject>
                        {
                            user.first_name = target["first_name"] as? String
                            user.last_name = target["last_name"] as? String
                            user.image = target["picture_url"] as? String
                            user.job = target["job_title"] as? String
                            user.user_id = (target["id"] as? Int)!
                        }
                        
                        
                        
                   
                            relationshipID = relation["id"] as! Int
                 
                        
                        profile.user = user
                        switch (relation["kind"] as! String) {
                        case "is_manager_of":
                            print("kind : \(relation["kind"] as! String)")
                            relations.teamMembers_profile.append(profile)
                        case "is_managed_by":
                            relations.managers_profile.append(profile)
                        case "is_colleague_of":
                            relations.colleagues_profile.append(profile)
                        case "is_assisted_by":
                            relations.assistants_profile.append(profile)
                        default:
                            break
                        }
                    }
                }
                dump("relations : \(relations)")
                
                let profile_id = json["id"].intValue
                for j in 0..<json["projects"].count {
                    
                    let project = Project()
                    let proj = (json["projects"][j])
                    project.title = proj["name"].stringValue
                    project.location = proj["location"].stringValue
                    project.objDescription = proj["project_participations"][0]["role_description"].stringValue
                    project.id = proj["id"].intValue
                    project.start_date = proj["project_participations"][0]["start_date"].stringValue
                    project.end_date = proj["project_participations"][0]["end_date"].stringValue
                    project.participation_id = proj["project_participations"][0]["id"].intValue
                    //print("project.participation_id : \(project.participation_id)")
                    for k in 0..<proj["project_participations"].count {
                        let participants = proj["project_participations"].arrayValue
                        print("k : \(k)")
                        dump("participants : \(participants)")
                        
                        let participant = participants[k].dictionaryValue
                        var profile = Profile()
                        var user = User()
                        profile.id = (participant["user_id"]?.intValue)!
                        user.user_id = (participant["user_id"]?.intValue)!
                        user.first_name = participant["user_first_name"]?.stringValue
                        user.last_name = participant["user_last_name"]?.stringValue
                        user.image = participant["user_picture_url"]?.stringValue
                        profile.user = user
                        project.members_profile.append(profile)
                    }
                    dump("project members : \(project.members_profile)")
                    projects.append(project)
                }

                for j in 0..<json["jobs"].count {
                    var job = Job()
                    
                    
                    if let j = json["jobs"][j].dictionaryObject {
                        job.title = j["title"] as? String
                        job.location = j["location"] as? String
                        job.id = j["id"] as? Int
                        job.start_date = j["start_date"]as? String
                        job.objDescription = j["description"] as? String
                        jobs.append(job)
                    }
                }
                for j in 0..<json["degrees"].count {
                    var degree = Degree()
                    if let j = json["degrees"][j].dictionaryObject {
                        degree.title = j["title"] as? String
                        if let objEntry_Year = j["entry_year"]
                        {
                            if !(objEntry_Year is NSNull) {
                                degree.entry_year = "\(objEntry_Year as! Int)"
                            }
                            
                        }
                        if let objGraduation_year = j["graduation_year"]
                        {
                            if !(objGraduation_year is NSNull) {
                                degree.graduation_year = "\(objGraduation_year as! Int)"
                            }
                        }
                        degree.user_id = j["user_id"]as? Int
                        
                        
                        let school : NSDictionary = (j["school"]) as! NSDictionary
                        
                        degree.school_id = school["id"] as? Int
                        degree.school = school["name"] as? String
                        degrees.append(degree)
                    }
                }
                
                var contact = Contact()
                if let email = json["email"].stringValue as? String {
                    contact.email = email
                }
                if let phone = json["phone"].stringValue as? String {
                    contact.phone_number = json["phone"].stringValue
                }
                if let linkedin = json["linkedin"].stringValue as? String {
                    contact.linkedin_profile = linkedin
                }
                if let wat = json["wat_link"].stringValue as? String {
                    contact.wat_profile = wat
                }
                if let twitter = json["twitter"].stringValue as? String {
                    contact.twitter_profile = twitter
                }
                if let agil = json["agil"].stringValue as? String {
                    contact.agil_profile = agil
                }
                if let skype = json["skype"].stringValue as? String {
                    contact.skipe = skype
                }
                let profile = Profile()
                profile.user = user
                profile.jobs = jobs.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                profile.contact = contact
                profile.projects = projects.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                profile.langues = language
                profile.skills = skill
                profile.relations = relations
                profile.relations.isRelationAvailable = isRelationAvailable
                profile.relations.relationshipID = relationshipID
                print("relationshi[ID : \(relationshipID)")
                profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                
                if let id = json["id"].intValue as? Int {
                    profile.id = id
                }
                dump(profile)
                profiles.append(profile)
                
                var objProfile = Profile()
                objProfile = profiles[0]
                
                if let profileVC = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "profileViewController") as? profileViewController {
                    
                    profileVC.profile = objProfile
                    profileVC.relations = relationsArray(relations: relations)
                    profileVC.access_token = self.access_token
                    
                    if let navigator = self.navigationController {
                        navigator.pushViewController(profileVC, animated: true)
                    }
                }
                
                
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getCurrentUser() {
        
        let param: NSDictionary = [:]
        
        var url = "users/profile"
        
        APIUtility.sharedInstance.getAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                //let status : Int = response?.value(forKey: "status") as! Int
                dump(response)
                let json = JSON(response)[0]
                //dump(response)
                //dump("json : \(json)")
                var users: [User]
                
                //Do something you want
                var projects: [Project] = []
                var jobs: [Job] = []
                var degrees: [Degree] = []
                let user = User()
                var isRelationAvailable: Bool = false
                var relationshipID: Int = 0
                
                
                if let first_name = json["first_name"].stringValue as? String, let last_name = json["last_name"].stringValue as? String {
                    user.first_name = "\(first_name)"
                    user.last_name = "\(last_name)"
                }
                if let job = json["job_title"].stringValue as? String {
                    user.job = "\(job)"
                }
                if let location = json["office_address"].stringValue as? String {
                    user.location = "\(location)"
                }
                if let image = json["picture_url"].stringValue as? String {
                    user.image =  image
                }
                if let entity = json["entity"].stringValue as? String {
                    user.entities = "\(entity)"
                }
                if let external = json["external"].boolValue as? Bool {
                    user.is_external = external
                }
                var skill = Skill()
                for j in 0..<json["skills"].count {
                    print("s : \(json["skills"][j]["name"].stringValue)")
                    
                    if let s = json["skills"][j]["name"].stringValue as? String {
                        skill.skills.append(s)
                    }
                    if let s : Int = json["skills"][j]["id"].intValue {
                        skill.skillsIds.append(s)
                    }
                }
                print("skills : \(skill.skills)")
                var language = Language()
                for j in 0..<json["languages"].count {
                    if let l = json["languages"][j]["name"].stringValue as? String {
                        language.langues.append(l)
                    }
                    if let s : Int = json["languages"][j]["id"].intValue {
                        language.languesIds.append(s)
                    }
                }
                var relations = Relation()
                
                for j in 0..<json["relationships"].count {
                    if let relation = json["relationships"][j].dictionaryObject{
                        
                        //let id = relation["target"]?["user_id"].int
                        let profile = Profile()
                        let user = User()
                        
                        if let target = relation["target"] as? Dictionary<String, AnyObject>
                        {
                            user.first_name = target["first_name"] as? String
                            user.last_name = target["last_name"] as? String
                            user.image = target["picture_url"] as? String
                            user.job = target["job_title"] as? String
                            user.user_id = (target["id"] as? Int)!
                        }

                        
                     
                            relationshipID = relation["id"] as! Int
                        print("current user id  relation : \(relationshipID)")
                        
                        profile.user = user
                        profile.relations.relationshipID = relationshipID
                        switch (relation["kind"] as! String) {
                        case "is_manager_of":
                            print("kind : \(relation["kind"] as! String)")
                            relations.teamMembers_profile.append(profile)
                        case "is_managed_by":
                            relations.managers_profile.append(profile)
                        case "is_colleague_of":
                            relations.colleagues_profile.append(profile)
                        case "is_assisted_by":
                            relations.assistants_profile.append(profile)
                        default:
                            break
                        }
                        
                        let id = relation["id"] as! Int
                        
                        switch (relation["kind"] as! String) {
                        case "is_manager_of":
                            print("kind : \(relation["kind"] as! String)")
                            relations.managers.append(Int(id))
                        case "is_managed_by":
                            relations.teamMember.append(id)
                        case "is_colleague_of":
                            relations.colleagues.append(id)
                        case "is_assistant_of":
                            relations.assistant.append(id)
                        default:
                            break
                        }
                    }
                }
                let profile_id = json["id"].intValue
                for j in 0..<json["projects"].count {
                    
                    let project = Project()
                    let proj = (json["projects"][j])
                    project.title = proj["name"].stringValue
                    project.location = proj["location"].stringValue
                    project.objDescription = proj["project_participations"][0]["role_description"].stringValue
                    project.id = proj["id"].intValue
                    project.start_date = proj["project_participations"][0]["start_date"].stringValue
                    project.end_date = proj["project_participations"][0]["end_date"].stringValue
                    project.participation_id = proj["project_participations"][0]["id"].intValue
                    //print("project.participation_id : \(project.participation_id)")
                    for k in 0..<proj["project_participations"].count {
                        let participants = proj["project_participations"].arrayValue
                        print("k : \(k)")
                        dump("participants : \(participants)")
                        
                        let participant = participants[k].dictionaryValue
                        var profile = Profile()
                        var user = User()
                        profile.id = (participant["user_id"]?.intValue)!
                        user.user_id = (participant["user_id"]?.intValue)!
                        user.first_name = participant["user_first_name"]?.stringValue
                        user.last_name = participant["user_last_name"]?.stringValue
                        user.image = participant["user_picture_url"]?.stringValue
                        profile.user = user
                        project.members_profile.append(profile)
                    }
                    dump("project members : \(project.members_profile)")
                    projects.append(project)
                }
                
                for j in 0..<json["jobs"].count {
                    var job = Job()
                    if let j = json["jobs"][j].dictionaryObject {
                        job.title = j["title"] as? String
                        job.location = j["location"] as? String
                        job.id = j["id"] as? Int
                        job.start_date = j["start_date"]as? String
                        job.objDescription = j["description"] as? String
                        jobs.append(job)
                    }
                }
                for j in 0..<json["degrees"].count {
                    var degree = Degree()
                    if let j = json["degrees"][j].dictionaryObject {
                        degree.title = j["title"] as? String
                        if let objEntry_Year = j["entry_year"]
                        {
                            if !(objEntry_Year is NSNull) {
                                degree.entry_year = "\(objEntry_Year as! Int)"
                            }
                            
                        }
                        if let objGraduation_year = j["graduation_year"]
                        {
                            if !(objGraduation_year is NSNull) {
                                degree.graduation_year = "\(objGraduation_year as! Int)"
                            }
                        }
                        degree.user_id = j["user_id"]as? Int
                        
                        
                        let school : NSDictionary = (j["school"]) as! NSDictionary
                        
                        degree.school_id = school["id"] as? Int
                        degree.school = school["name"] as? String
                        degrees.append(degree)
                    }
                }
                
                var contact = Contact()
                if let email = json["email"].stringValue as? String {
                    contact.email = email
                }
                if let phone = json["phone"].stringValue as? String {
                    contact.phone_number = json["phone"].stringValue
                }
                if let linkedin = json["linkedin"].stringValue as? String {
                    contact.linkedin_profile = linkedin
                }
                if let wat = json["wat_link"].stringValue as? String {
                    contact.wat_profile = wat
                }
                if let twitter = json["twitter"].stringValue as? String {
                    contact.twitter_profile = twitter
                }
                if let agil = json["agil"].stringValue as? String {
                    contact.agil_profile = agil
                }
                if let skype = json["skype"].stringValue as? String {
                    contact.skipe = skype
                }
                let profile = Profile()
                profile.user = user
                profile.jobs = jobs.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                profile.contact = contact
                profile.projects = projects.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                profile.langues = language
                profile.skills = skill
                profile.relations = relations
                profile.relations.isRelationAvailable = isRelationAvailable
                profile.relations.relationshipID = relationshipID
                print("relationshipID : \(relationshipID)")
                profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                
                self.relations = relationsArray(relations: relations)
                
                if let id = json["id"].intValue as? Int {
                    profile.id = id
                }
                
                self.tableView.reloadData()
                self.tableViewManager.reloadData()
                self.tableViewColleague.reloadData()
                self.tableViewAssitant.reloadData()
                self.tableViewTeam.reloadData()
                self.tableViewMember.reloadData()
                
                AppData.sharedInstance.currentUser = profile
                
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getUserFromIDForRelationship(user_id : Int,sender: AnyObject) {
        
        if user_id == AppData.sharedInstance.currentUser.id{
            return
        }
        let param: NSDictionary = [:]
        
        let url = "users/" + "\(user_id)"
        var profiles:[Profile] = []
        
        APIUtility.sharedInstance.getAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                //let status : Int = response?.value(forKey: "status") as! Int
                dump(response)
                let json = JSON(response)[0]
                //dump(response)
                //dump("json : \(json)")
                var users: [User]
                
                //Do something you want
                var projects: [Project] = []
                var jobs: [Job] = []
                var degrees: [Degree] = []
                var user = User()
                var isRelationAvailable: Bool = false
                var relationshipID: Int = 0
                
                if let first_name = json["first_name"].stringValue as? String, let last_name = json["last_name"].stringValue as? String {
                    user.first_name = "\(first_name)"
                    user.last_name = "\(last_name)"
                }
                if let job = json["job_title"].stringValue as? String {
                    user.job = "\(job)"
                }
                if let location = json["office_address"].stringValue as? String {
                    user.location = "\(location)"
                }
                if let image = json["picture_url"].stringValue as? String {
                    user.image =  image
                }
                if let entity = json["entity"].stringValue as? String {
                    user.entities = "\(entity)"
                }
                var skill = Skill()
                for j in 0..<json["skills"].count {
                    print("s : \(json["skills"][j]["name"].stringValue)")
                    
                    if let s = json["skills"][j]["name"].stringValue as? String {
                        skill.skills.append(s)
                    }
                }
                print("skills : \(skill.skills)")
                var language = Language()
                for j in 0..<json["languages"].count {
                    if let l = json["languages"][j]["name"].stringValue as? String {
                        language.langues.append(l)
                    }
                }
                var relations = Relation()
                
                for j in 0..<json["relationships"].count {
                    if let relation = json["relationships"][j].dictionaryObject{
                        
                        //let id = relation["target"]?["user_id"].int
                        let profile = Profile()
                        let user = User()
                       
                        if let target = relation["target"] as? Dictionary<String, AnyObject>
                        {
                            user.first_name = target["first_name"] as? String
                            user.last_name = target["last_name"] as? String
                            user.image = target["picture_url"] as? String
                            user.job = target["job_title"] as? String
                            user.user_id = (target["id"] as? Int)!
                        }
                        
                       
                            relationshipID = relation["id"] as! Int
             
                        profile.user = user
                        switch (relation["kind"] as! String) {
                        case "is_manager_of":
                            print("kind : \(relation["kind"] as! String)")
                            relations.teamMembers_profile.append(profile)
                        case "is_managed_by":
                            relations.managers_profile.append(profile)
                        case "is_colleague_of":
                            relations.colleagues_profile.append(profile)
                        case "is_assisted_by":
                            relations.assistants_profile.append(profile)
                        default:
                            break
                        }
                    }
                }
                dump("relations : \(relations)")
                
                let profile_id = json["id"].intValue
                for j in 0..<json["projects"].count {
                    
                    let project = Project()
                    let proj = (json["projects"][j])
                    project.title = proj["name"].stringValue
                    project.location = proj["location"].stringValue
                    project.objDescription = proj["project_participations"][0]["role_description"].stringValue
                    project.id = proj["id"].intValue
                    project.start_date = proj["project_participations"][0]["start_date"].stringValue
                    project.end_date = proj["project_participations"][0]["end_date"].stringValue
                    project.participation_id = proj["project_participations"][0]["id"].intValue
                    //print("project.participation_id : \(project.participation_id)")
                    for k in 0..<proj["project_participations"].count {
                        let participants = proj["project_participations"].arrayValue
                        print("k : \(k)")
                        dump("participants : \(participants)")
                        
                        let participant = participants[k].dictionaryValue
                        var profile = Profile()
                        var user = User()
                        profile.id = (participant["user_id"]?.intValue)!
                        user.user_id = (participant["user_id"]?.intValue)!
                        user.first_name = participant["user_first_name"]?.stringValue
                        user.last_name = participant["user_last_name"]?.stringValue
                        user.image = participant["user_picture_url"]?.stringValue
                        profile.user = user
                        project.members_profile.append(profile)
                    }
                    dump("project members : \(project.members_profile)")
                    projects.append(project)
                }
                
                for j in 0..<json["jobs"].count {
                    var job = Job()
                    if let j = json["jobs"][j].dictionaryObject {
                        job.title = j["title"] as? String
                        job.location = j["location"] as? String
                        job.id = j["id"] as? Int
                        job.start_date = j["start_date"]as? String
                        job.objDescription = j["description"] as? String
                        jobs.append(job)
                    }
                }
                for j in 0..<json["degrees"].count {
                    var degree = Degree()
                    if let j = json["degrees"][j].dictionaryObject {
                        degree.title = j["title"] as? String
                        if let objEntry_Year = j["entry_year"]
                        {
                            if !(objEntry_Year is NSNull) {
                                degree.entry_year = "\(objEntry_Year as! Int)"
                            }
                            
                        }
                        if let objGraduation_year = j["graduation_year"]
                        {
                            if !(objGraduation_year is NSNull) {
                                degree.graduation_year = "\(objGraduation_year as! Int)"
                            }
                        }
                        degree.user_id = j["user_id"]as? Int
                        
                        
                        let school : NSDictionary = (j["school"]) as! NSDictionary
                        
                        degree.school_id = school["id"] as? Int
                        degree.school = school["name"] as? String
                        degrees.append(degree)
                    }
                }
                
                var contact = Contact()
                if let email = json["email"].stringValue as? String {
                    contact.email = email
                }
                if let phone = json["phone"].stringValue as? String {
                    contact.phone_number = json["phone"].stringValue
                }
                if let linkedin = json["linkedin"].stringValue as? String {
                    contact.linkedin_profile = linkedin
                }
                if let wat = json["wat_link"].stringValue as? String {
                    contact.wat_profile = wat
                }
                if let twitter = json["twitter"].stringValue as? String {
                    contact.twitter_profile = twitter
                }
                if let agil = json["agil"].stringValue as? String {
                    contact.agil_profile = agil
                }
                if let skype = json["skype"].stringValue as? String {
                    contact.skipe = skype
                }
                let profile = Profile()
                profile.user = user
                profile.jobs = jobs.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                profile.contact = contact
                profile.projects = projects.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                profile.langues = language
                profile.skills = skill
                profile.relations = relations
                profile.relations.isRelationAvailable = isRelationAvailable
                profile.relations.relationshipID = relationshipID
                print("relationshipID : \(profile.relations.relationshipID)")
                profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                
                if let id = json["id"].intValue as? Int {
                    profile.id = id
                }
                dump(profile)
                profiles.append(profile)
                
                var objProfile = Profile()
                objProfile = profiles[0]
                
                self.toConnect(profile: objProfile, sender: sender)
                
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func toConnect(profile: Profile, sender: AnyObject) {
        
        if(profile.relations.isRelationAvailable)
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Do you want to remove your relationship?", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            let removeAction: UIAlertAction = UIAlertAction(title: "Remove", style: .destructive) { action -> Void in
                //Just dismiss the action sheet
                print("here : \(profile.relations.relationshipID)")
                self.removeRelationShipWithID(relationship_id: profile.relations.relationshipID)
            }
            actionSheetController.addAction(cancelAction)
            actionSheetController.addAction(removeAction)
            self.present(actionSheetController, animated: true, completion: nil)
        }
        else {
            let myActionSheet = UIAlertController(title: "Confirm new relationship", message: "Add", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            // blue action button
            let blueAction = UIAlertAction(title: "as colleague", style: UIAlertActionStyle.default) { (action) in
                print("As colleague")
                self.addRelationShip(kind: "is_colleague_of", profile: profile)
            }
            
            // red action button
            let redAction = UIAlertAction(title: "as manager", style: UIAlertActionStyle.default) { (action) in
                print("as Manager")
                self.addRelationShip(kind: "is_managed_by", profile: profile)
            }
            
            // yellow action button
            let yellowAction = UIAlertAction(title: "as team member", style: UIAlertActionStyle.default) { (action) in
                print("as Team member")
                self.addRelationShip(kind: "is_manager_of", profile: profile)
            }
            
            let purpleAction = UIAlertAction(title: "as assistant", style: UIAlertActionStyle.default) { (action) in
                print("as assistant")
                self.addRelationShip(kind: "is_assisted_by", profile: profile)
            }
            // cancel action button
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
                print("Cancel action button tapped")
            }
            
            // add action buttons to action sheet
            myActionSheet.addAction(blueAction)
            myActionSheet.addAction(redAction)
            myActionSheet.addAction(yellowAction)
            myActionSheet.addAction(purpleAction)
            myActionSheet.addAction(cancelAction)
            
            // support iPads (popover view)
            myActionSheet.popoverPresentationController?.sourceView = sender as! UIButton
            myActionSheet.popoverPresentationController?.sourceRect = sender.bounds
            
            // present the action sheet
            self.present(myActionSheet, animated: true, completion: nil)
        }
    }
    
    func addRelationShip(kind: String,profile: Profile) {
        //        POST /api/v1/relationships
        
        let url = "relationships"
        
        let param: NSDictionary = ["relationship": ["user_id": AppData.sharedInstance.currentUser.id,"target_id": profile.id,"kind": kind]]
        
        APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            //                self.getCurrentUpdatedUser()
            if (error == nil)
            {
                let json = JSON(response)
                print("response edit profile")
                dump(json)
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func removeRelationShipWithID(relationship_id: Int) {
        
        //        DELETE /api/v1/relationships/{relationship_id}
        
        let url = "relationships/" + "\(relationship_id)"
        
        let param: NSDictionary = ["relationship_id": relationship_id]
        
        APIUtility.sharedInstance.deleteAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            self.getCurrentUser()
            
            if (error == nil)
            {
                let json = JSON(response)
                print("response edit profile")
                dump(json)

                self.tableView.reloadData()
                self.tableViewManager.reloadData()
                self.tableViewColleague.reloadData()
                self.tableViewAssitant.reloadData()
                self.tableViewTeam.reloadData()
                self.tableViewMember.reloadData()
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
