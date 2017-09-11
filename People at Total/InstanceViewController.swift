//
//  InstanceViewController.swift
//  Pods
//
//  Created by Florian Letellier on 26/07/2017.
//
//

import UIKit
import p2_OAuth2

class InstanceViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    var window: UIWindow?
    @IBAction func domainToSignInt(_ sender: Any) {

            if instanceTextField.text == "people.total" {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Storyboard", bundle: nil)
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                
                
                vc.isProd = true
                APIUtility.sharedInstance.isProd = true
                
                APIUtility.sharedInstance.BASE_URL = "https://people.total/api/v1/"
                print("prod : \(vc.isProd)")
                performSegue(withIdentifier: "domainToSignIn", sender: self)
                
            }
            else if instanceTextField.text == "people-total-staging.herokuapp.com" {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Storyboard", bundle: nil)
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                
                vc.isProd = false
                APIUtility.sharedInstance.isProd = false
                
                APIUtility.sharedInstance.BASE_URL = "https://people-total-staging.herokuapp.com/api/v1/"
                print("prod : \(vc.isProd)")
                performSegue(withIdentifier: "domainToSignIn", sender: self)
                
            }
            else {
                let alert = UIAlertController(title: "Oops", message: "This instance don't exist!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    
    @IBOutlet weak var instanceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.instanceTextField.delegate = self
        if APIUtility.sharedInstance.isProd {
            if APIUtility.sharedInstance.isProd == true {
                self.instanceTextField.text = "people.total"
            }
            else {
                self.instanceTextField.text = "people-total-staging.herokuapp.com"
            }
        }
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
