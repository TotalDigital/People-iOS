//
//  myProfileViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 01/02/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit
import SwiftyJSON
import SafariServices
import MessageUI
import SVProgressHUD
import IQKeyboardManagerSwift

extension UICollectionView {
    func indexPathForView(view: AnyObject) -> NSIndexPath? {
        let originInCollectioView = self.convert(CGPoint.zero, from: (view as! UIView))
        return self.indexPathForItem(at: originInCollectioView) as NSIndexPath?
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


class addProjectTableViewCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!
    
}

class NewLabel2: UILabel {
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        return self.bounds.insetBy(dx: CGFloat(15.0), dy: CGFloat(15))
    }
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: self.bounds.insetBy(dx: CGFloat(25.0), dy: CGFloat(25.0)))
    }
    
}


class myProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureProfileImage: UIImageView!
    
    @IBOutlet weak var nameProfileLabel: UILabel!
    
    @IBOutlet weak var titleProfileLabel: UILabel!
    
    @IBOutlet weak var entitiesLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet var externalLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
}


class myProfileInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var jobTitleTextField: UITextField!
    
    @IBOutlet weak var servicesTextField: UITextField!
    
    @IBOutlet weak var officeAdressTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var pen: UIButton!
    
    
}

class myContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var pen: UIButton!
    
    @IBOutlet weak var lblPhonenumber: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var imgLinkedin: UIImageView!
    @IBOutlet weak var lblLinkedin: UILabel!
    @IBOutlet weak var stackLinkedin: UIView!

    @IBOutlet weak var imgTwitter: UIImageView!
    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var stackTwitter: UIView!
    @IBOutlet weak var stackTwitterLeading: NSLayoutConstraint!
}

class myContactInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var emailContactTextField: UITextField!
    
    @IBOutlet weak var phoneContactTextField: UITextField!
    
    @IBOutlet weak var linkedinContactTextField: UITextField!
    
    @IBOutlet weak var twitterContactTextField: UITextField!
    
    @IBOutlet weak var agilContactTextField: UITextField!
    
    @IBOutlet weak var watContactTextField: UITextField!
    
    @IBOutlet weak var lyncContactTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var pen: UIButton!
    
}

class myJobTableViewCell: UITableViewCell {
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
    // @IBOutlet weak var descJob: UILabel!
    @IBOutlet weak var pen: UIButton!
    var selectedIndexPath: IndexPath = []
    
}

class myJobExpandTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobTitleTextField: UITextField!

    

    
    @IBOutlet weak var jobDescTextView: UITextView!

   
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var pen: UIButton!

    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var start_datePicker: UIDatePicker!
    
    @IBOutlet weak var end_datePicker: UIDatePicker!
}

class myEducationTableViewCell: UITableViewCell {
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
    // @IBOutlet weak var descJob: UILabel!
    @IBOutlet weak var pen: UIButton!
    var selectedIndexPath: IndexPath = []
    
}

class myEducationExpandTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobTitleTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var dateEndTextField: UITextField!
    
    @IBOutlet weak var jobDescTextView: AutoCompleteTextField!
    
    @IBOutlet weak var pen: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
}

class myProjectTableViewCell: UITableViewCell {
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectDate: UILabel!
    @IBOutlet weak var projectLocation: UILabel!
    @IBOutlet weak var detailProject: UILabel!
    @IBOutlet weak var pen: UIButton!
}

class myProjectExpandTableViewCell: UITableViewCell {
   
    @IBOutlet var projectTitleTextField: AutoCompleteTextField!

    
    @IBOutlet weak var projectLocationTextField: UITextField!
    
   
    
    @IBOutlet weak var projectDescriptionTextView: UITextView!

    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var start_datePicker: UIDatePicker!
    
    @IBOutlet weak var pen: UIButton!
    
    @IBOutlet weak var end_datePicker: UIDatePicker!

    
}

class myMemberTableViewCell: UITableViewCell {
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var pictureMember: UIImageView!
    @IBOutlet weak var jobTitleLabel: UILabel!
    
}
class myRelationsMemberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var relationMemberName: UILabel!
    @IBOutlet weak var relationMemberPicture: UIImageView!
    @IBOutlet weak var relationMemberJob: UILabel!
}


class myRelationTableViewCell: UITableViewCell {
    @IBOutlet weak var relationType: UILabel!
}



class mySkillTableViewCell: UITableViewCell,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    var sizingCell: CustomCollectionCell?
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var addASkillTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    var gameNames:[String] = []
    var gameNamesIds:[Int] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellNib = UINib(nibName: "CollectionCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "CollectionCell")
        self.collectionView.backgroundColor = UIColor.clear
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! CustomCollectionCell?
     
//        self.flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.configureCell(self.sizingCell!, forIndexPath: indexPath)
        
       
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CustomCollectionCell
        self.configureCell(cell, forIndexPath: indexPath)
    
        return cell
    }
    
    func configureCell(_ cell: CustomCollectionCell, forIndexPath indexPath: IndexPath) {
        let tag = gameNames[indexPath.row]
        
        cell.tagName.text = tag
        cell.crossButton.addTarget(self, action: #selector(deleteSkill(sender:)), for: .touchUpInside)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
       // let myCustomViewController: myProfileViewController = myProfileViewController()
        //dump(myCustomViewController.profile)
        
        if self.infoLabel.text == "Skills"{
            let dictionary:[String: Int] = ["ItemIndex": indexPath.row]
            
            NotificationCenter.default.post(name: Notification.Name("DeleteSkillWithId"), object: dictionary, userInfo: dictionary)
            
//            deleteSkillWithId(skill_id: gameNamesIds[indexPath.row])
        }
        else if self.infoLabel.text == "Language"{
            let dictionary:[String: Int] = ["ItemIndex": indexPath.row]
            
            NotificationCenter.default.post(name: Notification.Name("DeleteLanguageWithId"), object: dictionary, userInfo: dictionary)
        }
        
       /* gameNames.remove(at: (indexPath.row))
        gameNamesIds.remove(at: (indexPath.row))*/
        
        collectionView.reloadData()
    }
    
    func deleteSkill(sender:UIButton) {
       
        print("deleteSkill")
       
    }
    
}

/*class CustomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var tagName: UILabel!
    
    @IBOutlet weak var maxWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        //self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        //self.tagName.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.layer.cornerRadius = 4
        self.maxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2 }
}*/


class mylanguageTableViewCell: UITableViewCell {
    
}



class myProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchDisplayDelegate, UITextViewDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate , OptionButtonsDelegate {
    
    internal func closeFriendsTapped(at index: IndexPath, sender: AnyObject) {
        if(searchActive){
            if filtered.count>0 {
                let row = index.row
                self.toConnect(profile: self.filtered[row],sender: sender,index: index)
            }
        }
    }

     fileprivate var returnHandler : IQKeyboardReturnKeyHandler!
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var entitiesLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tblSearch: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewMember: UITableView!
    
    @IBOutlet var tableViewManager: UITableView!
    
    @IBOutlet var tableViewColleague: UITableView!
    
    @IBOutlet var tableViewRelationMember: UITableView!
    
    @IBOutlet var tableViewTeam: UITableView!
    
    @IBOutlet var tableViewAssitant: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentInformationView: UIView!
    
    
    @IBOutlet weak var addToContactButton: UIButton!
    

    
    var imagePicker = UIImagePickerController()
    
    var isExpand: Bool = false
    
    var profiles: [Profile] = []
    
    var profile = Profile()
    
    var projects: [Project] = []
    
    var relations: [String:[Profile]] = [:]
    
    var selectedCellIndexPath: IndexPath?
    
    var currentRelation: String = ""
    
    var rowSection2: CGFloat = 0.0
    
    var isEditable = false
    
    var isAddingProject = false
    
    var isAddingJob = false
    
    var isAddingDegree = false
    
    var searchActive : Bool = false
    
    var newSkill: String = ""
    
    var newLangue: String = ""
    
    var collectionViewHeightSkill: CGFloat = 0.0
    
    var collectionViewHeightLangue: CGFloat = 0.0
    
    var tempProject = Project()
    
    var tempJob = Job()
    
    var tempDegree = Degree()
    
    var access_token: String = ""
    
    var start_date: NSDate?
    var end_date: NSDate?
    
    var usersSearchPageNo: Int = 0
    var filtered:[Profile] = []
    
    let pagingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    @IBAction func editProfile(_ sender: Any) {
        isEditable = true
        //self.contentView.removeFromSuperview()
       /* let screenSize: CGRect = UIScreen.main.bounds
        let contentSize = screenSize.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - (self.tabBarController?.tabBar.frame.height)!
        tableView.frame = CGRect(x:0, y: 0, width: screenSize.width, height: contentSize * 6.0)*/
        self.tableView.reloadData()
        self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
    }
    
    @objc fileprivate func handleTextFieldInterfaces(sender: AutoCompleteTextField){
        print("handle TExtFiedl")
        sender.onTextChange = {[weak self] text in
            if !text.isEmpty{
                print("handleTextField : \(text)")
                let url: String
                if sender.tag == 0 {
                    url = "projects/search/\(text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
                    print("projects")
                }
                else if sender.tag == 1{
                    
                    url = "skills/search/\(text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
                    print("skills")
                }
                else if sender.tag == 2{
                    url = "languages/search/\(text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
                    print("languages")
                }
                else if sender.tag == 3{
                    url = "schools/search/\(text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
                    self?.tempDegree.school = text
                    print("schools")
                }
                else {
                    return
                }
                
                let param:NSDictionary = [:]
                APIUtility.sharedInstance.getAPICall(token: self!.access_token ,url: url, parameters: param) { (response, error) in
                    //SVProgressHUD.dismiss()
                    if (error == nil)
                    {
                        if sender.tag == 3 {
                            let json = JSON(response)[0]
                            print("json : ")
                            dump(json[0])
                            var names: [String] = []
                            var ids: [Int] = []
                            for i in 0..<json.count {
                                names.append(json[i]["name"].stringValue)
                                ids.append(json[i]["id"].intValue)
                            }
                            
                            sender.autoCompleteStrings = names
                            sender.autoCompleteIds = ids
                            dump("names : \(names)")
                            print("autocomplete string : ")
                            dump(sender.autoCompleteStrings)
                        }
                        else
                        {
                            
                            let json = JSON(response)[0]
                            print("json : ")
                            dump(json[0])
                            var names: [String] = []
                            var ids: [Int] = []
                            var locations:[String] = []
                            for i in 0..<json.count {
                                names.append(json[i]["name"].stringValue)
                                ids.append(json[i]["id"].intValue)
                                locations.append(json[i]["location"].stringValue)
                            }
                            
                            sender.autoCompleteStrings = names
                            sender.autoCompleteIds = ids
                            sender.autoCompleteLocations = locations
                            dump("names : \(names)")
                            print("autocomplete string : ")
                            dump(sender.autoCompleteStrings)
                            
                        }
                    }
                    else {
                        let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        sender.onSelect = {[weak self] text, indexpath in
            print("text : \((sender.autoCompleteStrings?[indexpath.row])!)")
            
            if sender.tag == 3 {
            
                self?.tempDegree.school = (sender.autoCompleteStrings?[indexpath.row])
                self?.tempDegree.school_id = (sender.autoCompleteIds?[indexpath.row])
            }
            else
            {
                self?.tempProject.title = (sender.autoCompleteStrings?[indexpath.row])
                self?.tempProject.id = (sender.autoCompleteIds?[indexpath.row])
                self?.tempProject.location = (sender.autoCompleteLocations?[indexpath.row])
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        let buttonPosition:CGPoint = textView.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        print(textView.text); //the textView parameter is the textView where text was changed
        /*if isAddingProject == true {
            tempProject = profile.projects[(indexPath?.row)!]
        }
        if isAddingJob == true {
            tempJob = profile.jobs[(indexPath?.row)!]
        }*/
        switch(indexPath!.section) {
            case 2:
                if isAddingJob == true {
                    tempJob.objDescription = textView.text
                }
                else {
                    profile.jobs[(indexPath?.row)!].objDescription = textView.text
            }
            case 3:
                if isAddingProject == true {
                    tempProject.objDescription = textView.text
                }
                else {
                    profile.projects[(indexPath?.row)!].objDescription = textView.text
            }
        case 4:
            if isAddingDegree == true {
                tempDegree.school = textView.text
            }
            else {
                profile.degree[(indexPath?.row)!].school = textView.text
            }
            default:
                break
        }
        
    }
    
    func saveJobSection(sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "myJobCellExpand", for: indexPath! as IndexPath) as! myJobExpandTableViewCell
         
         print("textField : \(cell.jobTitleTextField.text!)")
         profile.jobs[(indexPath?.row)!].title! = cell.jobTitleTextField.text!
         profile.jobs[(indexPath?.row)!].company! = cell.companyTextField.text!
         profile.jobs[(indexPath?.row)!].date = cell.dateTextField.text
         profile.jobs[(indexPath?.row)!].location = cell.locationTextField.text
         profile.jobs[(indexPath?.row)!].description = cell.jobTextView.text
         
         penEdit(sender: sender)
         */
        //self.selectedCellIndexPath = indexPath
       print("savejobsection")
        print("isAddingProject : \(self.isAddingProject)")
        print("isAdding Job : \(self.isAddingJob)")
        print("isEditable : \(isEditable)")
        print("isExpand : \(isExpand)")
        
        if indexPath?.section == 6 {
            if indexPath?.row == 1 {
                if newSkill.characters.count>0 {
                    
                    let newIndexPath = IndexPath(row: 0, section: 6)
                    let cell : mySkillTableViewCell = tableView.cellForRow(at: newIndexPath) as! mySkillTableViewCell
                    cell.addASkillTextField.text = ""
                 
                    getSkill(search_term: newSkill)
                }
                
//                (self.profile.skills.skills).append(newSkill)
                
                //self.editProfileAPI(parameters: ["skills": self.profile.skills.skills])
            }
            else if indexPath?.row == 3 {
                
                if newLangue.characters.count>0 {
                    
                    let newIndexPath = IndexPath(row: 2, section: 6)
                    let cell : mySkillTableViewCell = tableView.cellForRow(at: newIndexPath) as! mySkillTableViewCell
                    cell.addASkillTextField.text = ""
                    
                    getLanguage(search_term: newLangue)
                }
                
//                (self.profile.langues.langues).append(newLangue)
                
//                self.editProfileAPI(parameters: ["skills": newLangue])
            }
        }
        if self.isAddingProject == true || self.isAddingJob == true || self.isAddingDegree == true {
            isExpand = !isExpand
            isEditable = !isEditable
            
            if self.isAddingProject == true {
                self.isAddingProject = false
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MM-yyyy"
                var date:NSDate? = nil
                if (tempProject.start_date != nil ) {
                    date = dateFormatterGet.date(from: tempProject.start_date!) as? NSDate
                }
                if tempProject.start_date == nil || date == nil {
                    let alert = UIAlertController(title: "Oops!", message: "Some field are missing", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                else {
                
                print("isADding project")
                
                var param: NSDictionary = [:]
                if (tempProject.id != nil) {
                    param = ["project_participation": ["start_date": tempProject.start_date, "end_date": tempProject.end_date, "user_id": self.profile.id, "role_description": tempProject.objDescription], "project": ["id": tempProject.id]]
                }
                else {
                    param = ["project_participation": ["start_date": tempProject.start_date, "end_date": tempProject.end_date, "user_id": self.profile.id, "role_description": tempProject.objDescription], "project": ["name": tempProject.title, "location": tempProject.location]]
                }
                editProfileAPI(profile: self.profile, param: param, url: "project_participations", request: "POST")
              
                }
            }
            
            if self.isAddingJob == true {
                self.isAddingJob = false
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "dd-MM-yyyy"
                var date:NSDate? = nil
                print("tempJob debug : \(tempJob.start_date)")
                if (tempJob.start_date != nil ) {
                    date = dateFormatterGet.date(from: tempJob.start_date!) as? NSDate
                }
                if tempJob.start_date == nil || date == nil {
                    let alert = UIAlertController(title: "Oops!", message: "Some field are missing", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                    
                else {
                
                let param: NSDictionary = ["job": ["title": tempJob.title, "start_date": tempJob.start_date, "end_date": tempJob.end_date, "description": tempJob.objDescription, "location": tempJob.location, "user_id": profile.id]]
                editProfileAPI(profile: self.profile, param: param, url: "jobs", request: "POST")
                
            }
            }
            if self.isAddingDegree == true {
                self.isAddingDegree = false
                var param: NSDictionary = [:]
                if tempDegree.school_id != nil {
                    param = ["degree": ["title": tempDegree.title, "entry_year": tempDegree.entry_year, "graduation_year": tempDegree.graduation_year, "user_id":self.profile.id],"school": ["id": tempDegree.school_id,"name": tempDegree.school]]
                }
                else {
                    param = ["degree": ["title": tempDegree.title, "entry_year": tempDegree.entry_year, "graduation_year": tempDegree.graduation_year, "user_id":self.profile.id],"school": ["name": tempDegree.school]]
                }
                //let param: NSDictionary = ["degree": ["title": tempDegree.title, "entry_year": tempDegree.entry_year, "graduation_year": tempDegree.graduation_year, "user_id": profile.id]]
                editProfileAPI(profile: self.profile, param: param, url: "degrees", request: "POST")
            
            }
        }
        else {
        self.selectedCellIndexPath = indexPath
        isExpand = !isExpand
        isEditable = !isEditable
        
            if indexPath?.section == 0 || indexPath?.section == 1 {
            let param: NSDictionary = ["user": ["first_name":profile.user?.first_name, "last_name":profile.user?.last_name, "job_title": profile.user?.job, "entity":profile.user?.entities, "office_address":profile.user?.location, "email":profile.contact.email, "phone":profile.contact.phone_number, "linkedin":profile.contact.linkedin_profile, "twitter":profile.contact.twitter_profile, "wat_link":profile.contact.wat_profile]]
            editProfileAPI(profile: self.profile, param: param, url: "users/\(Int(profile.id))", request: "PUT")
            }
            else if indexPath?.section == 2 && indexPath!.row < self.profile.jobs.count {
                var job: Job = self.profile.jobs[indexPath!.row]
                let param: NSDictionary = ["job": ["title": job.title, "start_date": job.start_date, "end_date": job.end_date, "description": job.objDescription, "location": job.location, "user_id": self.profile.id]]
                editProfileAPI(profile: self.profile, param: param, url: "jobs/\(job.id!)", request: "PUT")
            }
            else if indexPath?.section == 3 && self.profile.projects.count > (indexPath?.row)! {
                var project: Project = self.profile.projects[indexPath!.row]
                print("project participation : \(project.participation_id)")
                let param: NSDictionary = ["project_participation_id": project.participation_id, "project_participation": ["start_date": project.start_date, "end_date": project.end_date, "role_description": project.objDescription]]
                editProfileAPI(profile: self.profile, param: param, url:"project_participations/\(project.participation_id!)", request: "PUT")
                if project.owner == true {
                    
                    /*let param: NSDictionary = ["project": ["name":"Total", "location": "somewhere"]]
                    dump("param : \(param)")
                    editProfileAPI(profile: self.profile, param: param, url: "project/\(project.id!)", request: "PUT")*/
                    let url = URL(string: "https://people.total/api/v1/projects/\(project.id!)?access_token=95617ac612022a951fb80889ae9804c609036610b98082987c834d1263c7e9e2")!
                    let param: NSDictionary = ["project": ["name":project.title, "location": project.location]]
                    dump("param : \(param)")
                    var request = URLRequest(url: url)
                    request.httpMethod = "PUT"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    //request.httpBody = "{\n  \"project\": {\n    \"name\": \(project.title!),\n    \"location\": \(project.location!)\n  }\n}".data(using: .utf8)
                    //print("{\n  \"project\": {\n    \"name\": \(project.title!),\n    \"location\": \(project.location!)\n  }\n}")
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let response = response, let data = data {
                            print(response)
                            print(String(data: data, encoding: .utf8))
                        } else {
                            print(error)
                        }
                    }
                    
                    task.resume()
                }
            }
            else if indexPath?.section == 4 && self.profile.degree.count > (indexPath?.row)! {
                var education: Degree = self.profile.degree[indexPath!.row]
                let param: NSDictionary = ["degree_id": education.degree_id,"degree": ["title": education.title, "entry_year": education.entry_year, "graduation_year": education.graduation_year, "user_id":self.profile.id],"school": ["id": education.school_id,"name": education.school]]
                editProfileAPI(profile: self.profile, param: param, url: "degrees/\(education.degree_id!)", request: "PUT")
            }
        }
    

        if indexPath?.section == 7 {
            let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Do you want to logout from the app?", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            let removeAction: UIAlertAction = UIAlertAction(title: "Logout", style: .destructive) { action -> Void in
                //Just dismiss the action sheet
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Storyboard", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "InstanceViewController") as! InstanceViewController
    
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = viewController
                appDelegate.window?.makeKeyAndVisible()

                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "accessToken")
                defaults.synchronize()

                //                let urlString = "https://people.total/oauth/logout"
//                if let url = NSURL(string: urlString) {
//                    let vc = SFSafariViewController(url: url as URL, entersReaderIfAvailable: true)
//                    self.present(vc, animated: true, completion: {
////                        self.goToLoginView()
//                    })
//                }
                
                let storage = HTTPCookieStorage.shared
                storage.cookies?.forEach() { storage.deleteCookie($0) }

                defaults.synchronize()
                
//                let storage = HTTPCookieStorage.shared
//                for cookie in storage.cookies!{
//                    storage.deleteCookie(cookie)
//                }
            }
            actionSheetController.addAction(cancelAction)
            actionSheetController.addAction(removeAction)
            self.present(actionSheetController, animated: true, completion: nil)
        }
        
        self.tableView.reloadData()
        self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
    }
    
    func textFieldShouldReturn(sender: UITextField!) -> Bool {
        sender.resignFirstResponder()
        print("return pressed")
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        switch(indexPath!.section) {
        case 6:
            print("skill : \(sender.text!)")
            switch(indexPath!.row) {
            case 0:
                self.getSkill(search_term: sender.text!)
                sender.text = ""
            //dump(profile.skills.skills)
            case 2:
                self.getLanguage(search_term: sender.text!)
                sender.text = ""
            default:
                break
            }
        default:
            break
        }
        return true
    }
    
    func textFieldDidChange(sender: UITextField) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "myJobCellExpand", for: indexPath! as IndexPath) as! myJobExpandTableViewCell
        print("sender : \(sender.text!)")
        switch(indexPath!.section) {
            case 2:
                if isAddingJob == false {
                    tempJob = profile.jobs[(indexPath?.row)!]
                }
                switch(sender.tag) {
                case 0:
                    tempJob.title = sender.text!
                case 3:
                    tempJob.location = sender.text!
    
                default:
                    break
                }
        case 3:
            if isAddingProject == false {
                tempProject = profile.projects[(indexPath?.row)!]
               
                }
            switch(sender.tag) {
            case 0:
                tempProject.title = sender.text!
            case 1:
                tempProject.start_date = sender.text!
            case 2:
                if tempProject.id != nil {
                    sender.text = tempProject.location
                }
                else {
                    tempProject.location = sender.text!
        
                }
            case 3:
                tempProject.end_date = sender.text!
            default:
                break
            }
        case 4:
            if isAddingDegree == false {
                tempDegree = profile.degree[(indexPath?.row)!]
            }
            switch(sender.tag) {
            case 0:
                tempDegree.title = sender.text!
            case 1:
                tempDegree.entry_year = sender.text!
                print("entry_year debug : \(String(describing: tempDegree.entry_year))")
            case 2:
                tempDegree.graduation_year = sender.text!
                print("graduation_year debug : \(String(describing: tempDegree.entry_year))")
            default:
                break
            }
        case 6:
            print("skill : \(sender.text!)")
            switch(indexPath!.row) {
                case 0:
                    self.newSkill = sender.text!
                    //dump(profile.skills.skills)
                case 2:
                    self.newLangue = sender.text!
                default:
                    break
            }
        case 0:
            switch(sender.tag) {
                case 0:
                    self.profile.user?.first_name = sender.text!
                case 1:
                    self.profile.user?.last_name = sender.text!
                case 2:
                    self.profile.user?.job = sender.text!
                case 3:
                    self.profile.user?.entities = sender.text!
                case 4:
                    self.profile.user?.location = sender.text!
                default:
                    break;
            }
        case 1:
            switch(sender.tag) {
                case 0:
                    self.profile.contact.email = sender.text!
                case 1:
                    self.profile.contact.phone_number = sender.text!
                case 2:
                    self.profile.contact.linkedin_profile = sender.text!
                case 3:
                    self.profile.contact.twitter_profile = sender.text!
                case 4:
                    self.profile.contact.agil_profile = sender.text!
                case 5:
                    self.profile.contact.wat_profile = sender.text!
                case 6:
                    self.profile.contact.skipe = sender.text!
                default:
                    break;
            }
        default:
            break;
        }
    }
    
    func textFieldEditingDidEndOnExit(sender: UITextField) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        switch(indexPath!.section) {
        case 6:
            switch(indexPath!.row) {
            case 0:
                sender.resignFirstResponder()
            case 2:
                sender.resignFirstResponder()
            default:
                break
            }
        default:
            break;
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        print("cancelAction is called")
        isExpand = false
        if !isAddingJob || !isAddingProject || !isAddingDegree {
            isAddingJob = false
            isAddingProject = false
            isAddingDegree = false
        }
        if isEditable == true {
            isEditable = false
        }
        
        
        self.tableView.reloadData()
        self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
    }
    
    @IBAction func deleteAnItem(_ sender: UIButton) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Do you want to remove this item?", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        let removeAction: UIAlertAction = UIAlertAction(title: "Remove", style: .destructive) { action -> Void in
            //Just dismiss the action sheet
            
            self.deleteItem(sender)
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(removeAction)
        self.present(actionSheetController, animated: true, completion: nil)
        
    }

    func deleteItem(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        var itemId: Int?
        var path: String = ""
        var param: NSDictionary = [:]
        let ItemIndex = indexPath?.row
        switch (indexPath!.section) {
        case 2:
            
            if let item_id = profile.jobs[(indexPath?.row)!].id {
                path = "jobs/"
                param = ["job_id": item_id]
                self.profile.jobs.remove(at: ItemIndex!)
                itemId = item_id
            }
            
        case 3:
            if  let item_id = profile.projects[(indexPath?.row)!].participation_id {
                path = "project_participations/"
                param = ["project_participation_id": item_id]
                self.profile.projects.remove(at: ItemIndex!)
                itemId = item_id
            }
        case 4:
            print("degree delete :")
            dump(profile.degree)
            if  let item_id = profile.degree[(indexPath?.row)!].degree_id {
                path = "degrees/"
                param = ["degree_id": item_id]
                self.profile.degree.remove(at: ItemIndex!)
                itemId = item_id
            }
        default:
            break;
        }
        
        if itemId != nil {
            
            let url = path + "\(itemId!)"
            
            APIUtility.sharedInstance.deleteAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
                //SVProgressHUD.dismiss()
                
                
                self.tableView.reloadData()
                self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                
                if (error == nil)
                {
                    let json = JSON(response)
                    print("response edit profile")
                    dump(json)
                }
                else {
                    let alert = UIAlertController(title: "Oops! Request failed", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Oops!", message: "Delete failed", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func addAnItem(sender: UIButton) {
        let buttonPositionAdd:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPositionAdd)
        
        let newIndexPath = IndexPath(row: 4, section: profile.degree.count)
        let cell = tableView.cellForRow(at: indexPath!) as! addProjectTableViewCell
        let position = cell.button.convert(CGPoint.zero, to:self.tableView)
        self.selectedCellIndexPath = indexPath
        
        dump("position addAntiem : \(position)")
        dump("indexPath add item: \(indexPath)")
        var topOffsetAdd = CGPoint(x: 0, y: buttonPositionAdd.y)
        if (sender.titleLabel?.text)! == "Add a new education" {
            //topOffsetAdd.y -= 200
        }
        print("addANItem is called")
        isExpand = true
        /*let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        var topOffsetAdd = CGPoint(x: 0, y: buttonPosition.y)
        if (sender.titleLabel?.text)! == "Add a new education" {
            topOffsetAdd.y -= 200
        }
        dump("topOffset : \(topOffsetAdd)")
        print("sender title : \(sender.titleLabel?.text!)")
        self.scrollView.setContentOffset(topOffsetAdd, animated: true)*/
        switch((sender.titleLabel?.text)!) {
        case "Add a new project":
            print("add a new project")
   
            isAddingProject = true

            self.tableView.reloadData()
            self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
            break
        case "Add a new job":
            print("add a new job")
            isAddingJob = true
   
            self.tableView.reloadData()
            self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
            break
        case "Add a new education":
            self.isAddingDegree = true
            
            topOffsetAdd.y = position.y
            self.tableView.reloadData()
            self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
            break
        default:
            break
        }
   
        print("tableViewContentSize : \(tableViewContentSize().height)")
        dump("topOffset : \(topOffsetAdd)")
        print("sender title : \(sender.titleLabel?.text!)")
        self.scrollView.setContentOffset(topOffsetAdd, animated: true)
        
    }
    
    func penEdit(sender: UIButton) {
        
        print("penEdit is called")
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        
        self.selectedCellIndexPath = indexPath
        print("isExpand penedit : \(isExpand)")
        
        if (isExpand == true) {
            saveJobSection(sender: sender)
           
        }
        else {
            var topOffset = CGPoint(x: 0, y: buttonPosition.y)
            dump("topOffset : \(topOffset)")
            if indexPath?.section == 0 {
                topOffset = CGPoint(x: 0, y: 0)
            }
            
            self.scrollView.setContentOffset(topOffset, animated: true)
            isExpand = !isExpand
            isEditable = !isEditable
        }
        
        

        self.tableView.reloadData()
        self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
        
       
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
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
 //the textView parameter is the textView where text was changed
        /*if isAddingProject == true {
         tempProject = profile.projects[(indexPath?.row)!]
         }
         if isAddingJob == true {
         tempJob = profile.jobs[(indexPath?.row)!]
         }*/
        switch(indexPath!.section) {
        case 2:
            if isAddingJob == true {
                tempJob.start_date = dateFormatter.string(from: sender.date)
            }
            else {
                profile.jobs[(indexPath?.row)!].start_date = dateFormatter.string(from: sender.date)
            }
        case 3:
            if isAddingProject == true {
                tempProject.start_date = dateFormatter.string(from: sender.date)
            }
            else {
                profile.projects[(indexPath?.row)!].start_date = dateFormatter.string(from: sender.date)
            }
            default:
                break;
        }
        
    
        print("start_date : \(self.tempJob.start_date)")
    }
    
    @IBAction func timePickerChanged(_ sender: UIDatePicker) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        //the textView parameter is the textView where text was changed
        /*if isAddingProject == true {
         tempProject = profile.projects[(indexPath?.row)!]
         }
         if isAddingJob == true {
         tempJob = profile.jobs[(indexPath?.row)!]
         }*/
        switch(indexPath!.section) {
        case 2:
            if isAddingJob == true {
                tempJob.end_date = dateFormatter.string(from: sender.date)
            }
            else {
                profile.jobs[(indexPath?.row)!].end_date = dateFormatter.string(from: sender.date)
            }
        case 3:
            if isAddingProject == true {
                tempProject.end_date = dateFormatter.string(from: sender.date)
            }
            else {
                profile.projects[(indexPath?.row)!].end_date = dateFormatter.string(from: sender.date)
            }
        default:
            break;
        }
        print("end_date : \(self.tempProject.end_date)")
    }
    
    //MARK:- Date and time
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        returnHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnHandler.lastTextFieldReturnKeyType = .done
        
        pagingSpinner.color = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        pagingSpinner.hidesWhenStopped = true
        tblSearch.tableFooterView = pagingSpinner
        //tableView.isUserInteractionEnabled = false
//        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
//        
//        statusBar.backgroundColor = UIColor(red: 10/255, green: 106/255,blue: 196/255,alpha: 1.0)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        let defaults = UserDefaults.standard
        if let objAccess_token = defaults.string(forKey: "accessToken") {
            access_token = objAccess_token
        }
        
        tableView.delegate = self
        tableView.dataSource = self

        tblSearch.delegate = self
        tblSearch.dataSource = self
        tblSearch.reloadData()
        
        
       

        self.profile = AppData.sharedInstance.currentUser
        tableView.reloadData()
        
//        // Testing
//        uploadImage(UIImage(named: "iTunesArtwork")!)

        searchBar.delegate = self
        searchBar.placeholder = "Search on people..."
        
        tableViewManager.separatorStyle = .none
        tableViewColleague.separatorStyle = .none
        tableViewAssitant.separatorStyle = .none
        tableViewTeam.separatorStyle = .none
        tableViewMember.separatorStyle = .none
  
        
        tableView.estimatedRowHeight = 116.0
        
       
        contentInformationView.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), thickness: 1.0)
        
       // print("profile l : \(self.profile.langues.langues)")
        /*connectButton.layer.cornerRadius = 2*/
        //addToContactButton.layer.cornerRadius = 2
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(red: 22/255,green: 108/255,blue: 193/255, alpha: 1.0).cgColor
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = UIColor.white
        textFieldInsideSearchBar?.backgroundColor = UIColor(red: 62/255 ,green: 132/255, blue: 200/255, alpha:1.0)
        
        if (textFieldInsideSearchBar!.value(forKey:"attributedPlaceholder") != nil) {
            let attributeDict = [NSForegroundColorAttributeName: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.75)]
            textFieldInsideSearchBar!.attributedPlaceholder = NSAttributedString(string: "Search on People...", attributes: attributeDict)
            
            if let imageView = textFieldInsideSearchBar?.leftView as? UIImageView {
                
                imageView.image = imageView.image?.transform(withNewColor: UIColor(red: 255/255, green: 255/255, blue: 255, alpha: 0.75))
            }
        }
        
        //navigationItem.titleView = searchBar
        
        /*self.navigationController?.navigationBar.barTintColor = UIColor(red: 22/255, green: 108/255, blue: 193/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false*/
        
        let screenSize: CGRect = UIScreen.main.bounds
        let contentSize = screenSize.height - UIApplication.shared.statusBarFrame.height /*- (self.navigationController?.navigationBar.frame.size.height)!*/ - (self.tabBarController?.tabBar.frame.height)!
        contentView.frame = CGRect(x:0,y: 0,width: screenSize.width,height: contentSize * 0.95)
        
        tableView.frame = CGRect(x:0, y: 0, width: screenSize.width, height: contentSize * 6.0)
        //tableView.frame = CGRect(x:0, y: 0, width: screenSize.width, height: contentSize * 6.0)
        //self.tableView.addSubview(tableViewMember)
        //self.scrollView.addSubview(contentView)
        self.scrollView.addSubview(tableView)
        
        view.addSubview(scrollView)
        
        self.view.bringSubview(toFront: tblSearch)
        tblSearch.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
//        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func matchProjectMemberId () {
        print("projects : ")
        //dump(self.projects)
        for i in 0..<self.projects.count {
            for j in 0..<self.projects[i].members.count {
                self.projects[i].members_profile.append(self.profiles.first {$0.id == self.projects[i].members[j]}!)
            }
        }
        //dump(self.projects)
    }
    
    func matchRelationMember () {
        print("projects : ")
        //dump(self.projects)
        for i in 0..<self.profiles.count {
            var profile = self.profiles[i]
            for j in 0..<self.profiles[i].relations.managers.count {
                var id = profile.relations.managers[j]
                self.profiles[i].relations.managers_profile.append(self.profiles.first {$0.id == id}!)
            }
        }
        //dump(self.projects)
    }
    
    func editProfileAPI(profile: Profile, param: NSDictionary, url: String, request: String) {
        //let url = "users/\(profile.id)"
        print("editProfile called")
        if request == "PUT" {
            APIUtility.sharedInstance.putAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
    //SVProgressHUD.dismiss()
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
                }    }
        }
        else if request == "POST" {
            SVProgressHUD.show()
            self.tableView.isUserInteractionEnabled = false
            APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
                
                if (error == nil)
                {
                    
                    let json = JSON(response)
                    print("response edit profile")
                    print(response)
                    if (url == "jobs") {
                        self.tempJob.id = response?["id"] as? Int
                        self.profile.jobs.append(self.tempJob)
                        self.tableView.reloadData()
                        self.tempJob = Job()
                    }
                    else if (url == "project_participations") {
                        self.tempProject.participation_id = response?["id"] as? Int
                        self.profile.projects.append(self.tempProject)
                        self.tableView.reloadData()
                        self.tempProject = Project()
                    }
                    else if (url == "degrees") {
                        self.tempDegree.degree_id = response?["id"] as? Int
                        self.profile.degree.append(self.tempDegree)
                        self.tableView.reloadData()
                        self.tempDegree = Degree()
                    }
                    SVProgressHUD.dismiss()
                    self.tableView.isUserInteractionEnabled = true
                    
                    
                }
                else {
                    SVProgressHUD.dismiss()
                    self.tableView.isUserInteractionEnabled = true
                    let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }            }
        }
    }
    
    func getSkill(search_term: String) {
//        GET /api/v1/skills/search/{search_term}
        
        let url = "skills/search/" + search_term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let param: NSDictionary = [:]
        APIUtility.sharedInstance.getAPICall(token: self.access_token ,url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                let json = JSON(response)
                
                var isFind : Bool = false
                
                for i in 0..<json.count {
               
                    if(json[i]["name"].stringValue == search_term)
                    {
                        isFind = true
                        self.addSkillWithSkillID(skill_id: json[i]["id"].intValue)
                       
                        break
                    }
                }
                
                if !isFind
                {
                    self.postNewSkill(skill_name: search_term)
                }
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func postNewSkill(skill_name: String) {
//        POST /api/v1/skills
        
        let url = "skills"
        
        let param: NSDictionary = ["skill": ["name": skill_name]]
        
        APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                let json = JSON(response)
                
                self.addSkillWithSkillID(skill_id: json["id"].intValue)
                
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
    
    func addSkillWithSkillID(skill_id: Int) {
//        POST /api/v1/users/{user_id}/skills
        
        print("addSkill get called")
        let url = "users/" + "\(self.profile.id)" + "/skills"
        print("url : \(url)")
        print("skill_id : \(skill_id)")
        print("user_id : \(self.profile.id)")
        let param: NSDictionary = ["user_id": self.profile.id, "skill_id": skill_id]
        
        APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                (self.profile.skills.skills).append(self.newSkill)
                (self.profile.skills.skillsIds).append(skill_id)
                print("addSkill succeed")
                self.tableView.reloadData()
                
                self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                
                let json = JSON(response)
                print("response edit profile")
                dump(json)
            }
            else
            {
                let code = (error as! NSError).code
                if (code == -1011)
                {
                    let alert = UIAlertController(title: "", message: "Skill has already been taken", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    (self.profile.skills.skills).append(self.newSkill)
                    (self.profile.skills.skillsIds).append(skill_id)
                    print("addSkill succeed")
                    self.tableView.reloadData()
                    self.tableView.reloadData()
                    self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                }
            }
        }
        
    }
    
    func deleteSkillWithId(notification: NSNotification) {
        
        //        DELETE /api/v1/users/{user_id}/skills/{skill_id}
        
//        profile.skills.skills
        if let ItemIndex = notification.userInfo?["ItemIndex"] as? Int {
            
            if let skill_id = profile.skills.skillsIds[ItemIndex] as? Int {
                
                let url = "users/" + "\(self.profile.id)" + "/skills/" + "\(skill_id)"
                
                let param: NSDictionary = ["user_id": self.profile.id, "skill_id": skill_id]
                
                APIUtility.sharedInstance.deleteAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
                    //SVProgressHUD.dismiss()
                    
                    self.profile.skills.skills.remove(at: ItemIndex)
                    self.profile.skills.skillsIds.remove(at: ItemIndex)
                    
                    self.tableView.reloadData()
                    self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                    
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
        }
        
        
    }
    
    func getLanguage(search_term: String) {
//        GET /api/v1/languages/search/{search_term}
        
        let url = "languages/search/" + search_term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let param: NSDictionary = [:]
        APIUtility.sharedInstance.getAPICall(token: self.access_token ,url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                let json = JSON(response)
                
                var isFind : Bool = false
                
                for i in 0..<json.count {
                    
                    if(json[i]["name"].stringValue == search_term)
                    {
                        isFind = true
                        self.addLanguageWithLanguageID(language_id: json[i]["id"].intValue)
                        break
                    }
                }
                
                if !isFind
                {
                    self.postNewLanguage(language_name: search_term)
                }
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func postNewLanguage(language_name: String) {
//        POST /api/v1/languages
        
        let url = "languages"
        
        let param: NSDictionary = ["language": ["name": language_name]]
        
        APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                let json = JSON(response)
                
                self.addLanguageWithLanguageID(language_id: json["id"].intValue)
                
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
    
    func addLanguageWithLanguageID(language_id: Int) {
        //        POST /api/v1/users/{user_id}/languages
        
        let url = "users/" + "\(self.profile.id)" + "/languages"
        
        let param: NSDictionary = ["user_id": self.profile.id, "language_id": language_id]
        
        APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            if (error == nil)
            {
                (self.profile.langues.langues).append(self.newLangue)
                (self.profile.langues.languesIds).append(language_id)
                self.tableView.reloadData()
                self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                
                let json = JSON(response)
                print("response edit profile")
                dump(json)
            }
            else
            {
                let code = (error as! NSError).code
                if (code == -1011)
                {
                    let alert = UIAlertController(title: "", message: "Language has already been taken", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    (self.profile.langues.langues).append(self.newLangue)
                    (self.profile.langues.languesIds).append(language_id)
                    self.tableView.reloadData()
                    self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                }
            }
        }
        
    }
    
    func deleteLanguageWithId(notification: NSNotification) {
        
//        DELETE /api/v1/users/{user_id}/languages/{language_id}
        
        //        profile.skills.skills
        if let ItemIndex = notification.userInfo?["ItemIndex"] as? Int {
            
            if let langues_id = profile.langues.languesIds[ItemIndex] as? Int {
                
                let url = "users/" + "\(self.profile.id)" + "/languages/" + "\(langues_id)"
                
                let param: NSDictionary = ["user_id": self.profile.id, "language_id": langues_id]
                
                APIUtility.sharedInstance.deleteAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
                    //SVProgressHUD.dismiss()
                    
                    self.profile.langues.langues.remove(at: ItemIndex)
                    self.profile.langues.languesIds.remove(at: ItemIndex)
                    
                    self.tableView.reloadData()
                    self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                    
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
        }
        
        
    }
    
    /*func getJob() {
    
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
                    job.title = json[i]["description"].stringValue
                    job.location = json[i]["location"].stringValue
                    job.start_date = json[i]["start_date"].stringValue
                    job.end_date = json[i]["end_date"].stringValue
                    job.id = json[i]["id"].intValue
                    
                    profile.jobs.append(job)
                }
                
               
                
                self.relations = self.relationsArray(relations: self.profile.relations)
                dump("relations : \(self.relations)")
                
                
                //self.matchProjectMemberId()
            }
        }
    }*/
    
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
    
    /*func relationsArray(relations: Relation) -> [String:[Profile]] {
        dump("relations 2 : \(relations.colleagues_profile)")
        var relationsArray: [String: [Profile]] = [:]
        if relations.managers.count > 0 {
            relationsArray["Managers"] = relations.managers_profile
        }
        if relations.assistant.count > 0 {
            relationsArray["Assistant"] = relations.assistants_profile
        }
        if relations.teamMember.count > 0 {
            relationsArray["Team Members"] = relations.teamMembers_profile
        }
        if relations.colleagues.count > 0 {
            relationsArray["Colleagues"] = relations.colleagues_profile
        }
        return relationsArray 
    }
*/
    
    /*func getRelation() {
        
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
                    profile = self.profiles.first {$0.id == json[i]["source"]["user_id"].intValue}!
                    target_profile = self.profiles.first {$0.id == json[i]["target"]["user_id"].intValue}!
                    print("profile relation : ")
                    //dump(profile)
                    //dump(target_profile)
                    print(json[i]["kind"].stringValue)
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
                print("profiles : ")
                dump(self.profiles)

                self.matchProjectMemberId()
                self.profile = self.profiles[2]
                self.tableView.reloadData()
                //self.getJob()
            }
        }
    }
    */
    
    func getData() {
        
        let param: NSDictionary = [:]
        
        pagingSpinner.startAnimating()
        var url = "users/profile"
        self.profiles = []
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
                    if let external = json["external"].boolValue as? Bool {
                        user.is_external = external
                        print("is_external : \(external)")
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
                        if let relation = json["relationships"][j].dictionaryObject
                        {
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
                            job.end_date = j["end_date"]as? String
                            job.objDescription = j["description"] as? String
                            jobs.append(job)
                        }
                    }
                for j in 0..<json["degrees"].count {
                    var degree = Degree()
                    if let j = json["degrees"][j].dictionaryObject {
                        degree.title = j["title"] as? String
                        degree.degree_id = j["id"] as? Int
                        
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
                profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                
                profile.relations.isRelationAvailable = isRelationAvailable
                profile.relations.relationshipID = relationshipID
                profile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                
                    if let id = json["id"].intValue as? Int {
                        profile.id = id
                    }
                    dump(profile)
                    self.profiles.append(profile)
                    
                    //defaults.set(self.profiles, forKey: "profiles")
                    print("coucou")
                
                self.profile = self.profiles[0]
                
                self.tableView.reloadData()
                self.pagingSpinner.stopAnimating()
                self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                
                //self.getRelation()
                
                self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
                
                //self.matchRelationMember()
        
            }
            else {
                self.pagingSpinner.stopAnimating()
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
}
    
    
    /*func getProject() {
        print("getPRoject called")
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
                print("projects : ")
                dump(self.projects)
                self.getData()
            }
    }
}*/
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
//        navigationController?.setNavigationBarHidden(true, animated: true)
        
        getData()
       
        NotificationCenter.default.addObserver(self, selector: #selector(myProfileViewController.deleteSkillWithId(notification:)), name: Notification.Name("DeleteSkillWithId"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(myProfileViewController.deleteLanguageWithId(notification:)), name: Notification.Name("DeleteLanguageWithId"), object: nil)

        //super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        let screenSize: CGRect = UIScreen.main.bounds
        
        scrollView.contentSize = CGSize(width: tableViewContentSize().width, height: tableViewContentSize().height)
        
//        scrollView.contentSize = CGSize(width: screenSize.width, height: (screenSize.height - UIApplication.shared.statusBarFrame.height - /*(self.navigationController?.navigationBar.frame.size.height)! - */(self.tabBarController?.tabBar.frame.height)!) * 6.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        self.tblSearch.reloadData()
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
            tblSearch.isHidden = true
            filtered.removeAll()
        }
        else {
            searchActive = true;
            tblSearch.isHidden = false
            
                   // getDataWithSearch(txtSearch: searchText)
        }
        
        self.tableView.reloadData()
        self.tblSearch.reloadData()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if tableView == tableViewMember {
            return 1
        }
        else if tableView == self.tableView{
            return 8
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if tableView == self.tblSearch {
            if(searchActive) {
                return filtered.count
            }
            return 0
        }

        //dump(self.relations)
        if tableView == tableViewMember {
            return profile.projects[(selectedCellIndexPath?.row)!].members.count
        }
        else if tableView == self.tableView {
            if section == 2 {
                return self.isAddingJob ? profile.jobs.count + 2 : profile.jobs.count + 1
            }
            else if section == 3 {
                return self.isAddingProject ? profile.projects.count + 2 : profile.projects.count + 1
            }
            else if section == 4 {
                return self.isAddingDegree ? profile.degree.count + 2 : profile.degree.count + 1
            }
            else if section == 5 {
                return self.relations.count
            }
            else if section == 6 {
                return 4
            }
            else if section == 0 {
                return 1
            }
            else if section == 1 {
                return 1
            }
            else if section == 7 {
                return 1
            }
        }
        else if tableView == tableViewManager {
            return (relations["Managers"]?.count)!
        }
        else if tableView == tableViewAssitant {
            return (relations["Assistant"]?.count)!
        }
        else if tableView == tableViewTeam {
            return (relations["Team Members"]?.count)!
        }
        else if tableView == tableViewColleague {
            return (relations["Colleagues"]?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == self.tblSearch {
            return 57.0
        }
        
        if tableView == self.tableView {
            if section == 5 {
                return 0.0
            }
            else if section == 7 {
                return 0.0
            }
            return 55.0
        }
        else if tableView == self.tableViewMember {
            return 0
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section:Int) -> UIView? {
        
        if tableView == self.tblSearch {
            let headerView = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.frame.width, height: 57)))
            
            let label = NewLabel(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
            label.font = UIFont(name: "HelveticaNeue-bold", size: 14)!
            label.textColor = UIColor(red: 112/255, green: 113/255, blue: 115/255, alpha: 1.0)
            label.text = "SEARCH RESULT"
            
            label.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
            
            headerView.addSubview(label)
            //headerView.bringSubview(toFront: label)
            // headerView.backgroundColor = UIColor.red/*(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)*/
            print("label.text :")
            print(label.frame)
            return headerView
        }
        
        let headerView = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.frame.width, height: 55)))
        if tableView == self.tableView {
            
            let label = NewLabel2(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)!
            label.textColor = UIColor(red: 112/255, green: 113/255, blue: 115/255, alpha: 1.0)
            
            label.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
            label.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), thickness: 1.0)
            label.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), thickness: 1.0)

            // headerView.backgroundColor = UIColor.red/*(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)*/
            switch (section) {
            case 2:
                label.text = "Job History"
            case 3:
                label.text = "Project History"
            case 4:
                label.text = "Education History"
            case 5:
                label.text = "RELATIONS"
            case 6:
                label.text = "More Information"
            case 0:
                label.text = "Profile information"
            case 1:
                label.text = "Contact information"
            default:
                break
            }
  
            /*if section == 2 || section ==  3 || section == 4 || section == 5 {
                let button = UIButton(frame: CGRect(x: headerView.frame.width - 55, y: (headerView.frame.height / 2), width: 16, height: 16))
                button.setImage(UIImage(named: "ic_add_box.png"), for: .normal)
                button.tintColor = UIColor(red: 22/255, green: 108/255, blue: 193/255, alpha: 1.0)
                //button.addTarget(self, action: #selector(addAnItem(sender:)), for: .touchUpInside)
                let label2 = UILabel(frame: CGRect(x: headerView.frame.width - 37, y: (headerView.frame.height / 2), width:30, height:16))
                label2.text = "Add"
                label2.textColor = UIColor(red: 22/255, green: 108/255, blue: 193/255, alpha: 1.0)
                label2.font = UIFont(name: "HelveticaNeue", size: 14)!
                headerView.addSubview(label)
                headerView.addSubview(label2)
                headerView.addSubview(button)
                headerView.bringSubview(toFront: button)
                headerView.bringSubview(toFront: label2)

                
            }*/
       
                headerView.addSubview(label)
         
            headerView.layoutIfNeeded()
            
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == tableViewMember && profile.projects[(selectedCellIndexPath?.row)!].members.count > 0{
            return "Project members"
        }
        else if tableView == self.tableView {
            if section == 2 {
                return "JOBS"
            }
            else if section == 3 {
                return "PROJECTS"
            }
            else if section == 4 {
                return "RELATIONS"
            }
            else if section == 5 {
                return "EDUCATION"
            }
            else if section == 6 {
                return "MORE INFOS"
            }
            return ""
        }
        else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAtIndexPath")
        
        if tableView == self.tblSearch {
            
            if let profileVC = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "profileViewController") as? profileViewController {
                
                if self.searchBar.isFirstResponder == true {
                    self.searchBar.resignFirstResponder()
                }

                profileVC.profile = filtered[indexPath.row]
                print("relationsArray : ")
                dump(relationsArray(relations: filtered[indexPath.row].relations))
                let profile = filtered[indexPath.row]
                profileVC.access_token = self.access_token
                profileVC.relations = relationsArray(relations: profile.relations)
                profileVC.isFromNavigationNotAvailable = true
                
                profileVC.callbackLatestProfile = {(newProfile:Profile) in
                    self.filtered[indexPath.row] = newProfile
                    self.tableView.reloadData()
                }

                if let navigator = self.navigationController {
                    navigator.pushViewController(profileVC, animated: true)
                }
            }
        }
        
        self.selectedCellIndexPath = nil
        if tableView == self.tableView && (indexPath.section == 0 || indexPath.section == 1) {
            self.selectedCellIndexPath = indexPath
            self.isExpand = !self.isExpand
            tableView.reloadData()
            self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == self.tblSearch {
            return 80
        }
        
    

        
        if self.isAddingProject == true && indexPath.section == 3 && indexPath.row == self.profile.projects.count {
            print("indexPAth.row : \(indexPath.row)")
            print("700 : \(self.profile.projects.count)")
            return 945.0
        }
        
        if self.isAddingJob == true && indexPath.section == 2 && indexPath.row == self.profile.jobs.count {
            print("indexPAth.row : \(indexPath.row)")
            print("700 : \(self.profile.jobs.count)")
            return 888.0
        }

        if self.isAddingDegree == true && indexPath.section == 4 && indexPath.row == self.profile.degree.count {
            print("indexPAth.row : \(indexPath.row)")
            print("340 : \(self.profile.degree.count)")
            return 400.0
        }

        if tableView == self.tableView && indexPath.section == 6 {
            if indexPath.row == 1 || indexPath.row == 3 {
                return 50.0
            }
            else if indexPath.row == 0 {
                return 150 + collectionViewHeightSkill
            }
            else {
                return 150 + collectionViewHeightLangue
            }
        }

        if isExpand == true && indexPath == selectedCellIndexPath {
            if indexPath.section == 0 {
                return 543.0
            }
            if indexPath.section == 1 {
                return 532.0
            }
            if indexPath.section == 2 {
                return 888.0
            }
            if indexPath.section == 3 {
                return 945.0
            }
            if indexPath.section == 4 {
                return 400.0
            }
        }
        
       /* if tableView == self.tableView && indexPath.section == 4 && indexPath.row == self.profile.projects.count {
            return 50
        }*/
        
        
        
        if tableView == self.tableView && indexPath.section == 3 {
            if indexPath.row == self.profile.projects.count {
                return 68.0
            }
            else if indexPath.row == self.profile.projects.count + 1 {
                return 68.0
            }
            else {
                return 140.0
            }
        }
        
        
        if tableView == self.tableView && indexPath.section == 2 {
            if indexPath.row == self.profile.jobs.count {
                return 68.0
            }
            else if indexPath.row == self.profile.jobs.count + 1{
                return 68.0
            }
            else {
                return 140.0
            }
        }

        if tableView == self.tableView && indexPath.section == 4 {
            if indexPath.row == self.profile.degree.count {
                return 68.0
            }
            else if indexPath.row == self.profile.degree.count + 1{
                return 68.0
            }
            else {
                return 140.0
            }
        }
        
        if tableView == self.tableView  && indexPath.section == 1 {
            return 280.0
        }
            
            
        else if tableView == self.tableView  && indexPath.section == 0 {
            return 320.0
        }


        

        
        
        rowSection2 = 0
        if tableView == self.tableViewColleague {
            return 20 + 20.0 * CGFloat(relations["Colleagues"]!.count)
        }
        if tableView == self.tableViewManager {
            return 20 + 20.0 * CGFloat(relations["Managers"]!.count)
            
        }
        if tableView == self.tableViewTeam {
            return 20 + 20.0 * CGFloat(relations["Team Members"]!.count)
            
        }
        if tableView == self.tableViewAssitant {
            return 20 + 20.0 * CGFloat(relations["Assistant"]!.count)
        }
        
        if tableView == self.tableView && indexPath.section == 5 && indexPath.row != self.relations.count {
            switch Array(relations.keys)[indexPath.row] {
            case "Managers":
                return 40 + CGFloat(relations["Managers"]!.count) * 50.0
            case "Assistant":
                return 40 + CGFloat(relations["Assistant"]!.count) * 50.0
            case "Colleagues":
                return 40 + CGFloat(relations["Colleagues"]!.count) * 50.0
            case "Team Members":
                return 40 + CGFloat(relations["Team Members"]!.count) * 50.0
            default: break
            }
        }
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = UITableViewCell()
        if tableView == self.tblSearch {
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
            }
            return cell;
        }
        else if tableView == self.tableView {
            switch indexPath.section {
            case 2:
                if (self.isAddingJob == true && indexPath.row == profile.jobs.count + 1) || (self.isAddingJob == false && indexPath.row == profile.jobs.count) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addProject", for: indexPath as IndexPath) as! addProjectTableViewCell
                    cell.button.setTitle("Add a new job", for: .normal)
                    cell.button.layer.cornerRadius = 5.0
                    cell.button.addTarget(self, action: #selector(addAnItem(sender:)), for: .touchUpInside)
                    return cell
                }
                else if (self.isAddingJob == true && indexPath.row == profile.jobs.count) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myJobCellExpand", for: indexPath as IndexPath) as! myJobExpandTableViewCell
                    cell.jobTitleTextField.layer.borderWidth = 0.5
                    
                     
                    cell.locationTextField.layer.borderWidth = 0.5
                    cell.jobDescTextView.layer.borderWidth = 0.5
             
                    
                    cell.jobTitleTextField.layer.borderColor = UIColor.gray.cgColor
                   
                     
                    cell.locationTextField.layer.borderColor = UIColor.gray.cgColor
                    cell.jobDescTextView.layer.borderColor = UIColor.gray.cgColor
                
                    
                    
                    
                    cell.jobTitleTextField.text = ""
                 
                     
                    cell.locationTextField.text = ""
                    cell.jobDescTextView.text = ""
                   
                    
                    cell.jobTitleTextField.setLeftPaddingPoints(20)
                   
                     
                    cell.locationTextField.setLeftPaddingPoints(20)
                    // cell.jobDescTextView.setLeftPaddingPoints(20)
                   
                    
                    cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
               
                    cell.saveButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                    cell.saveButton.layer.cornerRadius = 5.0
                    
                    cell.jobTitleTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.jobTitleTextField.tag = 0
                    
                     
                    cell.locationTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.locationTextField.tag = 3
                   
                    
                    print("expand")
                    return cell
                    
                }
                else if isExpand == false || selectedCellIndexPath != indexPath{
                
                    print("isExpand : \(isExpand)")
                    print("selectedCellINdexpath.row : \(selectedCellIndexPath?.row)")
                    print("selectedCellINdexpath.section : \(selectedCellIndexPath?.section)")
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myJobCell", for: indexPath as IndexPath) as! myJobTableViewCell
                    cell.jobTitle.text = profile.jobs[indexPath.row].title!
                   
//                    cell.date.text = profile.jobs[indexPath.row].start_date
                    cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    print("start from job cell : \(profile.jobs[indexPath.row].start_date )")
                    if let start_date = profile.jobs[indexPath.row].start_date {
                        if let end_date = profile.jobs[indexPath.row].end_date {
                            
                            let dateFormatterGet = DateFormatter()
                            let dateFormatterGet2 = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            dateFormatterGet2.dateFormat = "dd-MM-yyyy"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            var date: Date? = dateFormatterGet.date(from: start_date)
                            if date == nil {
                                date = dateFormatterGet2.date(from: start_date)
                            }
                            var date1: Date? = dateFormatterGet.date(from: end_date)
                            if date1 == nil {
                                date1 = dateFormatterGet2.date(from: end_date)
                            }
                         
                            cell.date.text = "From \(dateFormatter.string(from: date!)) to \(dateFormatter.string(from: date1!))"
                        }
                        else
                        {
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            let dateFormatterGet2 = DateFormatter()
                            dateFormatterGet2.dateFormat = "dd-MM-yyyy"
                            
                            var date: Date? = dateFormatterGet.date(from: start_date)
                            if date == nil {
                                date = dateFormatterGet2.date(from: start_date)
                            }
                            
                            cell.date.text = "From \(dateFormatter.string(from: date!))"
                        }
                    }
                    else
                    {
                        if let end_date = profile.jobs[indexPath.row].end_date {
                            
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            let dateFormatterGet2 = DateFormatter()
                            dateFormatterGet2.dateFormat = "dd-MM-yyyy"
                            
                            var date1 = dateFormatterGet.date(from: end_date)
                            if date1 == nil {
                                date1 = dateFormatterGet2.date(from: end_date)
                            }
                            
                            cell.date.text = "To \(dateFormatter.string(from: date1!))"
                        }
                    }
                    
                    cell.location.text = profile.jobs[indexPath.row].location
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myJobCellExpand", for: indexPath as IndexPath) as! myJobExpandTableViewCell
                    cell.jobTitleTextField.layer.borderWidth = 0.5
                    
                     
                    cell.locationTextField.layer.borderWidth = 0.5
                    cell.jobDescTextView.layer.borderWidth = 0.5
                   
                    
                    cell.jobTitleTextField.layer.borderColor = UIColor.gray.cgColor
                  
                     
                    cell.locationTextField.layer.borderColor = UIColor.gray.cgColor
                    cell.jobDescTextView.layer.borderColor = UIColor.gray.cgColor
                
                
                    let dateFormatter = DateFormatter()
                    let dateFormatter2 = DateFormatter()
                    dateFormatter.dateFormat =  "yyyy-MM-dd"
                    dateFormatter2.dateFormat =  "dd-MM-yyyy"
                    var date = dateFormatter.date(from: profile.jobs[indexPath.row].start_date!)
                    if date == nil {
                        date = dateFormatter2.date(from: profile.jobs[indexPath.row].start_date!)
                    }
                    cell.start_datePicker.date = date!
                    if (profile.jobs[indexPath.row].end_date != nil) {
                    date = dateFormatter.date(from: profile.jobs[indexPath.row].end_date!)
                        if date == nil {
                            date = dateFormatter2.date(from: profile.jobs[indexPath.row].end_date!)
                        }
                    
                    cell.end_datePicker.date  = date!
                    }
                    
                    
                    cell.jobTitleTextField.text = profile.jobs[indexPath.row].title
                
                   
                    cell.locationTextField.text = profile.jobs[indexPath.row].location
                    cell.jobDescTextView.text = profile.jobs[indexPath.row].objDescription
             
 
                    cell.jobTitleTextField.setLeftPaddingPoints(20)
     
                     
                    cell.locationTextField.setLeftPaddingPoints(20)
                   // cell.jobDescTextView.setLeftPaddingPoints(20)
                
                    
                    cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    
                    cell.saveButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     cell.saveButton.layer.cornerRadius = 5.0
                    cell.jobTitleTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.jobTitleTextField.tag = 0
               
                     
                    cell.locationTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.locationTextField.tag = 3
                  
                    
                    print("else expandtableviewcell")
                    return cell
                }
            case 3:
                if (self.isAddingProject == true && indexPath.row == profile.projects.count + 1) || (self.isAddingProject == false && indexPath.row == profile.projects.count) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addProject", for: indexPath as IndexPath) as! addProjectTableViewCell
                    cell.button.setTitle("Add a new project", for: .normal)
                    cell.button.layer.cornerRadius = 5.0
                    cell.button.addTarget(self, action: #selector(addAnItem(sender:)), for: .touchUpInside)
                    print("debug cell section 3 add a project")
                    return cell
                }
                else if (self.isAddingProject == true && indexPath.row == profile.projects.count) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myProjectExpandCell", for: indexPath as IndexPath) as! myProjectExpandTableViewCell
                    /*cell.projectTitle.text = profile.projects[indexPath.row].title
                     cell.projectDate.text = profile.projects[indexPath.row].date
                     cell.projectLocation.text = profile.projects[indexPath.row].location
                     cell.detailProject.text = profile.projects[indexPath.row].description*/
                    
                    cell.projectTitleTextField.layer.borderWidth = 0.5
                  
                    cell.projectLocationTextField.layer.borderWidth = 0.5
                    cell.projectDescriptionTextView.layer.borderWidth = 0.5
                    
                    
                    cell.projectTitleTextField.text = ""
                    
                    cell.projectLocationTextField.text = ""
                    cell.projectDescriptionTextView.text = ""
                    
                    cell.projectTitleTextField.setLeftPaddingPoints(20)
                    
                    cell.projectLocationTextField.setLeftPaddingPoints(20)
                   
                    
                    cell.projectTitleTextField.maximumAutoCompleteCount = 10
                    cell.projectTitleTextField.autoCompleteCellHeight = 35.0
                    cell.saveButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     cell.saveButton.layer.cornerRadius = 5.0
                    cell.projectTitleTextField.addTarget(self, action: #selector(handleTextFieldInterfaces(sender:)), for: UIControlEvents.editingChanged)
                    cell.projectTitleTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    
                    cell.projectLocationTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.projectLocationTextField.tag = 2
                   
                    
                    
                    return cell
                    
                }
                else if (isExpand == false || selectedCellIndexPath != indexPath) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myProjectCell", for: indexPath as IndexPath) as! myProjectTableViewCell
                    cell.projectTitle.text = profile.projects[indexPath.row].title
                    
                    let project = profile.projects[indexPath.row]
                    if project.end_date == "" ||  project.end_date == nil {
                        
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        
                        var date: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].start_date!)
                        if date == nil {
                            date = dateFormatter.date(from: profile.projects[indexPath.row].start_date!)
                        }
                        if date != nil {
                            cell.projectDate.text = "From \(dateFormatter.string(from: date!))"
                        }
                    }
                    else {
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        
                        var date: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].start_date!)
                        if date == nil {
                            date = dateFormatter.date(from: profile.projects[indexPath.row].start_date!)
                        }
                        var date1: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].end_date!)
                        if date1 == nil {
                            date1 = dateFormatter.date(from: profile.projects[indexPath.row].end_date!)
                        }
                        
                        if date != nil && date1 != nil {
                            cell.projectDate.text = "\(dateFormatter.string(from: date!)) - \(dateFormatter.string(from: date1!))"
                        }
                    }
                    
                    cell.projectLocation.text = profile.projects[indexPath.row].location
                    cell.detailProject.text = profile.projects[indexPath.row].objDescription
             
                        cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    return cell
                }
                else {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myProjectExpandCell", for: indexPath as IndexPath) as! myProjectExpandTableViewCell
                    /*cell.projectTitle.text = profile.projects[indexPath.row].title
                    cell.projectDate.text = profile.projects[indexPath.row].date
                    cell.projectLocation.text = profile.projects[indexPath.row].location
                    cell.detailProject.text = profile.projects[indexPath.row].description*/
                   
                    cell.projectTitleTextField.layer.borderWidth = 0.5
                
                    cell.projectLocationTextField.layer.borderWidth = 0.5
                    cell.projectDescriptionTextView.layer.borderWidth = 0.5
         
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat =  "yyyy-MM-dd"
                    
                    let dateFormatter2 = DateFormatter()
                    dateFormatter2.dateFormat =  "dd-MM-yyyy"
                    
                    var date = dateFormatter.date(from: profile.projects[indexPath.row].start_date!)
                    if date == nil {
                        date = dateFormatter2.date(from: profile.projects[indexPath.row].start_date!)
                    }
                    print("date here : \(profile.projects[indexPath.row].end_date)")
                    cell.start_datePicker.date = date!
                    
                    if (profile.projects[indexPath.row].end_date != nil && profile.projects[indexPath.row].end_date != "" ) {
                        date = dateFormatter.date(from: profile.projects[indexPath.row].end_date!)
                        if date == nil {
                            date = dateFormatter2.date(from: profile.projects[indexPath.row].end_date!)
                        }
                        cell.end_datePicker.date  = date!
                    }
                
                        cell.projectTitleTextField.text = profile.projects[indexPath.row].title
               
                        cell.projectLocationTextField.text = profile.projects[indexPath.row].location
                        cell.projectDescriptionTextView.text = profile.projects[indexPath.row].objDescription
                
                    cell.projectTitleTextField.setLeftPaddingPoints(20)
                   
                    cell.projectLocationTextField.setLeftPaddingPoints(20)
                   
                    
                    cell.projectTitleTextField.maximumAutoCompleteCount = 10
                    cell.saveButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     cell.saveButton.layer.cornerRadius = 5.0
                    cell.projectTitleTextField.addTarget(self, action: #selector(handleTextFieldInterfaces(sender:)), for: UIControlEvents.editingChanged)
                    cell.projectTitleTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.projectTitleTextField.tag = 0
                    cell.projectLocationTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.projectLocationTextField.tag = 2
                   
                    
        
                    cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
     
                    return cell
                }
            case 4:
                if (self.isAddingDegree == true && indexPath.row == profile.degree.count + 1) || (self.isAddingDegree == false && indexPath.row == profile.degree.count) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addProject", for: indexPath as IndexPath) as! addProjectTableViewCell
                    cell.button.setTitle("Add a new education", for: .normal)
                    let buttonPosition:CGPoint = cell.button.convert(CGPoint.zero, to:self.tableView)
                    dump("position : \(buttonPosition)")
                    print("tableViewContentSize : \(tableViewContentSize().height)")
                    cell.button.layer.cornerRadius = 5.0
                    cell.button.addTarget(self, action: #selector(addAnItem(sender:)), for: .touchUpInside)
                    return cell
                }
                else if (self.isAddingDegree == true && indexPath.row == profile.degree.count) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myEducationExpandTableViewCell", for: indexPath as IndexPath) as! myEducationExpandTableViewCell
                    cell.jobTitleTextField.layer.borderWidth = 0.5
                     cell.dateTextField.layer.borderWidth = 0.5
                    cell.jobDescTextView.layer.borderWidth = 0.5
                    cell.dateEndTextField.layer.borderWidth = 0.5
                    
                    cell.jobTitleTextField.layer.borderColor = UIColor.gray.cgColor
                     cell.dateTextField.layer.borderColor = UIColor.gray.cgColor
                    cell.jobDescTextView.layer.borderColor = UIColor.gray.cgColor
                    cell.dateEndTextField.layer.borderColor = UIColor.gray.cgColor
                    
                    
                    cell.jobTitleTextField.text = ""
                     cell.dateTextField.text = ""
                    cell.jobDescTextView.text = ""
                    cell.dateEndTextField.text = ""
                    
                    cell.jobTitleTextField.setLeftPaddingPoints(20)
                     cell.dateTextField.setLeftPaddingPoints(20)
                     cell.jobDescTextView.setLeftPaddingPoints(20)
                    cell.dateEndTextField.setLeftPaddingPoints(20)
                    
                    cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    cell.saveButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     cell.saveButton.layer.cornerRadius = 5.0
                    cell.jobTitleTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.jobTitleTextField.tag = 0
                    
                    cell.dateTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.dateTextField.tag = 1
                    
                    cell.dateEndTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.dateEndTextField.tag = 2
                    
                    cell.jobDescTextView.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.jobDescTextView.tag = 3
                    cell.jobDescTextView.addTarget(self, action: #selector(handleTextFieldInterfaces(sender:)), for: UIControlEvents.editingChanged)
                    cell.jobDescTextView.maximumAutoCompleteCount = 10
                    
                    print("expand")
                    return cell
                    
                }
                else if isExpand == false || selectedCellIndexPath != indexPath {
                    print("isExpand : \(isExpand)")
                    print("selectedCellINdexpath.row : \(selectedCellIndexPath?.row)")
                    print("selectedCellINdexpath.section : \(selectedCellIndexPath?.section)")
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myEducationTableViewCell", for: indexPath as IndexPath) as! myEducationTableViewCell
                    cell.jobTitle.text = profile.degree[indexPath.row].title
                    
                    if let start_date = profile.degree[indexPath.row].entry_year {
                        if let end_date = profile.degree[indexPath.row].graduation_year {
                            cell.date.text = "\(profile.degree[indexPath.row].entry_year!) - \(profile.degree[indexPath.row].graduation_year!)"
                        }
                        else
                        {
                            cell.date.text = "\(profile.degree[indexPath.row].entry_year!)"
                        }
                    }
                    else
                    {
                        if let end_date = profile.degree[indexPath.row].graduation_year {
                            cell.date.text = "\(profile.degree[indexPath.row].graduation_year!)"
                        }
                    }

                    cell.location.text = profile.degree[indexPath.row].school
                    
                    cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    print("notexpand")
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myEducationExpandTableViewCell", for: indexPath as IndexPath) as! myEducationExpandTableViewCell
                    cell.jobTitleTextField.layer.borderWidth = 0.5
                     
                    cell.jobDescTextView.layer.borderWidth = 0.5
                    cell.dateEndTextField.layer.borderWidth = 0.5
                    cell.dateTextField.layer.borderWidth = 0.5
                    
                    cell.jobTitleTextField.layer.borderColor = UIColor.gray.cgColor
                     
                    cell.jobDescTextView.layer.borderColor = UIColor.gray.cgColor
                    cell.dateEndTextField.layer.borderColor = UIColor.gray.cgColor
                    cell.dateTextField.layer.borderColor = UIColor.gray.cgColor
                    
                    cell.jobTitleTextField.text = profile.degree[indexPath.row].title
                    cell.dateTextField.text = profile.degree[indexPath.row].entry_year
                    cell.jobDescTextView.text = profile.degree[indexPath.row].school
                    cell.dateEndTextField.text = profile.degree[indexPath.row].graduation_year
                    
                    cell.jobTitleTextField.setLeftPaddingPoints(20)
                     cell.dateTextField.setLeftPaddingPoints(20)
                    cell.jobDescTextView.setLeftPaddingPoints(20)
                    cell.dateEndTextField.setLeftPaddingPoints(20)
                    
                    cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    cell.saveButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     cell.saveButton.layer.cornerRadius = 5.0
                    cell.jobTitleTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.jobTitleTextField.tag = 0
                    
                    cell.dateTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.dateTextField.tag = 1
                    
                    cell.dateEndTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.dateEndTextField.tag = 2

                    cell.jobDescTextView.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.jobDescTextView.tag = 3
                    cell.jobDescTextView.addTarget(self, action: #selector(handleTextFieldInterfaces(sender:)), for: UIControlEvents.editingChanged)
                    cell.jobDescTextView.maximumAutoCompleteCount = 10
                    
                    print("expand")
                    return cell
                }
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "myRelationCell", for: indexPath as IndexPath) as! myRelationTableViewCell
                switch (indexPath.row) {
                case 0:
                    var tableViewRelation: UITableView = UITableView()
                    var height: CGFloat = 0
                    switch Array(relations.keys)[indexPath.row] {
                    case "Managers":
                        tableViewRelation = tableViewManager
                        height = CGFloat(relations["Managers"]!.count) * 50.0
                    case "Assistant":
                        tableViewRelation = tableViewAssitant
                        height = CGFloat(relations["Assistant"]!.count) * 50.0
                    case "Colleagues":
                        tableViewRelation = tableViewColleague
                        height = CGFloat(relations["Colleagues"]!.count) * 50.0
                    case "Team Members":
                        tableViewRelation = tableViewTeam
                        height = CGFloat(relations["Team Members"]!.count) * 50.0
                    default: break
                    }
                    tableViewRelation.frame = CGRect(x:0,y: 40,width: Int(UIScreen.main.bounds.width),height: Int(height))
                    cell.relationType.text = Array(relations.keys)[indexPath.row]
                    self.currentRelation = Array(relations.keys)[indexPath.row]
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation)
                case 1:
                    var tableViewRelation1: UITableView = UITableView()
                    var height: CGFloat = 0.0
                    switch Array(relations.keys)[indexPath.row] {
                    case "Managers":
                        tableViewRelation1 = tableViewManager
                        height = CGFloat(relations["Managers"]!.count) * 50.0
                    case "Assistant":
                        tableViewRelation1 = tableViewAssitant
                        height = CGFloat(relations["Assistant"]!.count) * 50.0
                    case "Colleagues":
                        tableViewRelation1 = tableViewColleague
                        height = CGFloat(relations["Colleagues"]!.count) * 50.0
                    case "Team Members":
                        tableViewRelation1 = tableViewTeam
                        height = CGFloat((relations["Team Members"]?.count)!) * 50.0
                    default: break
                    }
                    tableViewRelation1.frame = CGRect(x:0,y: 40,width: Int(UIScreen.main.bounds.width),height: Int(height))
                    cell.relationType.text = Array(relations.keys)[indexPath.row]
                    self.currentRelation = Array(relations.keys)[indexPath.row]
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation1)
                case 2:
                    var tableViewRelation2: UITableView = UITableView()
                    var height: CGFloat = 0.0
                    switch Array(relations.keys)[indexPath.row] {
                    case "Managers":
                        tableViewRelation2 = tableViewManager
                        height = CGFloat(relations["Managers"]!.count) * 50.0
                    case "Assistant":
                        tableViewRelation2 = tableViewAssitant
                        height = CGFloat(relations["Assistant"]!.count) * 50.0
                    case "Colleagues":
                        tableViewRelation2 = tableViewColleague
                        height = CGFloat(relations["Colleagues"]!.count) * 50.0
                    case "Team Members":
                        tableViewRelation2 = tableViewTeam
                        height = CGFloat(relations["Team Members"]!.count) * 50.0
                    default: break
                    }
                    tableViewRelation2.frame = CGRect(x:0,y: 40,width: Int(UIScreen.main.bounds.width),height: Int(height))
                    cell.relationType.text = Array(relations.keys)[indexPath.row]
                    self.currentRelation = Array(relations.keys)[indexPath.row]
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation2)
                case 3:
                    var tableViewRelation3: UITableView = UITableView()
                    var height: CGFloat = 0.0
                    switch Array(relations.keys)[indexPath.row] {
                    case "Managers":
                        tableViewRelation3 = tableViewManager
                        height = CGFloat(relations["Managers"]!.count) * 50.0
                    case "Assistant":
                        tableViewRelation3 = tableViewAssitant
                        height = CGFloat(relations["Assistant"]!.count) * 50.0
                    case "Colleagues":
                        tableViewRelation3 = tableViewColleague
                        height = CGFloat(relations["Colleagues"]!.count) * 50.0
                    case "Team Members":
                        tableViewRelation3 = tableViewTeam
                        height = CGFloat(relations["Team Members"]!.count) * 50.0
                    default: break
                    }
                    tableViewRelation3.frame = CGRect(x:0,y: 40,width: Int(UIScreen.main.bounds.width),height: Int(height))
                    cell.relationType.text = Array(relations.keys)[indexPath.row]
                    self.currentRelation = Array(relations.keys)[indexPath.row]
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation3)
                case self.relations.count:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addProject", for: indexPath as IndexPath) as! addProjectTableViewCell
                    cell.button.setTitle("Add a new relation", for: .normal)
  
                default:
                    return cell
                }
                return cell
            case 6:
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "mySkillCell", for: indexPath as IndexPath) as! mySkillTableViewCell
                    cell.addASkillTextField.placeholder = "   Add a skill..."
                    cell.addASkillTextField.layer.borderWidth = 0.5
                    cell.addASkillTextField.layer.borderColor = UIColor.gray.cgColor
                    cell.addButton.layer.cornerRadius = 2.0
                    cell.addButton.isHidden = true
                    cell.addButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     //cell.addASkillTextField.maximumAutoCompleteCount = 10
                    cell.addASkillTextField.tag = 1
                    cell.addASkillTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    //cell.addASkillTextField.addTarget(self, action: #selector(handleTextFieldInterfaces(sender:)), for: UIControlEvents.editingChanged)
                    cell.addASkillTextField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(sender:)), for: UIControlEvents.editingDidEndOnExit)
                    cell.addASkillTextField.addTarget(self, action: #selector(textFieldShouldReturn(sender:)), for: UIControlEvents.editingDidEnd)

                    cell.addASkillTextField.returnKeyType = UIReturnKeyType.done
                   
                    //cell.addASkillTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.infoLabel.text = "Skills"

                    print("skills : \(dump(profile.skills.skills))")
                    print("gameNames : ")
                    dump(cell.gameNames)
                    
                    cell.gameNames = profile.skills.skills
                    cell.gameNamesIds = profile.skills.skillsIds
                    
                    //cell.gameNames = profile.skills.skills
                    
                    print("cell.collectionView.contentSize.height : \(cell.collectionView.contentSize.height)")
                    cell.collectionView.reloadData()
        
                    self.collectionViewHeightSkill = cell.collectionView.contentSize.height
                    
                    
                    
                    return cell
                }
                else if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addProject", for: indexPath as IndexPath) as! addProjectTableViewCell
                    cell.button.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                    cell.button.layer.cornerRadius = 5.0
                    cell.button.setTitle("Add a new skill", for: .normal)
                    return cell
                }
                else if indexPath.row == 2{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "mySkillCell", for: indexPath as IndexPath) as! mySkillTableViewCell
                    cell.infoLabel.text = "Language"
                    
                    //dump(self.profile.langues.langues)
                    cell.addASkillTextField.layer.borderWidth = 0.5
                    cell.addASkillTextField.layer.borderColor = UIColor.gray.cgColor
                    cell.addASkillTextField.tag = 2
                    cell.addButton.layer.cornerRadius = 2.0
                    cell.addButton.isHidden = true
                    cell.addButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     //cell.addASkillTextField.maximumAutoCompleteCount = 10
                   // cell.addASkillTextField.addTarget(self, action: #selector(handleTextFieldInterfaces(sender:)), for: UIControlEvents.editingChanged)
                    cell.addASkillTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.addASkillTextField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(sender:)), for: UIControlEvents.editingDidEndOnExit)
                    cell.addASkillTextField.addTarget(self, action: #selector(textFieldShouldReturn(sender:)), for: UIControlEvents.editingDidEnd)

                    cell.addASkillTextField.returnKeyType = UIReturnKeyType.done
                    
                    cell.addASkillTextField.placeholder = "   Add a language..."
                    cell.gameNames = profile.langues.langues
                    cell.gameNamesIds = profile.skills.skillsIds
                    //dump("langues: \(profile.langues.langues)")
                     self.collectionViewHeightLangue = cell.collectionView.contentSize.height
                    cell.collectionView.reloadData()
                    return cell
                }
                else  {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addProject", for: indexPath as IndexPath) as! addProjectTableViewCell
                    cell.button.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                    cell.button.layer.cornerRadius = 5.0
                    cell.button.setTitle("Add a new language", for: .normal)
                    return cell
                }
            case 1:
                if isExpand == true && selectedCellIndexPath == indexPath{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "myContactInformationCell", for: indexPath as IndexPath) as! myContactInformationTableViewCell
                    cell.emailContactTextField.layer.borderWidth = 0.5
                    cell.phoneContactTextField.layer.borderWidth = 0.5
                    cell.linkedinContactTextField.layer.borderWidth = 0.5
                    cell.twitterContactTextField.layer.borderWidth = 0.5
    
                    cell.watContactTextField.layer.borderWidth = 0.5
         
                
                    cell.emailContactTextField.text = profile.contact.email
                    cell.phoneContactTextField.text = profile.contact.phone_number
                    cell.linkedinContactTextField.text = profile.contact.linkedin_profile
                    cell.twitterContactTextField.text = profile.contact.twitter_profile
                    cell.watContactTextField.text = profile.contact.wat_profile

                
                    cell.emailContactTextField.setLeftPaddingPoints(20)
                    cell.phoneContactTextField.setLeftPaddingPoints(20)
                    cell.linkedinContactTextField.setLeftPaddingPoints(20)
                    cell.twitterContactTextField.setLeftPaddingPoints(20)
                    cell.watContactTextField.setLeftPaddingPoints(20)
                
                    cell.saveButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     cell.saveButton.layer.cornerRadius = 5.0
                    cell.emailContactTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.phoneContactTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.linkedinContactTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    cell.twitterContactTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
           
                    cell.watContactTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)

                    
                     cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath as IndexPath) as! myContactTableViewCell
                    cell.emailLabel.text = profile.contact.email
                    cell.phoneLabel.text = profile.contact.phone_number
                    cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    
                    if (profile.contact.linkedin_profile) != nil {
                        if (profile.contact.linkedin_profile?.characters.count)! > 0 {
                            cell.stackLinkedin.isHidden = false
                        }
                        else {
                            cell.stackLinkedin.isHidden = true
                        }
                    }
                    
                    if (profile.contact.linkedin_profile) != nil {
                        if (profile.contact.twitter_profile?.characters.count)! > 0 {
                            cell.stackTwitter.isHidden = false
                        }
                        else
                        {
                            cell.stackTwitter.isHidden = true
                        }
                    }
                    
                    if (profile.contact.linkedin_profile) != nil && (profile.contact.linkedin_profile) != nil {
                        if (profile.contact.linkedin_profile?.characters.count)! <= 0 && (profile.contact.twitter_profile?.characters.count)! > 0 {
                            /*cell.stackTwitterLeading.constant = 0
                            cell.layoutIfNeeded()
                            cell.contentView.layoutIfNeeded()*/
                        }
                        else
                        {
                            /*cell.stackTwitterLeading.constant = 60
                            self.view.layoutIfNeeded()
                            cell.layoutIfNeeded()
                            cell.contentView.layoutIfNeeded()*/
                        }
                    }
                    
                    let tap = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleLinkedinImage(sender:)))
                    tap.delegate = myProfileViewController() as UIGestureRecognizerDelegate
                    cell.imgLinkedin.addGestureRecognizer(tap)
                    cell.imgLinkedin.isUserInteractionEnabled = true
                    
                    let tap2 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleTwitterImage(sender:)))
                    tap2.delegate = myProfileViewController() as UIGestureRecognizerDelegate
                    cell.imgTwitter.addGestureRecognizer(tap2)
                    cell.imgTwitter.isUserInteractionEnabled = true
                    
                    let tap3 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleEmailID(sender:)))
                    tap3.delegate = myProfileViewController() as UIGestureRecognizerDelegate
                    cell.emailLabel.addGestureRecognizer(tap3)
                    cell.emailLabel.isUserInteractionEnabled = true
                    
                    let tap4 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handlePhoneNumber(sender:)))
                    tap4.delegate = myProfileViewController() as UIGestureRecognizerDelegate
                    cell.phoneLabel.addGestureRecognizer(tap4)
                    cell.phoneLabel.isUserInteractionEnabled = true
                    
                    let tap5 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleEmailID(sender:)))
                    tap5.delegate = myProfileViewController() as UIGestureRecognizerDelegate
                    cell.lblEmail.addGestureRecognizer(tap5)
                    cell.lblEmail.isUserInteractionEnabled = true
                    
                    let tap6 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handlePhoneNumber(sender:)))
                    tap6.delegate = myProfileViewController() as UIGestureRecognizerDelegate
                    cell.lblPhonenumber.addGestureRecognizer(tap6)
                    cell.lblPhonenumber.isUserInteractionEnabled = true
                    
                    return cell
                    
                }
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addProject", for: indexPath as IndexPath) as! addProjectTableViewCell
                cell.button.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                cell.button.setTitle("Logout", for: .normal)
                return cell
            case 0:
                if isEditable == true && selectedCellIndexPath == indexPath {
                let cell = tableView.dequeueReusableCell(withIdentifier: "myProfileInformationCell", for: indexPath as IndexPath) as! myProfileInformationTableViewCell
                   
                cell.nameTextField.layer.borderWidth = 0.5
                cell.jobTitleTextField.layer.borderWidth = 0.5
                cell.servicesTextField.layer.borderWidth = 0.5
                cell.officeAdressTextField.layer.borderWidth = 0.5
                cell.lastNameTextField.layer.borderWidth = 0.5
                    
                cell.nameTextField.text = profile.user?.first_name
                cell.lastNameTextField.text = profile.user?.last_name
                cell.jobTitleTextField.text = profile.user?.job
                cell.servicesTextField.text = profile.user?.entities
                cell.officeAdressTextField.text = profile.user?.location

                
                cell.nameTextField.setLeftPaddingPoints(20)
                cell.lastNameTextField.setLeftPaddingPoints(20)
                cell.jobTitleTextField.setLeftPaddingPoints(20)
                cell.servicesTextField.setLeftPaddingPoints(20)
                cell.officeAdressTextField.setLeftPaddingPoints(20)

                
                
                cell.saveButton.addTarget(self, action: #selector(saveJobSection(sender:)), for: .touchUpInside)
                     cell.saveButton.layer.cornerRadius = 5.0
                cell.nameTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                cell.lastNameTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                cell.jobTitleTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                cell.servicesTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                cell.officeAdressTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
                    
                     cell.pen.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                
                return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath as IndexPath) as! myProfileTableViewCell
                    if (profile.user != nil) {
                        
                        if (profile.user.is_external == true) {
                            cell.externalLabel.isHidden = false
                        }
                        if let image = profile.user?.image {
                            cell.pictureProfileImage.downloadedFrom(link: (profile.user?.image)!)
                            
                            let tap = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleProfilePicture(sender:)))
                            tap.delegate = myProfileViewController() as UIGestureRecognizerDelegate
                            cell.pictureProfileImage.addGestureRecognizer(tap)
                            cell.pictureProfileImage.isUserInteractionEnabled = true
                        }
                        
                        let name:String! = "\((profile.user?.first_name)!) \((profile.user?.last_name)!)"
                        cell.pictureProfileImage.setImageForName(string: name, backgroundColor: nil, circular: true, textAttributes: nil)

                        cell.nameProfileLabel.text = name
                        
                        cell.titleProfileLabel.text = profile.user?.job
                        cell.locationLabel.text = profile.user?.location
                        cell.entitiesLabel.text = profile.user?.entities
                    }
                    cell.editButton.layer.cornerRadius = 2.0
                    cell.editButton.addTarget(self, action: #selector(penEdit(sender:)), for: .touchUpInside)
                    return cell
                }
            default:
                let cell = UITableViewCell()
                return cell
            }
        }
        else if tableView == self.tableViewMember {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myMemberCell", for: indexPath as IndexPath) as! myMemberTableViewCell
            let row = (selectedCellIndexPath?.row)!
            
            cell.memberName.text = "\(profile.projects[row].members_profile[indexPath.row].user?.first_name) \(profile.projects[row].members_profile[indexPath.row].user?.first_name)"
            //cell.pictureMember.image = UIImage(named: (profile.projects[row].members_profile[indexPath.row].user?.image!)!)?.circleMasked
            cell.jobTitleLabel.text = profile.projects[row].members_profile[indexPath.row].user?.job
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myRelationMemberCell", for: indexPath as IndexPath) as! myRelationsMemberTableViewCell
            cell.relationMemberJob.text = relations[self.currentRelation]?[indexPath.row].user?.job
            cell.relationMemberName.text = "\(relations[self.currentRelation]?[indexPath.row].user?.first_name) \(relations[self.currentRelation]?[indexPath.row].user?.last_name)"
            //cell.relationMemberPicture.image = UIImage(named: (relations[self.currentRelation]?[indexPath.row].user?.image!)!)?.circleMasked
            //cell.relationMemberPicture.downloadedFrom(link: (relations[self.currentRelation]?[indexPath.row].user?.image!)!)
            return cell
        }
    }
    
    func handleProfilePicture(sender: UITapGestureRecognizer? = nil) {
        // handling code
        
        let myActionSheet = UIAlertController(title: "Select Source", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // blue action button
        let blueAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (action) in
         self.openCamera()
        }
        
        // red action button
        let redAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default) { (action) in
            self.openGallary()
        }
        
        // cancel action button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
            print("Cancel action button tapped")
        }
        
        // add action buttons to action sheet
        myActionSheet.addAction(blueAction)
        myActionSheet.addAction(redAction)
        myActionSheet.addAction(cancelAction)
        
        // support iPads (popover view)
        myActionSheet.popoverPresentationController?.sourceView = sender?.view
        myActionSheet.popoverPresentationController?.sourceRect = (sender?.view?.bounds)!
        
        // present the action sheet
        self.present(myActionSheet, animated: true, completion: nil)
        
    }

    
    func handleLinkedinImage(sender: UITapGestureRecognizer? = nil) {
        // handling code
        if ((profile.contact.linkedin_profile) != nil) {
            if ((profile.contact.linkedin_profile?.characters.count)! > 0) {
            guard var url = NSURL(string: profile.contact.linkedin_profile!) else {
                print("INVALID URL")
                return
            }
            
            /// Test for valid scheme & append "http" if needed
            if !["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                let appendedLink = "http://" + profile.contact.linkedin_profile!
                url = NSURL(string: appendedLink)!
            }
            
            let svc = SFSafariViewController(url: url as URL, entersReaderIfAvailable: true)
            self.present(svc, animated: true, completion: nil)
        }
        }
    }
    
    func handleTwitterImage(sender: UITapGestureRecognizer? = nil) {
        // handling code
        if (profile.contact.twitter_profile) != nil {
            if ((profile.contact.twitter_profile?.characters.count)! > 0) {
            guard var url = NSURL(string: profile.contact.twitter_profile!) else {
                print("INVALID URL")
                return
            }
            
            /// Test for valid scheme & append "http" if needed
            if !["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                let appendedLink = "https://twitter.com/" + profile.contact.twitter_profile!
                url = NSURL(string: appendedLink)!
            }
            
            let svc = SFSafariViewController(url: url as URL, entersReaderIfAvailable: true)
            self.present(svc, animated: true, completion: nil)
            }
        }
    }
    
    func handleEmailID(sender: UITapGestureRecognizer? = nil) {
        // handling code
        if (profile.contact.email != nil) {

            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([profile.contact.email!])
                //            mail.setSubject("Bla")
                //            mail.setMessageBody("<b>Blabla</b>", isHTML: true)
                present(mail, animated: true, completion: nil)
            } else {
                print("Cannot send mail")
                // give feedback to the user
            }
        }
    }
    
    func handlePhoneNumber(sender: UITapGestureRecognizer? = nil) {
        // handling code
        if (profile.contact.phone_number != nil) {
            callNumber(phoneNumber: profile.contact.phone_number!)
        }
    }
    
    private func callNumber(phoneNumber:String) {
        
        let scanner = Scanner(string: phoneNumber)
        
        let validCharacters = CharacterSet.decimalDigits
        let startCharacters = validCharacters.union(CharacterSet(charactersIn: "+#"))
        
        var digits: NSString?
        var validNumber = ""
        while !scanner.isAtEnd {
            if scanner.scanLocation == 0 {
                scanner.scanCharacters(from: startCharacters, into: &digits)
            } else {
                scanner.scanCharacters(from: validCharacters, into: &digits)
            }
            
            scanner.scanUpToCharacters(from: validCharacters, into: nil)
            if let digits = digits as? String {
                validNumber.append(digits)
            }
        }
        
        print(validNumber)
        
        if let phoneCallURL = URL(string: "tel://\(validNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(phoneCallURL)
                }
            }
        }
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(error?.localizedDescription)")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "", message: "You don't have camera", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            self.dismiss(animated: false, completion: nil)
            
            uploadImage(pickedImage)
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(_ image: UIImage)
    {
        //        POST /api/v1/users/{user_id}/upload_picture
        
        let url = "users/" + "\(self.profile.id)" + "/upload_picture"
        let param: NSDictionary = ["user_id" : self.profile.id]
        
        APIUtility.sharedInstance.updateProfilePicture(token: self.access_token, url: url, parameters: param, image: image) { (response, error) in
            if (error == nil)
            {
                let json = JSON(response)
                print("updateProfilePicture")
                dump(json)
                
                self.getData()
            }
            else
            {
                let alert = UIAlertController(title: "", message: "Picture dimensions are not correct. Minimum width: 180px, minimum height: 180px", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
//        var compression: CGFloat = 0.9
//        let maxCompression: CGFloat = 0.1
//        let maxFileSize: Int = 60 * 1024 // (Max: 60KB)
//        var imageData: Data = UIImageJPEGRepresentation(image, compression)!
//        while imageData.count > maxFileSize && compression > maxCompression {
//            
//            print(imageData.count)
//            print(maxFileSize)
//            compression -= 0.1
//            imageData = UIImageJPEGRepresentation(image, compression)!
//        }
//        
//        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
//        
//        let param: NSDictionary = ["user_id": self.profile.id,"profile_picture": base64String]
//        
//        
//        APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
//            //SVProgressHUD.dismiss()
//            if (error == nil)
//            {
//                let json = JSON(response)
//                
//                self.addLanguageWithLanguageID(language_id: json["id"].intValue)
//                
//                print("response edit profile")
//                dump(json)
//            }
//        }
        
//        let oWebManager: WebManager = WebManager()
//        oWebManager.m_strModule = "UploadImage"
//        oWebManager.delegate = self
//        
//        var compression: CGFloat = 0.9
//        let maxCompression: CGFloat = 0.1
//        let maxFileSize: Int = 60 * 1024 // (Max: 60KB)
//        var imageData: Data = UIImageJPEGRepresentation(image, compression)!
//        while imageData.count > maxFileSize && compression > maxCompression {
//            
//            print(imageData.count)
//            print(maxFileSize)
//            compression -= 0.1
//            imageData = UIImageJPEGRepresentation(image, compression)!
//        }
//        
//        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
//        
//        let oDictParam: NSMutableDictionary = NSMutableDictionary()
//        oDictParam.setObject(base64String, forKey: "avatar" as NSCopying);
//        
//        let strPostParam: String = oWebManager.dictionaryToString(oDictParam)
//        let strUrl: String = String(format:"%@users/%@/avatar", getServerBaseUrl(),SnapTaskUtlity.getUserId())
//        oWebManager.downloadPostUrl(strUrl, IN_Param: strPostParam, IN_strAccessToken: SnapTaskUtlity.getSnapTaskToken())
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableViewContentSize() -> CGSize {
        tableView.layoutIfNeeded()
        
        let screenSize: CGRect = UIScreen.main.bounds
        tableView.frame = CGRect(x:0, y: 0, width: screenSize.width, height: tableView.contentSize.height)
        
        tableView.layoutIfNeeded()
        
        return tableView.contentSize
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
                        degree.degree_id = j["id"] as? Int
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
                }
                
                self.tblSearch.reloadData()
                
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
//                getData()
            }
        }
        
    }
    
    func getDataWithSearch(txtSearch: String) {
        
        if Reachability.isConnectedToNetwork() == false {
            return
        }
        
        self.pagingSpinner.startAnimating()
        
        // Next page
        usersSearchPageNo += 1
        
        let param: NSDictionary = ["page": usersSearchPageNo,"per_page": 15]
        
        print("getData called : \(self.access_token)")
        
        //        GET /api/v1/users/search/{search_term}

        let url : String! = "users/search/" + txtSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        APIUtility.sharedInstance.getAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            SVProgressHUD.dismiss()
            
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
                        user.is_external = external
                        print("is_external : \(external)")
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
                            degree.degree_id = j["id"] as? Int
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
                    
                    
                    
//                    for j in 0..<json[i]["jobs"].count {
//                        var job = Job()
//                        var json_i = json[i].dictionaryObject
//                        if let j = (json_i?["jobs"]?[j].dictionaryValue) as? Dictionary {
//                            job.title = j["title"]?.stringValue
//                            job.location = j["location"]?.stringValue
//                            job.id = j["id"]?.intValue
//                            job.start_date = j["start_date"]?.stringValue
//                            job.end_date = j["end_date"]?.stringValue
//                            job.objDescription = j["description"]?.stringValue
//                            
//                            jobs.append(job)
//                        }
//                    }
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
                self.tblSearch.reloadData()
                self.pagingSpinner.stopAnimating()
            }
            else {
                self.pagingSpinner.stopAnimating()
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //Calls this function when the tap is recognized.
    override func dismissKeyboard() {
        if searchBar.isFirstResponder == true && searchBar.text == ""{
            searchBar.resignFirstResponder()
        }
        view.endEditing(true)
    }

}
