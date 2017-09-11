//
//  ViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 31/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit
import SwiftyJSON
import p2_OAuth2
import Alamofire

extension NSMutableAttributedString {
    func bold(_ text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "HelveticaNeue-bold", size: 32)!]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func normal(_ text:String)->NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 32)!]
        let normal =  NSAttributedString(string: "\(text)", attributes :attrs)
        self.append(normal)
        return self
    }
    
    func color(_ text: String, _ color: UIColor)->NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSForegroundColorAttributeName : color]
        let coloredString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(coloredString)
        return self
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}




class ViewController: UIViewController {

    @IBOutlet weak var signinButton: UIButton!
    
    @IBOutlet weak var sentenceLabel: UILabel!
    
    fileprivate var alamofireManager: SessionManager?
    @IBOutlet weak var logo: UIImageView!
    
    var profiles: [Profile] = []
    var loader: OAuth2DataLoader?
    var token: String = ""
    var isProd: Bool?
    
    @IBOutlet weak var privacyTerms: UILabel!
    var oauth2: OAuth2CodeGrant?
    
	@IBOutlet var signInEmbeddedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("coucou segue : \((segue.identifier)!)")
        if((segue.identifier)! == "signIn"){
            print("token segue : \(self.token)")

            
            let barViewControllers = segue.destination as! UITabBarController
            let nav = barViewControllers.viewControllers![0] as! UINavigationController
            let destinationViewController = nav.viewControllers[0] as! searchViewController
            let secondViewController = barViewControllers.viewControllers![1] as! myProfileViewController
            destinationViewController.access_token = self.token
            secondViewController.access_token = self.token

            
        }
    }
    
    @IBAction func signInSafari(_ sender: UIButton?) {

        if (APIUtility.sharedInstance.isProd == true) {
             oauth2 = OAuth2CodeGrant(settings: [
                "client_id": "be038752db66a64a42fd515df59c6120977c6721ba0c5eb8ce6e85651c05c150",                         // yes, this client-id and secret will work!
                "client_secret": "e3578569e862b503b684dfde864adcae947deee07eee1e2dd6e75f931564a31e",
                "authorize_uri": "https://people.total.com/oauth/authorize",
                "token_uri": "https://people.total/oauth/token",
                "redirect_uris": ["peopleauthapp://oauth/callback"],            // app has registered this scheme
                "secret_in_body": true,                                      // GitHub does not accept client secret in the Authorization header
                "verbose": true
                ] as OAuth2JSON)
        }
        else {
             oauth2 = OAuth2CodeGrant(settings: [
                "client_id": "b4fe2d0ac24446c37b9ff5085ab43f9f4053ae97f06a283dfa91b875d3c29a7c",                         // yes, this client-id and secret will work!
                "client_secret": "9a7d51a35992e06b27b158d348feaa3e5692124388a81f576365aa090edbcdb5",
                "authorize_uri": "https://people-total-staging.herokuapp.com/oauth/authorize",
                "token_uri": "https://people-total-staging.herokuapp.com/oauth/token",
                "redirect_uris": ["peopleauthapp://oauth/callback"],            // app has registered this scheme
                "secret_in_body": true,                                      // GitHub does not accept client secret in the Authorization header
                "verbose": true
                ] as OAuth2JSON)
        }
        if (oauth2?.isAuthorizing)! {
            oauth2?.abortAuthorization()
            return
        }
        
        oauth2?.forgetTokens()
        
        sender?.setTitle("Authorizing...", for: UIControlState.normal)
         oauth2?.logger = OAuth2DebugLogger(.trace)
        oauth2?.authConfig.authorizeEmbedded = true		// the default
        oauth2?.authConfig.ui.useSafariView = false
        oauth2?.authConfig.authorizeContext = self
        
//        oauth2.authorize() { authParameters, error in
//            if let params = authParameters {
//                print("Authorized! Access token is in `oauth2.accessToken`")
//                print("Authorized! Additional parameters: \(params)")
//            }
//            else {
//                print("Authorization was cancelled or went wrong: \(error)")   // error will not be nil
//            }
//        }

        
        let loader = OAuth2DataLoader(oauth2: oauth2!)
        self.loader = loader
        print("token : \(String(describing: oauth2?.accessToken))")
//        if oauth2.accessToken != nil {
//            self.token = oauth2.accessToken!
//            self.performSegue(withIdentifier: "signIn", sender: nil)
//        }
       loader.perform(request: userDataRequest) { response in
            do {
                DispatchQueue.main.async {
                    
                    if self.oauth2?.accessToken != nil {
                        // Store accessToken Locally
                        let defaults = UserDefaults.standard
                        defaults.set(self.oauth2?.accessToken, forKey: "accessToken")
                        
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Storyboard", bundle: nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = viewController
                        appDelegate.window?.makeKeyAndVisible()
                    }
                    else {
                        sender?.setTitle("Sign in", for: UIControlState.normal)
                    }
                }
                print("sigin in safari")
                //let json = try response.responseJSON()
                //dump("jsons : \(json)")
                //self.didGetUserdata(json: json, loader: loader)
            }
            catch let error {
                //self.didCancelOrFail(error)
            }
        }
 
    }
    
    
    var userDataRequest: URLRequest {
        print("isProd : \(self.isProd)")
        if self.isProd == true {
            var request = URLRequest(url: URL(string: "https://people.total/api/v1/users")!)
            return request
        }
        else {
            var request = URLRequest(url: URL(string: "https://people-total-staging.herokuapp.com/api/v1/users")!)
            return request
        }
        //request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
    }
    
    /*func didGetUserdata(json: [String: Any], loader: OAuth2DataLoader?) {
        DispatchQueue.main.async {
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
                    if let relation = (json[i]["relationships"][j].dictionaryValue) as? Dictionary{
                        
                        //let id = relation["target"]?["user_id"].int
                        var profile = Profile()
                        var user = User()
                        user.first_name = relation["target"]?["first_name"].stringValue
                        user.last_name = relation["target"]?["last_name"].stringValue
                        user.image = relation["target"]?["picture_url"].stringValue
                        user.job = relation["target"]?["job_title"].stringValue
                        profile.user = user
                        switch ((relation["kind"]?.stringValue)!) {
                        case "is_manager_of":
                            print("kind : \((relation["kind"]?.stringValue)!)")
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
                
                for j in 0..<json[i]["projects"].count {
                    var project = Project()
                    let proj = (json[i]["projects"][j])
                    //dump("proj : \(proj["id"])")
                    // project = self.projects.first {$0.id! == proj["id"].intValue}!
                    
                    project.title = proj["name"].stringValue
                    project.location = proj["location"].stringValue
                    project.description = proj["project_participations"][0]["role_description"].stringValue
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
                    var job = Job()
                    if let j = (json[i]["jobs"][j].dictionaryValue) as? Dictionary {
                        job.title = j["title"]?.stringValue
                        job.location = j["location"]?.stringValue
                        job.id = j["id"]?.intValue
                        job.start_date = j["start_date"]?.stringValue
                        job.end_date = j["end_date"]?.stringValue
                        job.description = j["description"]?.stringValue
                        
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
                //dump("relations : \(profile.relations)")
                if let id = json[i]["id"].intValue as? Int {
                    profile.id = id
                    print("id profile : \(profile.id)")
                }
                //dump(profile)
                self.profiles.append(profile)
                //defaults.set(self.profiles, forKey: "profiles")
                print("coucou")
            }

    }
}*/
    
    func didCancelOrFail(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                print("Authorization went wrong: \(error)")
            }
        }
    }

   /* override func viewDidLoad() {
        super.viewDidLoad()
     
     
        // Do any additional setup after loading the view, typically from a nib.
     
        //DataGenerator.sharedInstance.getUser()
        oauth2.forgetTokens()
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("Already ")
            .bold("17281 colleagues ")
            .normal("in ")
            .bold("your ")
            .normal("network.")
        
        sentenceLabel.attributedText = formattedString
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        
        signinButton.layer.cornerRadius = 2
        signinButton.layer.borderWidth = 2
        signinButton.layer.borderColor = UIColor.white.cgColor
    }*/

    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        if APIUtility.sharedInstance.isProd == false {
            self.logo.image = UIImage()
            self.privacyTerms.isHidden = true
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //getData()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults: UserDefaults = UserDefaults.standard
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

