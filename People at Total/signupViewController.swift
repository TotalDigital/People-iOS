//
//  signupViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 31/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit


extension UITextField {
    override func setBottomBorder(color: CGColor, height: CGFloat) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: height)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UIView {
    func setBottomBorder(color: CGColor, height: CGFloat) {
        //self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: height)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

class signupViewController: UIViewController {

     /*func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "tabBarShow"){
            if let tabVC = segue.destination as? UITabBarController{
                //tabVC.selectedIndex = 0
            }
        }
    }*/

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var alreadyMemberButton: UIButton!
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var didntreceiveButton: UIButton!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var formView: UIView!
    
    var editingEmailMode: Bool = false
    var editingFirstNameMode: Bool = false
    var editingLastNameMode: Bool = false
    
    func isEditingMode(_ textField: UITextField) {
        if textField.placeholder == "Email" {
            if  editingEmailMode == false {
                emailLabel.isHidden = false
                emailTextField.setBottomBorder(color: UIColor(red: 22/255,green: 108/255,blue: 193/255, alpha: 1.0).cgColor, height: 2.0)
                editingEmailMode = true
                
            }
            else if textField.text == "" {
                emailLabel.isHidden = true
                emailTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
                emailTextField.placeholder = "Email"
                editingEmailMode = false
            }
            
        }
        else if textField.placeholder == "First Name" {
            if  editingFirstNameMode == false {
                firstNameLabel.isHidden = false
                firstNameTextField.setBottomBorder(color: UIColor(red: 22/255,green: 108/255,blue: 193/255, alpha: 1.0).cgColor, height: 2.0)
                editingFirstNameMode = true
            }
            else if textField.text == "" {
                firstNameLabel.isHidden = true
                firstNameTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
                firstNameTextField.placeholder = "First Name"
                editingFirstNameMode = false
            }
        }
        else if textField.placeholder == "Last Name" {
            if  editingLastNameMode == false {
                lastNameLabel.isHidden = false
                lastNameTextField.setBottomBorder(color: UIColor(red: 22/255,green: 108/255,blue: 193/255, alpha: 1.0).cgColor, height: 2.0)
                editingLastNameMode = true
            }
            else if textField.text == "" {
                lastNameLabel.isHidden = true
                lastNameTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
                lastNameTextField.placeholder = "Last Name"
                editingLastNameMode = false
            }
        
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
       
            emailTextField.placeholder = "Email"

            firstNameTextField.placeholder = "First Name"
            lastNameTextField.placeholder = "Last Name"
        
        isEditingMode(textField)
    }
    
    func targetFunction(_ textField: UITextField) {
        
        isEditingMode(textField)
        if textField.placeholder == "Email" {
            emailTextField.placeholder = ""
        }
        else if textField.placeholder == "First Name" {
            firstNameTextField.placeholder = ""
        }
        else if textField.placeholder == "Last Name" {
            lastNameTextField.placeholder = ""
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        formView.setBottomBorder(color: UIColor(red:215/255, green: 215/255,blue: 215/255, alpha: 1.0).cgColor, height: 1.0)
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        didntreceiveButton.titleLabel?.adjustsFontSizeToFitWidth = true
  
        signInButton.layer.cornerRadius = 2
        emailTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
        firstNameTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
        lastNameTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
        
        var formattedString = NSMutableAttributedString()
        formattedString
            .normal("Sign up today, your colleagues ")
            .bold("are waiting for you!")
        
        signUpLabel.attributedText = formattedString
        
        formattedString = NSMutableAttributedString()
        formattedString
            .color("Already a member? ", UIColor(red: 138/255,green: 138/255, blue:141/255, alpha: 1.0))
            .color("Log in !", UIColor(red: 22/255,green: 108/255,blue: 193/255, alpha: 1.0))
        alreadyMemberButton.setAttributedTitle(formattedString, for: .normal)
        alreadyMemberButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)

        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(targetFunction(_:)), for: .touchDown)
        firstNameTextField.addTarget(self, action: #selector(targetFunction(_:)), for: .touchDown)
        lastNameTextField.addTarget(self, action: #selector(targetFunction(_:)), for: .touchDown)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
