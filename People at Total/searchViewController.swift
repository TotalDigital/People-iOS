  //
//  searchViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 01/02/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD
import InitialsImageView
  
extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(roundedRect: breadthRect, cornerRadius: breadth/2).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

public extension UITableViewCell
{
    func addSeparator(y: CGFloat, margin: CGFloat, color: UIColor)
    {
        let sepFrame = CGRect(x: margin,y: y, width: self.frame.width - margin,height: 0.7);
        let seperatorView = UIView(frame: sepFrame);
        seperatorView.backgroundColor = color;
        self.addSubview(seperatorView);
    }
    
    public func addTopSeparator(tableView: UITableView)
    {
        let margin = tableView.separatorInset.left;
        
        self.addSeparator(y: 0, margin: 0, color: tableView.separatorColor!);
    }
    
    public func addBottomSeparator(tableView: UITableView, cellHeight: CGFloat)
    {
        let margin = tableView.separatorInset.left;
        
        self.addSeparator(y: cellHeight-2, margin: margin, color: tableView.separatorColor!);
    }
    
    public func removeSeparator(width: CGFloat)
    {
        self.separatorInset = UIEdgeInsetsMake(0.0, width, 0.0, 0.0);
    }
    
}

class NewLabel: UILabel {
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        return self.bounds.insetBy(dx: CGFloat(15.0), dy: CGFloat(15.0))
    }
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: self.bounds.insetBy(dx: CGFloat(8.0), dy: CGFloat(8.0)))
    }
    
}

extension UIImage {
    
    func transform(withNewColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        
        color.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
  protocol OptionButtonsDelegate{
    func closeFriendsTapped(at index:IndexPath, sender: AnyObject)
  }
  
class profileTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    @IBOutlet weak var entitiesLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var delegate:OptionButtonsDelegate!
    @IBOutlet weak var closeFriendsBtn: UIButton!
    var indexPath:IndexPath!
    @IBAction func closeFriendsAction(_ sender: UIButton) {
        self.delegate?.closeFriendsTapped(at: indexPath, sender: sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("Generic Cell Initialization Done")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    
    
}

func relationsArray(relations: Relation) -> [String:[Profile]] {
    var relationsArray: [String: [Profile]] = [:]
    
//    change the order of relations : manager, assistant, team member and colleagues
    
    if relations.managers_profile.count > 0 {
        relationsArray["Managers"] = relations.managers_profile.sorted { $0.user.last_name < $1.user.last_name }
 
        dump("managers : \(relations.managers_profile)")
    }
    if relations.assistants_profile.count > 0 {
        relationsArray["Assistant"] = relations.assistants_profile.sorted { $0.user.last_name < $1.user.last_name }
        dump("assistants : \(relations.assistants_profile)")
    }
    if relations.teamMembers_profile.count > 0 {
        relationsArray["Team Members"] = relations.teamMembers_profile.sorted { $0.user.last_name < $1.user.last_name }
        dump("team members : \(relations.teamMembers_profile)")
    }
    if relations.colleagues_profile.count > 0 {
        relationsArray["Colleagues"] = relations.colleagues_profile.sorted { $0.user.last_name < $1.user.last_name }

        dump("colleagues : \(relations.colleagues_profile)")
    }
    return relationsArray 
}



  class searchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITabBarDelegate, OptionButtonsDelegate, UITabBarControllerDelegate {
    
    internal func closeFriendsTapped(at index: IndexPath , sender: AnyObject) {
        if(searchActive){
            if filtered.count>0 {
                let row = index.row
               self.toConnect(profile: self.filtered[row],sender: sender,index: index)
            }
        } else {
            if profiles.count>0 {
                let row = index.row
                self.toConnect(profile: self.profiles[row],sender: sender,index: index)
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tabBarSelected = false
    var users:[User] = []
    var profiles:[Profile] = []
    var projects:[Project] = []
    
    var searchActive : Bool = false

    var filtered:[Profile] = []
    
    var access_token: String = ""
    
    var usersPageNo: Int = 0
    var usersSearchPageNo: Int = 0
    
    var getDataIsFinished = false
  
    let pagingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProfile" {
            print("segue called")
            
            let profileVC = segue.destination as? profileViewController
            guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {
                    return
            }
            print("indexPath : \(indexPath.row)")

            if searchBar.isFirstResponder == true {
                searchBar.resignFirstResponder()
            }
            
            if(searchActive) {
                profileVC?.profile = filtered[indexPath.row]
                print("relationsArray : ")
                dump(relationsArray(relations: filtered[indexPath.row].relations))
                let profile = filtered[indexPath.row]
                profileVC?.access_token = self.access_token
                profileVC?.relations = relationsArray(relations: profile.relations)
                
                profileVC?.callbackLatestProfile = {(newProfile:Profile) in
                    self.filtered[indexPath.row] = newProfile
                    self.tableView.reloadData()
                }

            }
            else {
                //dump("profiles : \(profiles)")
                if profiles[indexPath.row] != nil {
                profileVC?.profile = profiles[indexPath.row]
                print("relationsArray : ")
                dump(relationsArray(relations: profiles[indexPath.row].relations))
                let profile = profiles[indexPath.row]
                profileVC?.access_token = self.access_token
                profileVC?.relations = relationsArray(relations: profile.relations)
                
                profileVC?.callbackLatestProfile = {(newProfile:Profile) in
                    self.profiles[indexPath.row] = newProfile
                    self.tableView.reloadData()
                }
            }
                else {
                    self.tableView.reloadData()
                }
            }
            
            
        }
        /*else if segue.identifier == "ShowMyProfile" {
            let myProvileVC = segue.destination as? myProfileViewController
         
        }*/
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            searchBar.text = ""
            print("tabBr selected")
            self.filtered = []
            searchActive = false;
            searchBar.resignFirstResponder()
            usersPageNo = 0
            tabBarSelected = true
            getData()
            
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "splash") as! SplashScreenViewController
        //self.present(vc, animated: false, completion: nil)
        print("viewdidload")
         self.tabBarController?.delegate = self
        //self.hideKeyboardWhenTappedAround()
        let defaults = UserDefaults.standard
        if let objAccess_token = defaults.string(forKey: "accessToken") {
            access_token = objAccess_token
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        pagingSpinner.color = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        pagingSpinner.hidesWhenStopped = true
        tableView.tableFooterView = pagingSpinner
        
        tableView.delegate = self
        tableView.dataSource = self

        searchBar.delegate = self
        

        searchBar.placeholder = "Search on people..."
        
        
        self.tableView.contentInset = UIEdgeInsetsMake(-1, 0, 0, 0);

        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.borderStyle = .roundedRect
        textFieldInsideSearchBar?.layer.cornerRadius = 0.0
        textFieldInsideSearchBar?.textColor = UIColor.white
        textFieldInsideSearchBar?.backgroundColor = UIColor(red: 58/255 ,green: 131/255, blue: 202/255, alpha:1.0)
        
        if (textFieldInsideSearchBar!.value(forKey:"attributedPlaceholder") != nil) {
            let attributeDict = [NSForegroundColorAttributeName: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.75)]
            textFieldInsideSearchBar!.attributedPlaceholder = NSAttributedString(string: "Search on People...", attributes: attributeDict)

           if let imageView = textFieldInsideSearchBar?.leftView as? UIImageView {

            imageView.image = imageView.image?.transform(withNewColor: UIColor(red: 255/255, green: 255/255, blue: 255, alpha: 0.75))
            }
        }
        
        navigationItem.titleView = searchBar

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 22/255, green: 108/255, blue: 193/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        //self.tabBarController?.tabBar.barTintColor = UIColor(red: 22/255, green: 108/255, blue: 193/255, alpha: 1.0)
       /* let user1 = User()
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
        
        users = [user1, user2, user3, user4, user5]
        
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
        relations1.managers = [3, 4]
        relations1.colleagues = [2, 3]
        relations1.assistant = [5, 2]
        relations1.teamMember = [5, 4]
    
        let relations2: Relation = Relation()
        relations2.managers = []
        relations2.colleagues = [1]
        relations2.assistant = [4]
        relations2.teamMember = [5]
        
        let relations3: Relation = Relation()
        relations3.managers = [4]
        relations3.colleagues = []
        relations3.assistant = []
        relations3.teamMember = [1]
        
        let relations4: Relation = Relation()
        relations4.managers = []
        relations4.colleagues = []
        relations4.assistant = [3]
        relations4.teamMember = []
        
        let relations5: Relation = Relation()
        relations5.managers = [1]
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

        let profile1 = Profile()
        profile1.user = user1
        profile1.jobs = [job1, job2]
        profile1.projects = [project1, project2]
        profile1.relations = relations1
        profile1.skills = skill1
        profile1.langues = langue1
        
        let profile2 = Profile()
        profile2.user = user2
        profile2.jobs = [job3, job4]
        profile2.projects = [project3]
        profile2.relations = relations2
        profile2.skills = skill2
        profile2.langues = langue2
        
        let profile3 = Profile()
        profile3.jobs = [job7, job8, job9]
        profile3.user = user3
        profile3.projects = [project3, project4]
        profile3.relations = relations3
        profile3.skills = skill3
        profile3.langues = langue3
        
        let profile4 = Profile()
        profile4.jobs = [job10, job11, job12, job13]
        profile4.user = user4
        profile4.projects = [project1, project2]
        profile4.relations = relations4
        profile4.skills = skill4
        profile4.langues = langue3
        
        let profile5 = Profile()
        profile5.user = user5
        profile5.jobs = [job14]
        profile5.projects = [project4, project1]
        profile5.relations = relations5
        profile5.skills = skill5
        profile5.langues = langue2
        
        profiles = [profile1, profile2, profile3, profile4, profile5]*/
        
        // Do any additional setup after loading the view.
        
        // Get the Current User
       
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Make SearchBar's tint color white to get white cancel button.
        searchBar.tintColor = UIColor.white
        
        // Loop into it's subviews and find TextField, change tint color to something else.
        for subView in searchBar.subviews[0].subviews where subView is UITextField {
            subView.tintColor = UIColor.white
        }
         //searchBar.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.profiles.count == 0 {
            print("getPRoject is called")
            
            usersPageNo = 0;
            if Reachability.isConnectedToNetwork() == false {
                self.dismiss(animated: false, completion: nil)
            }
            else {
                getCurrentUser()
                getData()
            }
        }
        
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.contentInset = UIEdgeInsets(top: topLayoutGuide.length, left: 0, bottom: 0, right: 0)
        self.tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    func matchProjectMemberId () {
        print("projects : ")
        //dump(self.projects)
        for i in 0..<self.profiles.count {
            for j in 0..<self.profiles[i].projects.count {
                var id = profiles[i]
                self.profiles[i].projects[j].members_profile.append(self.profiles.first {$0.id == self.projects[i].members[j]}!)
            }
        }

    }
    
    func matchRelationMember () {
        print("projects : ")
        //dump(self.projects)
        for i in 0..<self.profiles.count {
            var profile = self.profiles[i]
            for j in 0..<self.profiles[i].relations.managers.count {
                var id = profile.relations.managers[j]
                print("id : \(id)")
                self.profiles[i].relations.managers_profile.append(self.profiles.first {$0.id == id}!)
            }
        }
        //dump(self.projects)
    }
    
   /* func getJob() {
        
        var url = "jobs"
        
        let param: NSDictionary = [:]
        APIUtility.sharedInstance.getAPICall(url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                let json = JSON(response)
                
                for i in 0..<json.count {
                    var profile = Profile()
                    profile = self.profiles.first {$0.id == json[i]["user_id"].intValue}!
                    var job = Job()
                    job.description = json[i]["description"].stringValue
                    job.title = json[i]["title"].stringValue
                    job.location = json[i]["location"].stringValue
                    job.start_date = json[i]["start_date"].stringValue
                    job.end_date = json[i]["end_date"].stringValue
                    job.id = json[i]["id"].intValue

                    profile.jobs.append(job)
                }
                //self.matchProjectMemberId()
            }
        }
    }

    func getRelation() {

        var url = "relationships"

        let param: NSDictionary = [:]
        APIUtility.sharedInstance.getAPICall(url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                let json = JSON(response)
                
                for i in 0..<json.count {
                    var profile = Profile()
                    var target_profile = Profile()
                    //print("id : \(json[i]["id"].intValue)")
                    //print("profiles : \(self.profiles)")
                    profile = self.profiles.first {$0.id == json[i]["source"]["user_id"].intValue}!
                    target_profile = self.profiles.first {$0.id == json[i]["target"]["user_id"].intValue}!
                    //print("profile relation : ")
                    //dump(profile)
                    //dump(target_profile)
                    //print(json[i]["kind"].stringValue)
                    switch (json[i]["kind"].stringValue) {
                    case "is_manager_of":
                        profile.relations.managers_profile.append(target_profile)
                    case "is_managed_by":
                        profile.relations.teamMembers_profile.append(target_profile)
                    case "is_colleague_of":
                        profile.relations.colleagues_profile.append(target_profile)
                    case "is_assistant_of":
                        profile.relations.assistants_profile.append(target_profile)
                    default:
                        break;
                    }
                }
                //print("profiles : ")
                //dump(self.profiles)
                self.matchProjectMemberId()
                //self.getJob()
            }
        }
    }
    */
    
    func getData() {
        
        if Reachability.isConnectedToNetwork() == false {
            return
        }
        
        
        // Next page
        usersPageNo += 1
        
        getDataIsFinished = false
        print("usersPageNo : \(usersPageNo)")
        print("getData called : \(self.access_token)")
        let url = "users/featured"
//        let param: NSDictionary = ["page": usersPageNo,"per_page": 15]
        let param: NSDictionary = [:]
        pagingSpinner.startAnimating()
        APIUtility.sharedInstance.getAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //self.dismiss(animated: false, completion: nil)

            if (error == nil)
            {
                
                //self.tableView.isUserInteractionEnabled = false
                //let status : Int = response?.value(forKey: "status") as! Int
                let json = JSON(response)
                if self.tabBarSelected == true {
                    self.profiles = []
                    self.tabBarSelected = false
                }
                if(self.profiles.count>0)
                {
                }
                else
                {
                    self.profiles = []
                }
        
                if json.count == 0
                {
                    if(self.usersPageNo>1)
                    {
                        self.usersPageNo -= 1;
                    }
                }
                
                //dump(json)
                var users: [User]
                for i in 0..<json.count {
                    //Do something you want
                    var projects: [Project] = []
                    var jobs: [Job] = []
                    var degrees: [Degree] = []
                    var user = User()
                    var isRelationAvailable: Bool = false
                    var relationshipID: Int = 0
                    
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
                    if var image = json[i]["picture_url"].stringValue as? String {
                        if image == "http://placehold.it/180x180" {
                            image = "https://placeholdit.imgix.net/~text?txtsize=17&txt=180%C3%97180&w=180&h=180"
                        }
                        user.image = image
                        //print("image : \(image)")
                    }
                    if let entity = json[i]["entity"].stringValue as? String {
                        user.entities = "\(entity)"
                    }
                    if let external = json[i]["external"].boolValue as? Bool {
                        print("external json : \(json["external"])")
                        user.is_external = external
                    }
                    var skill = Skill()
                    for j in 0..<json[i]["skills"].count {
                        //print("s : \(json[i]["skills"][j]["name"].stringValue)")
                        
                        if let s = json[i]["skills"][j]["name"].stringValue as? String {
                            skill.skills.append(s)
                        }
                    }
                    //print("skills : \(skill.skills)")
                    var language = Language()
                    for j in 0..<json[i]["languages"].count {
                        if let l = json[i]["languages"][j]["name"].stringValue as? String {
                            language.langues.append(l)
                        }
                    }
                    var relations = Relation()
                    
                    for j in 0..<json[i]["relationships"].count {
                        if let relation = json[i]["relationships"][j].dictionaryObject{
                            
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
                            
                            
                            
                            if(user.user_id == AppData.sharedInstance.currentUser.id)
                            {
                               
                              
                                isRelationAvailable = true
                                relationshipID = relation["id"] as! Int
                            }
                            
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
                  AppData.sharedInstance.relation = relations
                    for j in 0..<json[i]["projects"].count {
                        var project = Project()
                        let proj = (json[i]["projects"][j])
                        //dump("proj : \(proj["id"])")
                       // project = self.projects.first {$0.id! == proj["id"].intValue}!
                        
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
                        AppData.sharedInstance.project = project
                        projects.append(project)
                    }
                    
                    for j in 0..<json[i]["jobs"].count {
                        if let newj = json[i]["jobs"][j].dictionaryObject{
                            let job = Job()
                            job.title = newj["title"] as? String
                            job.location = newj["location"] as? String
                            job.id = newj["id"] as? Int
                            job.start_date = newj["start_date"] as? String
                            job.end_date = newj["end_date"] as? String
                            job.objDescription = newj["description"] as? String
                            
                            jobs.append(job)
                        }
                    }
                    for j in 0..<json[i]["degrees"].count {
                        if let j = json[i]["degrees"][j].dictionaryObject {
                            let degree = Degree()
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
                    profile.jobs = jobs.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                    profile.contact = contact
                    profile.projects = projects.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                    profile.langues = language
                    profile.skills = skill
                    profile.relations = relations
                    profile.relations.isRelationAvailable = isRelationAvailable
                    profile.relations.relationshipID = relationshipID
                    profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                    
                    //dump("relations : \(profile.relations)")
                    if let id = json[i]["id"].intValue as? Int {
                        profile.id = id
                        print("id profile : \(profile.id)")
                    }
                    //dump(profile)
                   
                    if !isRelationAvailable
                    {
                       
                        if(profile.id != AppData.sharedInstance.currentUser.id)
                        {
                            var isAvailable : Bool = false
                            
                            for objProfile in self.profiles
                            {
                                let profileTemp = objProfile as Profile
                                if(profile.id == profileTemp.id)
                                {
                                 
                                    isAvailable = true
                                    break;
                                }
                            }
                            
                            if isAvailable == false
                            {
                                self.profiles.append(profile)
                            }
                        }
                    }
                    
                    //defaults.set(self.profiles, forKey: "profiles")
                    self.getDataIsFinished = true
                   
                    self.tableView.reloadData()
                  
                    let userDefaults = UserDefaults.standard
                    
                    if let data = userDefaults.object(forKey: "currentUser") {
                        let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
                        print("myPeopleList: \(myPeopleList)")
                    }else{
                        print("There is an issue")
                    }
                    //self.tableView.isUserInteractionEnabled = true
                    self.pagingSpinner.stopAnimating()
                }
                //self.getRelation()
                
                //self.matchRelationMember()
                //self.matchProjectMemberId()
                
                print("tableview reload")
                
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.tableView.isUserInteractionEnabled = true
                self.pagingSpinner.stopAnimating()
               
            }
            
        }
    }

    func getDataWithSearch(txtSearch: String) {
        
        if Reachability.isConnectedToNetwork() == false {
            return
        }
        
    
        
        // Next page
        usersSearchPageNo += 1

        let param: NSDictionary = ["page": usersSearchPageNo,"per_page": 15]
        
        print("getData called : \(self.access_token)")
        
//        GET /api/v1/users/search/{search_term}
        
        let url : String! = "users/search/" + txtSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        self.pagingSpinner.startAnimating()
        APIUtility.sharedInstance.getAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            
            
            if (error == nil)
            {
                if(self.filtered.count>0)
                {
                }
                else
                {
                    self.filtered = []
                }
                
                //let status : Int = response?.value(forKey: "status") as! Int
                let json = JSON(response)
                
                //dump(json)
                var users: [User]
                for i in 0..<json.count {
                    //Do something you want
                    var projects: [Project] = []
                    var jobs: [Job] = []
                    var degrees: [Degree] = []
                    var user = User()
                    var isRelationAvailable: Bool = false
                    var relationshipID: Int = 0

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
                    if let external = json[i]["external"].boolValue as? Bool {
                        print("external json search: \(json["external"])")
                        user.is_external = external
                    }
                    if var image = json[i]["picture_url"].stringValue as? String {
                        if image == "http://placehold.it/180x180" {
                            image = "https://placeholdit.imgix.net/~text?txtsize=17&txt=180%C3%97180&w=180&h=180"
                        }
                        user.image = image
                        //print("image : \(image)")
                    }
                    if let entity = json[i]["entity"].stringValue as? String {
                        user.entities = "\(entity)"
                    }
                    var skill = Skill()
                    for j in 0..<json[i]["skills"].count {
                        //print("s : \(json[i]["skills"][j]["name"].stringValue)")
                        
                        if let s = json[i]["skills"][j]["name"].stringValue as? String {
                            skill.skills.append(s)
                        }
                    }
                    //print("skills : \(skill.skills)")
                    var language = Language()
                    for j in 0..<json[i]["languages"].count {
                        if let l = json[i]["languages"][j]["name"].stringValue as? String {
                            language.langues.append(l)
                        }
                    }
                    var relations = Relation()
                    
                    for j in 0..<json[i]["relationships"].count {
                        if let relation = json[i]["relationships"][j].dictionaryObject{
                            
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
                            
                            if(user.user_id == AppData.sharedInstance.currentUser.id)
                            {
                                
                                isRelationAvailable = true
                                relationshipID = relation["id"] as! Int
                            }
                            
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
                    AppData.sharedInstance.relation = relations
                    for j in 0..<json[i]["projects"].count {
                        var project = Project()
                        let proj = (json[i]["projects"][j])
                        //dump("proj : \(proj["id"])")
                        // project = self.projects.first {$0.id! == proj["id"].intValue}!
                        
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
                    
                    for j in 0..<json[i]["jobs"].count {
                        if let newj = json[i]["jobs"][j].dictionaryObject{
                            let job = Job()
                            job.title = newj["title"] as? String
                            job.location = newj["location"] as? String
                            job.id = newj["id"] as? Int
                            job.start_date = newj["start_date"] as? String
                            job.end_date = newj["end_date"] as? String
                            job.objDescription = newj["description"] as? String
                            
                            jobs.append(job)
                        }
                    }
                    for j in 0..<json[i]["degrees"].count {
                        if let j = json[i]["degrees"][j].dictionaryObject {
                            let degree = Degree()
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
                    profile.jobs = jobs.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                    profile.contact = contact
                    profile.projects = projects.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                    profile.langues = language
                    profile.skills = skill
                    profile.relations = relations
                    profile.relations.isRelationAvailable = isRelationAvailable
                    profile.relations.relationshipID = relationshipID
                    profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                    
                    //dump("relations : \(profile.relations)")
                    if let id = json[i]["id"].intValue as? Int {
                        profile.id = id
                        print("id profile : \(profile.id)")
                    }
                    //dump(profile)
                    self.filtered.append(profile)
                    
                    //defaults.set(self.profiles, forKey: "profiles")
                    print("coucou")
                }
                //self.getRelation()
                
                //self.matchRelationMember()
                //self.matchProjectMemberId()
                
                self.tableView.reloadData()
               // self.tableView.isUserInteractionEnabled = true
                self.pagingSpinner.stopAnimating()
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.pagingSpinner.stopAnimating()
            }
            
        }
    }
    
    /*func getProject() {
        var url = "projects"
        self.projects = []
        let param: NSDictionary = [:]
        APIUtility.sharedInstance.getAPICall(url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                let json = JSON(response)
                
                for i in 0..<json.count {
                    var project = Project()
                    project.id = json[i]["id"].intValue
                    project.title = json[i]["name"].stringValue
                    project.location = json[i]["location"].stringValue
                    for k in 0..<json[i]["project_participations"].count {
                        let participants = json[i]["project_participations"].arrayValue
                        let participant = participants[k].dictionaryValue
                        let id_participant = participant["user_id"]?.intValue
                        project.members.append(id_participant!)
                    }
                    self.projects.append(project)
                }
                //print("projects : ")
                //dump(self.projects)
                self.getData()
            }
    }
}*/
    

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("coucou1")
//        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchActive = false;
        print("coucou2")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        // Clear any search criteria
        searchBar.text = ""
        
        // Dismiss the keyboard
        searchBar.resignFirstResponder()
        
        // Reload of table data
        //->> your search result table
        self.tableView.reloadData()
           print("coucou3")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if searchBar.text! != "" {
            usersSearchPageNo = 0;
            self.filtered = []
            
            getDataWithSearch(txtSearch: searchBar.text!)
        }
//        searchActive = false;
           print("coucou4")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            searchActive = false;
            filtered.removeAll()
        }
        else {
            searchActive = true;
            //getDataWithSearch(txtSearch: searchText)
        }
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(searchActive) {
            return "SEARCH RESULT"
        }
        else {
            return "PEOPLE YOU MAY KNOW"
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section:Int) -> UIView? {
        let headerView = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.frame.width, height: 57)))
        
        let label = NewLabel(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
        label.font = UIFont(name: "HelveticaNeue-bold", size: 14)!
        label.textColor = UIColor(red: 112/255, green: 113/255, blue: 115/255, alpha: 1.0)
        if(searchActive) {
            label.text = "SEARCH RESULT"
        }
        else
        {
            label.text = "PEOPLE YOU MAY KNOW"
        }
        label.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)

        headerView.addSubview(label)
        //headerView.bringSubview(toFront: label)
       // headerView.backgroundColor = UIColor.red/*(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)*/
        print("label.text :")
        print(label.frame)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return profiles.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtindexPath: IndexPath) {
        print("didSelectRowAtIndexPath")
        print("self.getDataIsFinished")
        if (self.getDataIsFinished == true) {
            self.performSegue(withIdentifier: "ShowProfile", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")! as! profileTableViewCell;
        if indexPath.row == 0 {
            cell.addTopSeparator(tableView: tableView)
        }
        cell.indexPath = indexPath
        cell.delegate = self
        if(searchActive){
            if filtered.count>0 {
                let row = indexPath.row
                print("row : \(row)")
                let name:String! = "\((self.filtered[row].user?.first_name)!) \((self.filtered[row].user?.last_name)!)"
                cell.nameLabel?.text = name
                if ((filtered[row].user?.image) != nil) {
                    cell.avatarImageView.downloadedFrom(link: (filtered[row].user?.image)!)
                }
                cell.avatarImageView.setImageForName(string: name, backgroundColor: nil, circular: true, textAttributes: nil)
                
                cell.jobTitleLabel?.text = filtered[row].user?.job!
                cell.entitiesLabel?.text = filtered[row].user?.entities!
                if self.filtered[row].relations.isRelationAvailable == true {
                    print("name : \(name) true")
                    cell.closeFriendsBtn?.isHidden = true
                }
                else {
                    cell.closeFriendsBtn?.isHidden = false
                    print("false")
                }
            }
        } else {
            if profiles.count>0 {
                let row = indexPath.row
                
                let name:String! = "\((self.profiles[row].user?.first_name)!) \((self.profiles[row].user?.last_name)!)"
                cell.nameLabel?.text = name
                if ((profiles[row].user?.image) != nil) {
                    cell.avatarImageView.downloadedFrom(link: (profiles[row].user?.image)!)
                }
                cell.avatarImageView.setImageForName(string: name, backgroundColor: nil, circular: true, textAttributes: nil)

                cell.jobTitleLabel?.text = profiles[row].user?.job!
                cell.entitiesLabel?.text = profiles[row].user?.entities!
                print("is reload here?")
                if self.profiles[row].relations.isRelationAvailable == true {
                    print("name : \(name) true")
                    cell.closeFriendsBtn?.isHidden = true
                }
                else {
                    cell.closeFriendsBtn?.isHidden = false
                    print("false")
                }
            }
        }
        return cell;
    }
   
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        var titleText : String = ""
        if(self.searchActive){
            if self.filtered.count>0 {
                titleText = self.filtered[editActionsForRowAt.row].relations.isRelationAvailable ? "Remove" : "Add"
            }
        } else {
            if self.profiles.count>0 {
                titleText = self.profiles[editActionsForRowAt.row].relations.isRelationAvailable ? "Remove" : "Add"
            }
        }
        
        let Relation = UITableViewRowAction(style: .normal, title: titleText) { action, index in
            
            let cell = tableView.cellForRow(at: index) as! profileTableViewCell;
            
            if(self.searchActive){
                if self.filtered.count>0 {
                    let row = index.row
                    self.toConnect(profile: self.filtered[row],sender: cell.closeFriendsBtn,index: index)
                }
            } else {
                if self.profiles.count>0 {
                    let row = index.row
                    self.toConnect(profile: self.profiles[row],sender: cell.closeFriendsBtn,index: index)
                }
            }
            
            tableView.endEditing(true)
            tableView.reloadData()
        }
        Relation.backgroundColor = .lightGray
        
        return [Relation]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //Calls this function when the tap is recognized.
    override func dismissKeyboard() {
        if searchBar.isFirstResponder == true && searchBar.text == ""{
            searchBar.resignFirstResponder()
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
                var json = JSON(response)[0]
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
                        
//                        user.first_name = (relation["target"] as! Dictionary)["first_name"]
//                        
//                        user.last_name = (relation["target"] as! Dictionary)["last_name"]
//                        user.image = (relation["target"] as! Dictionary)["picture_url"]
//                        user.job = (relation["target"] as! Dictionary)["job_title"]
//                        user.user_id = (relation["target"] as! Dictionary)["id"]!
                        
                        if(user.user_id == AppData.sharedInstance.currentUser.id)
                        {
                            isRelationAvailable = true
                            relationshipID = ((relation["id"] as AnyObject).intValue)!
                        }
                        
                        profile.user = user
                        print(relation as AnyObject)
                        print(relation["kind"] as! String)
                        
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
                            relations.managers.append(id)
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
//                    project.title = proj["name"].stringValue
//                    project.location = proj["location"].stringValue
//                    project.id = proj["id"].intValue
//                    for k in 0..<proj["project_participations"].count {
//                        var participation = proj["project_participations"].arrayValue
//                        dump("participation xyz : \(participation)")
//                        if participation[k]["user_id"].intValue == profile_id {
//                            print("yesss")
//                            project.objDescription = participation[k]["role_description"].stringValue
//                            project.owner = participation[k]["project_owner"].boolValue
//                            project.start_date = participation[k]["start_date"].stringValue
//                            project.end_date = participation[k]["end_date"].stringValue
//                            project.participation_id = participation[k]["id"].intValue
//                        }
//                    }
//                    projects.append(project)
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
                profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                
                if let id = json["id"].intValue as? Int {
                    profile.id = id
                }
                
                AppData.sharedInstance.currentUser = profile
                
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func toConnect(profile: Profile, sender: AnyObject, index: IndexPath) {
        
        if(profile.relations.isRelationAvailable)
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Do you want to remove your relationship?", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            let removeAction: UIAlertAction = UIAlertAction(title: "Remove", style: .destructive) { action -> Void in
                //Just dismiss the action sheet
                self.removeRelationShipWithID(relationship_id: profile.relations.relationshipID, profile: profile, index: index)
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
                self.addRelationShip(kind: "is_colleague_of", profile: profile, index: index)
            }
            
            // red action button
            let redAction = UIAlertAction(title: "as manager", style: UIAlertActionStyle.default) { (action) in
                print("as Manager")
                self.addRelationShip(kind: "is_managed_by", profile: profile, index: index)
            }
            
            // yellow action button
            let yellowAction = UIAlertAction(title: "as team member", style: UIAlertActionStyle.default) { (action) in
                print("as Team member")
                self.addRelationShip(kind: "is_manager_of", profile: profile, index: index)
            }
            
            let purpleAction = UIAlertAction(title: "as assistant", style: UIAlertActionStyle.default) { (action) in
                print("as assistant")
                self.addRelationShip(kind: "is_assisted_by", profile: profile, index: index)
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
    
    func addRelationShip(kind: String,profile: Profile, index: IndexPath) {
        //        POST /api/v1/relationships
        
        let url = "relationships"
        
        let param: NSDictionary = ["relationship": ["user_id": AppData.sharedInstance.currentUser.id,"target_id": profile.id,"kind": kind]]
        
        APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            self.getUserFromID(user_id: profile.id,index:index)
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
    
    func removeRelationShipWithID(relationship_id: Int,profile: Profile, index: IndexPath) {
        
        //        DELETE /api/v1/relationships/{relationship_id}
        
        let url = "relationships/" + "\(relationship_id)"
        
        let param: NSDictionary = ["relationship_id": relationship_id]
        
        APIUtility.sharedInstance.deleteAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            self.getUserFromID(user_id: profile.id,index:index)
            
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

    func getUserFromID(user_id : Int, index: IndexPath) {
        
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
                        
                        if(user.user_id == AppData.sharedInstance.currentUser.id)
                        {
                            isRelationAvailable = true
                            relationshipID = relation["id"] as! Int
                        }
                        
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
                profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                
                if let id = json["id"].intValue as? Int {
                    profile.id = id
                }
                dump(profile)
                profiles.append(profile)
                
                var objProfile = Profile()
                objProfile = profiles[0]
                
                if(self.searchActive){
                    if self.filtered.count>0 {
                        self.filtered[index.row] = objProfile
                    }
                } else {
                    if self.profiles.count>0 {
                        self.profiles[index.row] = objProfile
                    }
                }
                
                self.tableView.reloadData()
                
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Find collectionview cell nearest to the center of collectionView
        // Arbitrarily start with the last cell (as a default)
        
        if (self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)-200)
        {
            // Don't animate
            
            if(searchActive) {
                getDataWithSearch(txtSearch: searchBar.text!)
            }
            else {
                
                getData()
            }
        }
        
    }
}
