//
//  signinViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 31/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit

class signinViewController: UIViewController {

    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var viewSignIn: UIView!
    
    @IBOutlet weak var notAMemberYetButton: UIButton!
    
    @IBOutlet weak var viewForm: UIView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    var editingEmailMode: Bool = false
    var editingPasswordNameMode: Bool = false
    
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
        else if textField.placeholder == "Password" {
            if  editingPasswordNameMode == false {
                passwordLabel.isHidden = false
                passwordTextField.setBottomBorder(color: UIColor(red: 22/255,green: 108/255,blue: 193/255, alpha: 1.0).cgColor, height: 2.0)
                editingPasswordNameMode = true
            }
            else if textField.text == "" {
                passwordLabel.isHidden = true
                passwordTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
                passwordTextField.placeholder = "Password"
                editingPasswordNameMode = false
            }
        }
        
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        emailTextField.placeholder = "Email"
        
        passwordTextField.placeholder = "Password"

        
        isEditingMode(textField)
    }
    
    func targetFunction(_ textField: UITextField) {
        
        isEditingMode(textField)
        if textField.placeholder == "Email" {
            emailTextField.placeholder = ""
        }
        else if textField.placeholder == "Password" {
            passwordTextField.placeholder = ""
        }

        
    }
    
    
    func borderTextField(textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        viewForm.setBottomBorder(color: UIColor(red:215/255, green: 215/255,blue: 215/255, alpha: 1.0).cgColor, height: 1.0)
        signInButton.layer.cornerRadius = 2
        emailTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
        passwordTextField.setBottomBorder(color: UIColor(red: 204/255,green: 204/255,blue: 204/255, alpha: 1.0).cgColor, height: 1.0)
        var formattedString = NSMutableAttributedString()
        formattedString
            .normal("Sign in ")
            .bold("to join your network")
        
        signInLabel.attributedText = formattedString
        
        formattedString = NSMutableAttributedString()
        formattedString
            .color("Net a member yet? ", UIColor(red: 138/255,green: 138/255, blue:141/255, alpha: 1.0))
            .color("Join us !", UIColor(red: 22/255,green: 108/255,blue: 193/255, alpha: 1.0))
        notAMemberYetButton.setAttributedTitle(formattedString, for: .normal)
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(targetFunction(_:)), for: .touchDown)
        passwordTextField.addTarget(self, action: #selector(targetFunction(_:)), for: .touchDown)
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller


        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
