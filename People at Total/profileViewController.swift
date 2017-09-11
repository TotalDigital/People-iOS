//
//  profileViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 01/02/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit
import SwiftyJSON
import SafariServices
import MessageUI
import AddressBook
import Contacts
import ContactsUI
import SVProgressHUD

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        print("call downloaded image")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                
                else {
                    print("error downloaded image")
                    return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image.circleMasked
                print("done downloaded image")
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        print("call downloaded image")
        if link.contains("placeholdit.imgix.net") {
            return
        }
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}

class jobTableViewCell: UITableViewCell {
    @IBOutlet weak var jobTitle: UILabel!

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
   // @IBOutlet weak var descJob: UILabel!
    
}

class jobExpandTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobTitle: UILabel!

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!

    @IBOutlet weak var descLabel: UILabel!
}

class EducationTableViewCell: UITableViewCell {
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
}

class projectTableViewCell: UITableViewCell {
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectDate: UILabel!
    @IBOutlet weak var projectLocation: UILabel!
    @IBOutlet weak var detailProject: UILabel!
    
}

class projectExpandTableViewCell: UITableViewCell {
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectLocation: UILabel!
    @IBOutlet weak var projectDate: UILabel!
    @IBOutlet weak var detailProject: UILabel!
    @IBOutlet weak var bottomSpaceLocationConstraint: NSLayoutConstraint!
    @IBOutlet weak var projectMembersLabel: UILabel!
    
}

class memberTableViewCell: UITableViewCell {
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var pictureMember: UIImageView!
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    
}
protocol relationsMemberTableViewCellDelegate{
    func closeFriendsTapped(at index:IndexPath, sender: AnyObject, user_id : Int)
}

class relationsMemberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var relationMemberName: UILabel!
    @IBOutlet weak var relationMemberPicture: UIImageView!
    @IBOutlet weak var relationMemberJob: UILabel!
    
    var delegate:relationsMemberTableViewCellDelegate!
    
    @IBOutlet weak var closeFriendsBtn: UIButton!
    var indexPath:IndexPath!
    var user_id:Int = 0
 
    @IBAction func closeFriendsAction(_ sender: Any) {
        self.delegate?.closeFriendsTapped(at: indexPath, sender: sender as AnyObject, user_id : user_id)
    }
}


class relationTableViewCell: UITableViewCell {
    @IBOutlet weak var relationType: UILabel!
}



class skillTableViewCell: UITableViewCell,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    var sizingCell: CustomCollectionCell?
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    

    
    var gameNames:[String] = []
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellNib = UINib(nibName: "CollectionCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "CollectionCell")
        self.collectionView.backgroundColor = UIColor.clear
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! CustomCollectionCell?
       // self.flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
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
        cell.crossButton.isHidden = true
//        cell.trailingLabelConstraint.constant = 6
    }
    
}

class CustomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var tagName: UILabel!
    
//    @IBOutlet weak var maxWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var crossButton: UIButton!
    
    
//    @IBOutlet weak var trailingLabelConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        //self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        //self.tagName.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.layer.cornerRadius = 4
//        self.maxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2 
    }
}


class languageTableViewCell: UITableViewCell {
    
}



class profileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchDisplayDelegate, relationsMemberTableViewCellDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate, CNContactViewControllerDelegate, OptionButtonsDelegate {
    
    internal func closeFriendsTapped(at index: IndexPath, sender: AnyObject) {
        if(searchActive){
            if filtered.count>0 {
                let row = index.row
                self.toConnect(profile: self.filtered[row],sender: sender,index: index)
            }
        }
    }

    
    internal func closeFriendsTapped(at index: IndexPath, sender: AnyObject, user_id : Int) {
        getUserFromIDForRelationship(user_id: user_id,sender:sender)
    }

    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var entitiesLabel: UILabel!
    
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

    @IBOutlet weak var connectButton: UIButton!
    
    @IBOutlet weak var addToContactButton: UIButton!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var lblPhonenumber: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var imgLinkedin: UIImageView!
    @IBOutlet weak var lblLinkedin: UILabel!
    @IBOutlet weak var stackLinkedin: UIView!
    
    @IBOutlet weak var imgTwitter: UIImageView!
    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var stackTwitter: UIView!
    @IBOutlet weak var stackTwitterLeading: NSLayoutConstraint!
    
    @IBOutlet weak var viewProfileInformation: UIView!
    
    @IBOutlet weak var contactInformationHeight: NSLayoutConstraint!
    @IBOutlet weak var otherServicesHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewContactInformation: UIView!
    @IBOutlet weak var viewOtherServices: UIView!
    
    @IBOutlet weak var stackEmail: UIView!
    @IBOutlet weak var stackPhoneNumber: UIView!

    @IBOutlet weak var stackPhoneNumberTop: NSLayoutConstraint!
    @IBOutlet weak var stackEmailHeight: NSLayoutConstraint!
    @IBOutlet weak var stackPhoneNumberHeight: NSLayoutConstraint!
    
    
    @IBOutlet var is_external: UILabel!
    
    var isExpand: Bool = false
    
    var profile: Profile = Profile()
    var callbackLatestProfile : ((Profile) -> Void)?
    
    var searchBar: UISearchBar = UISearchBar()
    
    var relations: [String: [Profile]] = [:]
    
    var selectedCellIndexPath: IndexPath?
    
    var currentRelation: String = ""
    
    var rowSection2: CGFloat = 0.0
    
    var access_token: String = ""
    
    var profile_id: Int = 0
    
    var isFromNavigationNotAvailable: Bool = false
    
    @IBOutlet weak var tblSearch: UITableView!
    var searchActive : Bool = false
    
    var filtered:[Profile] = []
    var usersSearchPageNo: Int = 0
    
    var collectionViewHeightSkill: CGFloat = 0.0
    
    var collectionViewHeightLangue: CGFloat = 0.0

    let pagingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    @IBAction func toConnect(_ sender: Any) {
        
        if(profile.relations.isRelationAvailable)
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Do you want to remove your relationship?", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            let removeAction: UIAlertAction = UIAlertAction(title: "Remove", style: .destructive) { action -> Void in
                //Just dismiss the action sheet
                self.removeRelationShipWithID(relationship_id: self.profile.relations.relationshipID)
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
                self.addRelationShip(kind: "is_colleague_of")
            }
            
            // red action button
            let redAction = UIAlertAction(title: "as manager", style: UIAlertActionStyle.default) { (action) in
                print("as Manager")
                self.addRelationShip(kind: "is_managed_by")
            }
            
            // yellow action button
            let yellowAction = UIAlertAction(title: "as team member", style: UIAlertActionStyle.default) { (action) in
                print("as Team member")
                self.addRelationShip(kind: "is_manager_of")
            }
            
            let purpleAction = UIAlertAction(title: "as assistant", style: UIAlertActionStyle.default) { (action) in
                print("as assistant")
                self.addRelationShip(kind: "is_assisted_by")
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
            myActionSheet.popoverPresentationController?.sourceView = self.connectButton
            myActionSheet.popoverPresentationController?.sourceRect = self.connectButton.bounds
            
            // present the action sheet
            self.present(myActionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_clkAddToContacts(_ sender: Any) {
        
            if URL(string: (profile.user?.image!)!) != nil
            {
                self.downloadedFrom(link: (profile.user?.image!)!)
            }
            else {
                if #available(iOS 9.0, *) {
                    let store = CNContactStore()
                    let contact = CNMutableContact()
                    
                    let homePhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue :profile.contact.phone_number!))
                    contact.givenName = (profile.user?.first_name)!
                    contact.familyName = (profile.user?.last_name)!
                    if (profile.contact.email!.contains("total.com"))
                    {
                        contact.organizationName = "Total"
                    }
                    contact.phoneNumbers = [homePhone]
                    
                    let workEmail = CNLabeledValue(label:CNLabelWork, value:profile.contact.email! as NSString)
                    contact.emailAddresses = [workEmail]
                    
                    let controller = CNContactViewController(forNewContact : contact)// .viewControllerForUnknownContact(contact)
                    controller.contactStore = store
                    controller.delegate = self
                    self.navigationController?.setNavigationBarHidden(false, animated: true)
                    let navController = UINavigationController(rootViewController: controller) // Creating a navigation controller with VC1 at the root of the navigation stack.
                    self.present(navController, animated:true, completion: nil)
                }
            }
    }
    
    func contactViewController(_ vc: CNContactViewController, didCompleteWith con: CNContact?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func contactViewController(_ vc: CNContactViewController, shouldPerformDefaultActionFor prop: CNContactProperty) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tblSearch.delegate = self
        tblSearch.dataSource = self
        tblSearch.reloadData()

        tableViewManager.separatorStyle = .none
        tableViewColleague.separatorStyle = .none
        tableViewAssitant.separatorStyle = .none
        tableViewTeam.separatorStyle = .none
        tableViewMember.separatorStyle = .none
        searchBar.delegate = self
        
        searchBar.placeholder = "Search on people..."
        
        tableView.estimatedRowHeight = 116.0
        
        pagingSpinner.color = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        pagingSpinner.hidesWhenStopped = true
        tblSearch.tableFooterView = pagingSpinner
        let tapKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tapKeyboard.cancelsTouchesInView = false
        view.addGestureRecognizer(tapKeyboard)

        let screenSize: CGRect = UIScreen.main.bounds
     
        if profile.id != 0
        {
            if (self.profile.user.is_external == true) {
                self.is_external.isHidden = false
            }
            if (profile.contact.linkedin_profile?.characters.count)! > 0 {
                stackLinkedin.isHidden = false
            }
            else {
                stackLinkedin.isHidden = true
            }
            
            if (profile.contact.twitter_profile?.characters.count)! > 0 {
                stackTwitter.isHidden = false
            }
            else
            {
                stackTwitter.isHidden = true
            }
            
            if (profile.contact.linkedin_profile?.characters.count)! <= 0 && (profile.contact.twitter_profile?.characters.count)! > 0 {
                stackTwitterLeading.constant = 0
                self.contentView.layoutIfNeeded()
            }
            
            
            if (profile.contact.linkedin_profile?.characters.count)! <= 0 && (profile.contact.twitter_profile?.characters.count)! <= 0 {
//                contentView.frame = CGRect(x:0,y: 0,width: screenSize.width,height: contentView.frame.size.height - otherServicesHeight.constant)
                
                otherServicesHeight.constant = 0
                self.contentView.layoutIfNeeded()
            }

            if (profile.contact.email?.characters.count)! <= 0 || (profile.contact.phone_number?.characters.count)! <= 0 {
                contactInformationHeight.constant = stackEmailHeight.constant + 40
                self.contentView.layoutIfNeeded()
            }

            if (profile.contact.email?.characters.count)! <= 0 && (profile.contact.phone_number?.characters.count)! <= 0 {
                contactInformationHeight.constant = 0
                self.contentView.layoutIfNeeded()
            }

            if (profile.contact.email?.characters.count)! <= 0 {
                stackEmailHeight.constant = 0
                stackPhoneNumberTop.constant = 0
                self.contentView.layoutIfNeeded()
            }

            if (profile.contact.phone_number?.characters.count)! <= 0 {
                stackPhoneNumberHeight.constant = 0
                self.contentView.layoutIfNeeded()
            }
        
            contentInformationView.frame = CGRect(x:0,y: viewProfileInformation.frame.origin.y + viewProfileInformation.frame.size.height ,width: screenSize.width,height: viewOtherServices.frame.size.height + contactInformationHeight.constant + viewContactInformation.frame.origin.y)

            contentView.frame = CGRect(x:0,y: 0,width: screenSize.width,height: contentInformationView.frame.size.height + contentInformationView.frame.origin.y + 10)

            if ((profile.user?.image!) != nil) {
                imageProfile.downloadedFrom(link: (profile.user?.image!)!)
            }
            
            imageProfile.setImageForName(string: "\((profile.user?.first_name)!) \((profile.user?.last_name)!)", backgroundColor: nil, circular: true, textAttributes: nil)

            //imageProfile.image?.circleMasked
            //UIImage(named: (profile.user?.image)!)?.circleMasked
            nameProfile.text = "\((profile.user?.first_name)!) \((profile.user?.last_name)!)"
            jobLabel.text = profile.user?.job
            locationLabel.text = profile.user?.location
            entitiesLabel.text = profile.user?.entities
            
        }
        else
        {
            profile.id = self.profile_id
            
            self.getCurrentUpdatedUser()
           
        }
        
        contentInformationView.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), thickness: 1.0)
        
        connectButton.layer.cornerRadius = 2
        addToContactButton.layer.cornerRadius = 2
        
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        
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
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 22/255, green: 108/255, blue: 193/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        let contentSize = screenSize.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - (self.tabBarController?.tabBar.frame.height)!
//        contentView.frame = CGRect(x:0,y: 0,width: screenSize.width,height: contentSize * 0.95)
        
        tableView.frame = CGRect(x:0, y: contentView.frame.size.height, width: screenSize.width, height: contentSize * 5.0)
        
        //self.tableView.addSubview(tableViewMember)
        self.scrollView.addSubview(contentView)
        self.scrollView.addSubview(tableView)
        
        view.addSubview(scrollView)
 
        
        
        //Contact
        
        emailLabel.text = profile.contact.email
        phoneLabel.text = profile.contact.phone_number

        if(profile.relations.isRelationAvailable)
        {
            connectButton.setTitle("Remove",for: .normal)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleLinkedinImage(sender:)))
        tap.delegate = myProfileViewController() as UIGestureRecognizerDelegate
        self.imgLinkedin.addGestureRecognizer(tap)
        self.imgLinkedin.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleTwitterImage(sender:)))
        tap2.delegate = myProfileViewController() as UIGestureRecognizerDelegate
        self.imgTwitter.addGestureRecognizer(tap2)
        self.imgTwitter.isUserInteractionEnabled = true
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleEmailID(sender:)))
        tap3.delegate = myProfileViewController() as UIGestureRecognizerDelegate
        self.emailLabel.addGestureRecognizer(tap3)
        self.emailLabel.isUserInteractionEnabled = true
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handlePhoneNumber(sender:)))
        tap4.delegate = myProfileViewController() as UIGestureRecognizerDelegate
        self.phoneLabel.addGestureRecognizer(tap4)
        self.phoneLabel.isUserInteractionEnabled = true
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handleEmailID(sender:)))
        tap5.delegate = myProfileViewController() as UIGestureRecognizerDelegate
        self.lblEmail.addGestureRecognizer(tap5)
        self.lblEmail.isUserInteractionEnabled = true
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.handlePhoneNumber(sender:)))
        tap6.delegate = myProfileViewController() as UIGestureRecognizerDelegate
        self.lblPhonenumber.addGestureRecognizer(tap6)
        self.lblPhonenumber.isUserInteractionEnabled = true

        self.view.bringSubview(toFront: tblSearch)
        tblSearch.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
        if isFromNavigationNotAvailable {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isFromNavigationNotAvailable {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height + contentView.frame.size.height)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        let screenSize: CGRect = UIScreen.main.bounds
//        scrollView.contentSize = CGSize(width: screenSize.width, height: (screenSize.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - (self.tabBarController?.tabBar.frame.height)!) * 5.0)
        
        self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height + contentView.frame.size.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if tableView == tableViewMember {
            return 1
        }
        else if tableView == self.tableView{
            return 6
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblSearch {
            if(searchActive) {
                return filtered.count
            }
            return 0
        }

        // #warning Incomplete implementation, return the number of rows
        if tableView == tableViewMember {
            print("row : \(selectedCellIndexPath?.row)")
            //print("profile count : \(profile.projects[(selectedCellIndexPath?.row)!].members_profile.count)")
            if selectedCellIndexPath?.row == -1
            {
                return 0
            }
            else
            {
                return profile.projects[(selectedCellIndexPath?.row)!].members_profile.count
            }
            
        }
        else if tableView == self.tableView {
            if section == 0 {
                return profile.jobs.count
            }
            else if section == 1 {
                return profile.projects.count
            }
            else if section == 2 {
                return profile.degree.count
            }
            else if section == 3 {
//                return self.relations.count
                if relations.count > 0 {
                    return 4
                }
                return 0
            }
            else if section == 4 {
                return 2
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
            label.font = UIFont(name: "HelveticaNeue-bold", size: 14)!
            label.textColor = UIColor(red: 112/255, green: 113/255, blue: 115/255, alpha: 1.0)
            
            label.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
            label.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), thickness: 1.0)
            label.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), thickness: 1.0)
        
            
        //headerView.bringSubview(toFront: label)
        // headerView.backgroundColor = UIColor.red/*(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)*/
            switch (section) {
            case 0:
                label.text = "JOBS"
            case 1:
                label.text = "PROJECTS"
            case 2:
                label.text = "EDUCATION"
            case 3:
                label.text = "RELATIONS"
            case 4:
                label.text = "MORE INFOS"
            default:
                break
            }
            headerView.addSubview(label)
            headerView.layoutIfNeeded()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == tableViewMember && profile.projects[(selectedCellIndexPath?.row)!].members_profile.count > 0{
            return "Project members"
        }
        else if tableView == self.tableView {
            if section == 0 {
                return "JOBS"
            }
            else if section == 1 {
                return "PROJECTS"
            }
            else if section == 2 {
                return "EDUCATION"
            }
            else if section == 3 {
                return "RELATIONS"
            }
            else if section == 4 {
                return "MORE INFOS"
            }
            return ""
        }
        else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAtIndexPath 222")
        
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
                
                profileVC.callbackLatestProfile = {(newProfile:Profile) in
                    self.filtered[indexPath.row] = newProfile
                    self.tableView.reloadData()
                }
                
                if let navigator = self.navigationController {
                    navigator.pushViewController(profileVC, animated: true)
                }
            }
        }
        
        if tableView == tableViewMember && profile.projects[(selectedCellIndexPath?.row)!].members_profile.count > 0{
            
            pushUserFromID(user_id: profile.projects[(selectedCellIndexPath?.row)!].members_profile[indexPath.row].user.user_id)
        }
        
        
        if tableView == self.tableView && (indexPath.section == 0 || indexPath.section == 1) {
            
            if (self.isExpand) {
                self.isExpand = false
            }
            
            if (indexPath==self.selectedCellIndexPath) {
                
                self.isExpand = false
                self.selectedCellIndexPath = IndexPath(row: -1, section: indexPath.section)
                
            }else{
                self.isExpand = true
                self.selectedCellIndexPath = indexPath
            }

//            self.selectedCellIndexPath = indexPath
//            self.isExpand = !self.isExpand
            
            tableView.reloadData()
            if indexPath.section == 1{
                tableViewMember.reloadData()
            }
            print("data reloaded : \(self.selectedCellIndexPath)")
            self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height + contentView.frame.size.height)

        }
        else if tableView == tableViewManager {
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
        if tableView == self.tblSearch {
            return 80
        }

        if tableView == self.tableView && indexPath.section == 4 {
//            return 140
            
            if indexPath.row == 0 {
                let cell: skillTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "skillCell") as? skillTableViewCell

                
                let skill = profile.skills.skills
                cell.infoLabel.text = "Skills"
                cell.gameNames = skill
                cell.collectionView.reloadData()
                return 50 + cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            }
            else {
                let cell: skillTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "skillCell") as? skillTableViewCell
                
                let language = profile.langues.langues
                cell.infoLabel.text = "Language"
                cell.gameNames = language
                cell.collectionView.reloadData()
                
                return 140 + cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            }
            
//            if indexPath.row == 0 {
//                return 50 + collectionViewHeightSkill
//            }
//            else {
//                return 50 + collectionViewHeightLangue
//            }
        }
        

        if isExpand == true && indexPath.section == 1 && indexPath == selectedCellIndexPath {
            let row = (selectedCellIndexPath?.row)!
            let memberCount = profile.projects[(selectedCellIndexPath?.row)!].members_profile.count
            return 170.0 + calculateHeight(inString: profile.projects[(selectedCellIndexPath?.row)!].objDescription!) + 40.0 * CGFloat(memberCount)
        }
        
        if tableView == self.tableView && indexPath.section == 1 {
            return 140.0
        }

        rowSection2 = 0
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
        
        if tableView == self.tableView && indexPath.section == 3 {
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
        
        if tableView == self.tableView && indexPath.section == 2 {
            return 127.0
        }

        if isExpand == true && indexPath.section == 0 && indexPath == selectedCellIndexPath {
           
                print("calculateHeight : \(calculateHeight(inString: profile.jobs[(selectedCellIndexPath?.row)!].objDescription!))")
                return 135 + calculateHeight(inString: profile.jobs[(selectedCellIndexPath?.row)!].objDescription!)
        }
        if tableView == self.tableView && indexPath.section == 0 {
            return 140.0
        }
        return UITableViewAutomaticDimension
    }
    
    func calculateHeight(inString:String) -> CGFloat
    {
        let messageString = inString
        let attributes : [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 14.0)]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        let screenSize: CGRect = UIScreen.main.bounds
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: screenSize.width - 32, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
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
            case 0:
                if isExpand == false || selectedCellIndexPath != indexPath{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath as IndexPath) as! jobTableViewCell
                    cell.jobTitle.text = profile.jobs[indexPath.row].title
                    
                    
                    if let start_date = profile.jobs[indexPath.row].start_date {
                        if let end_date = profile.jobs[indexPath.row].end_date {
                            
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            let date: Date? = dateFormatterGet.date(from: start_date)
                            let date1: Date? = dateFormatterGet.date(from: end_date)
                            
                            cell.date.text = "\(dateFormatter.string(from: date!)) - \(dateFormatter.string(from: date1!))"
                        }
                        else
                        {
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            let date: Date? = dateFormatterGet.date(from: start_date)
                            
                            cell.date.text = "\(dateFormatter.string(from: date!))"
                        }
                    }
                    else
                    {
                        if let end_date = profile.jobs[indexPath.row].end_date {
                            
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            let date1: Date? = dateFormatterGet.date(from: end_date)
                            
                            cell.date.text = "\(dateFormatter.string(from: date1!))"
                        }
                    }
                    
                    cell.location.text = profile.jobs[indexPath.row].location
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "jobCellExpand", for: indexPath as IndexPath) as! jobExpandTableViewCell
                    cell.jobTitle.text = profile.jobs[indexPath.row].title
                   
                    
                    if let start_date = profile.jobs[indexPath.row].start_date {
                        if let end_date = profile.jobs[indexPath.row].end_date {
                            
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            let date: Date? = dateFormatterGet.date(from: start_date)
                            let date1: Date? = dateFormatterGet.date(from: end_date)
                            
                            cell.date.text = "\(dateFormatter.string(from: date!)) - \(dateFormatter.string(from: date1!))"
                        }
                        else
                        {
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            let date: Date? = dateFormatterGet.date(from: start_date)
                            
                            cell.date.text = "\(dateFormatter.string(from: date!))"
                        }
                    }
                    else
                    {
                        if let end_date = profile.jobs[indexPath.row].end_date {
                            
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            
                            let date1: Date? = dateFormatterGet.date(from: end_date)
                            
                            cell.date.text = "\(dateFormatter.string(from: date1!))"
                        }
                    }

                    cell.location.text = profile.jobs[indexPath.row].location
                    cell.descLabel.text = profile.jobs[indexPath.row].objDescription
                    return cell
                }
            case 1:
                if isExpand == false || selectedCellIndexPath != indexPath{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath as IndexPath) as! projectTableViewCell
                    cell.projectTitle.text = profile.projects[indexPath.row].title
                    let project = profile.projects[indexPath.row]
                    if project.end_date == "" {
                        
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        
                        let date: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].start_date!)
                        
                        cell.projectDate.text = "From \(dateFormatter.string(from: date!))"
                    }
                    else {
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        
                        let date: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].start_date!)

                        let date1: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].end_date!)

                        cell.projectDate.text = "\(dateFormatter.string(from: date!)) - \(dateFormatter.string(from: date1!))"
                    }
                    cell.projectLocation.text = profile.projects[indexPath.row].location
                    
                    return cell
                }
                else {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "projectExpandCell", for: indexPath as IndexPath) as! projectExpandTableViewCell
                    cell.projectTitle.text = profile.projects[indexPath.row].title
                    let project = profile.projects[indexPath.row]
                    if project.end_date == "" {
                        
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        
                        let date: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].start_date!)
                        
                        cell.projectDate.text = "From \(dateFormatter.string(from: date!))"
                    }
                    else {
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        
                        let date: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].start_date!)
                        
                        let date1: Date? = dateFormatterGet.date(from: profile.projects[indexPath.row].end_date!)
                        
                        cell.projectDate.text = "\(dateFormatter.string(from: date!)) - \(dateFormatter.string(from: date1!))"
                    }

                    cell.projectLocation.text = profile.projects[indexPath.row].location
                    cell.detailProject.text = profile.projects[indexPath.row].objDescription
                    
                    let screenSize: CGRect = UIScreen.main.bounds
                    let memberCount = profile.projects[(selectedCellIndexPath?.row)!].members_profile.count
                    let description = profile.projects[(selectedCellIndexPath?.row)!].objDescription
                    tableViewMember.removeFromSuperview()
                    if memberCount > 0 && description != nil {
                        cell.projectMembersLabel.text = "Project members (\(memberCount))"
                        tableViewMember.frame = CGRect(x:0,y: Int(140 + calculateHeight(inString: description!)) ,width: Int(screenSize.width),height: 20 + 50 * profile.projects[(selectedCellIndexPath?.row)!].members_profile.count)
                        
                        cell.addSubview(tableViewMember)
                    }
                    
                    
                    return cell
                }
            case 2:
                if isExpand == false || selectedCellIndexPath != indexPath{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "EducationTableViewCell", for: indexPath as IndexPath) as! EducationTableViewCell
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
                        cell.date.text = "\(profile.degree[indexPath.row].graduation_year!)"
                    }
                    
                    cell.location.text = profile.degree[indexPath.row].school
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "jobCellExpand", for: indexPath as IndexPath) as! jobExpandTableViewCell
                    cell.jobTitle.text = profile.jobs[indexPath.row].title
                 
                    if let start_date = profile.jobs[indexPath.row].start_date {
                        if let end_date = profile.jobs[indexPath.row].end_date {
                            cell.date.text = "\(profile.jobs[indexPath.row].start_date!) - \(profile.jobs[indexPath.row].end_date!)"
                        }
                    }
                    cell.location.text = profile.jobs[indexPath.row].location
                    cell.descLabel.text = profile.jobs[indexPath.row].objDescription
                    return cell
                }
            case 3:
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
                    cell.relationType.text = "Colleagues"
                    self.currentRelation = "Colleagues"
                    cell.removeSeparator(width: 0.0)
                    cell.addSubview(tableViewRelation3)
                    }
                default:
                    return cell
                }
                return cell
            case 4:
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell", for: indexPath as IndexPath) as! skillTableViewCell
                    
                    let skill = profile.skills.skills
                    cell.infoLabel.text = "Skills"
                    cell.gameNames = skill
                    cell.collectionView.reloadData()
                    self.collectionViewHeightSkill = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
                    
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell", for: indexPath as IndexPath) as! skillTableViewCell
                    
                    let language = profile.langues.langues
                    cell.infoLabel.text = "Language"
                    cell.gameNames = language
                    cell.collectionView.reloadData()
                    self.collectionViewHeightLangue = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
                    
                    return cell
                }
                
            default:
                let cell = UITableViewCell()
                return cell
            }
        }
        else if tableView == self.tableViewMember {
            let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath as IndexPath) as! memberTableViewCell
            let row = (selectedCellIndexPath?.row)!
        
            if let first_name = profile.projects[row].members_profile[indexPath.row].user?.first_name {
                
                if let last_name = profile.projects[row].members_profile[indexPath.row].user?.last_name {
                    cell.memberName.text = "\(first_name) \(last_name)"
                }
                else
                {
                    cell.memberName.text = "\(first_name)"
                }
                
            }
            
         
            //cell.pictureMember.image = UIImage(named: (profile.projects[row].members_profile[indexPath.row].user?.image!)!)?.circleMasked
            
            cell.pictureMember.downloadedFrom(link: (profile.projects[row].members_profile[indexPath.row].user?.image!)!)
            cell.pictureMember.setImageForName(string: cell.memberName.text!, backgroundColor: nil, circular: true, textAttributes: nil)

            //cell.jobTitleLabel.text = profile.projects[row].members_profile[indexPath.row].user?.job
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
            cell.relationMemberPicture.downloadedFrom(link: (relations[self.currentRelation]?[indexPath.row].user?.image!)!)
            cell.relationMemberPicture.setImageForName(string: cell.relationMemberName.text!, backgroundColor: nil, circular: true, textAttributes: nil)

            return cell
        }
    }
    
    func getCurrentUpdatedUser() {
        
        let param: NSDictionary = [:]
        
        let url = "users/" + "\(profile.id)"
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
                if let external = json["external"].boolValue as? Bool {
                    user.is_external = external
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
                let objprofile = Profile()
                objprofile.user = user
                objprofile.jobs = jobs.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                objprofile.contact = contact
                objprofile.projects = projects.sorted(by: { $0.start_date?.compare($1.start_date!) == .orderedDescending })
                objprofile.langues = language
                objprofile.skills = skill
                objprofile.relations = relations
                objprofile.relations.isRelationAvailable = isRelationAvailable
                objprofile.relations.relationshipID = relationshipID
                objprofile.degree = degrees.sorted(by: { $0.entry_year?.compare($1.entry_year!) == .orderedDescending })
                
                self.relations = relationsArray(relations: relations)
                
                if let id = json["id"].intValue as? Int {
                    objprofile.id = id
                }
                dump(objprofile)
                profiles.append(objprofile)
                
                var objProfile = Profile()
                objProfile = profiles[0]
                
                self.profile = objProfile
                
                if let cb = self.callbackLatestProfile
                {
                    cb(self.profile)
                }
               
                self.updatedCurrentUserView()
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func updatedCurrentUserView() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        if profile.id != 0
        {
            if (self.profile.user.is_external == true) {
                self.is_external.isHidden = false
            }
            if (profile.contact.linkedin_profile?.characters.count)! > 0 {
                stackLinkedin.isHidden = false
            }
            else {
                stackLinkedin.isHidden = true
            }
            
            if (profile.contact.twitter_profile?.characters.count)! > 0 {
                stackTwitter.isHidden = false
            }
            else
            {
                stackTwitter.isHidden = true
            }
            
            if (profile.contact.linkedin_profile?.characters.count)! <= 0 && (profile.contact.twitter_profile?.characters.count)! > 0 {
                stackTwitterLeading.constant = 0
                self.contentView.layoutIfNeeded()
            }
            
            
            if (profile.contact.linkedin_profile?.characters.count)! <= 0 && (profile.contact.twitter_profile?.characters.count)! <= 0 {
                //                contentView.frame = CGRect(x:0,y: 0,width: screenSize.width,height: contentView.frame.size.height - otherServicesHeight.constant)
                
                otherServicesHeight.constant = 0
                self.contentView.layoutIfNeeded()
            }
            
            if (profile.contact.email?.characters.count)! <= 0 || (profile.contact.phone_number?.characters.count)! <= 0 {
                contactInformationHeight.constant = stackEmailHeight.constant + 40
                self.contentView.layoutIfNeeded()
            }
            
            if (profile.contact.email?.characters.count)! <= 0 && (profile.contact.phone_number?.characters.count)! <= 0 {
                contactInformationHeight.constant = 0
                self.contentView.layoutIfNeeded()
            }
            
            if (profile.contact.email?.characters.count)! <= 0 {
                stackEmailHeight.constant = 0
                stackPhoneNumberTop.constant = 0
                self.contentView.layoutIfNeeded()
            }
            
            if (profile.contact.phone_number?.characters.count)! <= 0 {
                stackPhoneNumberHeight.constant = 0
                self.contentView.layoutIfNeeded()
            }
            
            contentInformationView.frame = CGRect(x:0,y: viewProfileInformation.frame.origin.y + viewProfileInformation.frame.size.height ,width: screenSize.width,height: viewOtherServices.frame.size.height + contactInformationHeight.constant + viewContactInformation.frame.origin.y)
            
            contentView.frame = CGRect(x:0,y: 0,width: screenSize.width,height: contentInformationView.frame.size.height + contentInformationView.frame.origin.y + 10)
            
            
            imageProfile.downloadedFrom(link: (profile.user?.image!)!)
            imageProfile.setImageForName(string: "\((profile.user?.first_name)!) \((profile.user?.last_name)!)", backgroundColor: nil, circular: true, textAttributes: nil)

            //imageProfile.image?.circleMasked
            //UIImage(named: (profile.user?.image)!)?.circleMasked
            nameProfile.text = "\((profile.user?.first_name)!) \((profile.user?.last_name)!)"
            jobLabel.text = profile.user?.job
            locationLabel.text = profile.user?.location
            entitiesLabel.text = profile.user?.entities
            
        }


        imageProfile.downloadedFrom(link: (profile.user?.image!)!)
        imageProfile.setImageForName(string: "\((profile.user?.first_name)!) \((profile.user?.last_name)!)", backgroundColor: nil, circular: true, textAttributes: nil)

        //imageProfile.image?.circleMasked
        //UIImage(named: (profile.user?.image)!)?.circleMasked
        nameProfile.text = "\((profile.user?.first_name)!) \((profile.user?.last_name)!)"
        jobLabel.text = profile.user?.job
        locationLabel.text = profile.user?.location
        entitiesLabel.text = profile.user?.entities
        
        //Contact
        
        emailLabel.text = profile.contact.email
        phoneLabel.text = profile.contact.phone_number
        
        if(profile.relations.isRelationAvailable)
        {
            connectButton.setTitle("Remove",for: .normal)
        }
        else
        {
            connectButton.setTitle("Connect",for: .normal)
        }
        
        self.tableView.reloadData()
        self.scrollView.contentSize = CGSize(width: self.tableViewContentSize().width, height: self.tableViewContentSize().height + contentView.frame.size.height)
    }
    
    func pushUserFromID(user_id : Int) {
        
        if let profileVC = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "profileViewController") as? profileViewController {
            
            if self.searchBar.isFirstResponder == true {
                self.searchBar.resignFirstResponder()
            }
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
                
                if let profileVC = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "profileViewController") as? profileViewController {
                    
                    if self.searchBar.isFirstResponder == true {
                        self.searchBar.resignFirstResponder()
                    }
                    
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
                
                self.toConnect(profile: objProfile, sender: sender)
                
            }
            else {
                let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func addRelationShip(kind: String) {
//        POST /api/v1/relationships
        
        let url = "relationships"
        
        let param: NSDictionary = ["relationship": ["user_id": AppData.sharedInstance.currentUser.id,"target_id": profile.id,"kind": kind]]
        
        APIUtility.sharedInstance.postAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
            //SVProgressHUD.dismiss()
            self.getCurrentUpdatedUser()
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
            self.getCurrentUpdatedUser()
            
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
    
    func toConnect(profile: Profile, sender: AnyObject) {
        
        if(profile.relations.isRelationAvailable)
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Do you want to remove your relationship?", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            let removeAction: UIAlertAction = UIAlertAction(title: "Remove", style: .destructive) { action -> Void in
                //Just dismiss the action sheet
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
    
    func handleLinkedinImage(sender: UITapGestureRecognizer? = nil) {
        // handling code
        if (profile.contact.linkedin_profile?.characters.count)! > 0 {
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
    
    func handleTwitterImage(sender: UITapGestureRecognizer? = nil) {
        // handling code
        if (profile.contact.twitter_profile?.characters.count)! > 0 {
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
        tableView.frame = CGRect(x:0, y: contentView.frame.size.height, width: screenSize.width, height: tableView.contentSize.height)
        
        
        tableView.layoutIfNeeded()
        
        return tableView.contentSize
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
            tblSearch.isHidden = true
            filtered.removeAll()
        }
        else {
            searchActive = true;
            tblSearch.isHidden = false
            
            //            getDataWithSearch(txtSearch: searchText)
        }
        
        self.tblSearch.reloadData()
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
        
        //SVProgressHUD.show()
        self.pagingSpinner.startAnimating()
        // Next page
        usersSearchPageNo += 1
        
        let param: NSDictionary = ["page": usersSearchPageNo,"per_page": 15]
        
        print("getData called : \(self.access_token)")
        
        //        GET /api/v1/users/search/{search_term}
        
        let url : String! = "users/search/" + txtSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        APIUtility.sharedInstance.getAPICall(token: self.access_token, url: url, parameters: param) { (response, error) in
           // SVProgressHUD.dismiss()
            
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
    }
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        
        print("call downloaded image")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                
                else {
                    print("error downloaded image")
                    return }
            DispatchQueue.main.async() { () -> Void in
//                self.image = image.circleMasked
                
                do {
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsURL.appendingPathComponent("profile_pic.png")
                    if let pngImageData = UIImagePNGRepresentation(image) {
                        try pngImageData.write(to: fileURL, options: .atomic)
                    }
                } catch { }
                
                    if #available(iOS 9.0, *) {
                        let store = CNContactStore()
                        let contact = CNMutableContact()
                        
                        let homePhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue :self.profile.contact.self.phone_number!))
                        contact.givenName = (self.profile.user?.first_name)!
                        contact.familyName = (self.profile.user?.last_name)!
                        if (self.profile.contact.email!.contains("total.com"))
                        {
                            contact.organizationName = "Total"
                        }
                        contact.phoneNumbers = [homePhone]
                        
                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let filePath = documentsURL.appendingPathComponent("profile_pic.png").path
                        if FileManager.default.fileExists(atPath: filePath) {
                            let img = UIImage(contentsOfFile: filePath)
                            contact.imageData = UIImagePNGRepresentation(img!) as Data?
                        }
                        
//                        contact.imageData = data as Data?

                        let workEmail = CNLabeledValue(label:CNLabelWork, value:self.profile.contact.email! as NSString)
                        contact.emailAddresses = [workEmail]
                        
                        let controller = CNContactViewController(forNewContact : contact)// .viewControllerForUnknownContact(contact)
                        controller.contactStore = store
                        controller.delegate = self
                        self.navigationController?.setNavigationBarHidden(false, animated: true)
                        let navController = UINavigationController(rootViewController: controller) // Creating a navigation controller with VC1 at the root of the navigation stack.
                        self.present(navController, animated:true, completion: nil)
                    }
                
                
                
                print("done downloaded image")
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        print("call downloaded image")
        if link.contains("placeholdit.imgix.net") {
            return
        }
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }

}
