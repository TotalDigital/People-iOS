//
//  APIUtility.swift
//  People at Total
//
//  Created by Florian Letellier on 24/02/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//


import UIKit
import AFNetworking
import p2_OAuth2
import SwiftyJSON
import SVProgressHUD

class APIUtility: NSObject {
    
    //let BASE_URL = "https://people-total.herokuapp.com/api/v1/"
    
    var BASE_URL = ""

    let sessionManager : AFHTTPSessionManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
    
    
    class var sharedInstance: APIUtility {
        struct Static {
            static let instance = APIUtility()
        }
        return Static.instance
    }
    
    var isProd = Bool() {
        didSet {
            UserDefaults.standard.set(isProd, forKey: "isProd")
            UserDefaults.standard.synchronize()
            
            print("saved object: \(UserDefaults.standard.bool(forKey: "isProd"))")
        }
    }
    
    func getAPICall(token: String, url: String!, parameters: NSDictionary!, completionHandler:@escaping (NSArray?, Error?)->()) ->() {
        let accesstoken = token
       
        
        let isProdGet = UserDefaults.standard.bool(forKey: "isProd")
        if isProdGet {
            BASE_URL = "https://people.total/api/v1/"
        }
        else {
            BASE_URL = "https://people-total-staging.herokuapp.com/api/v1/"
        }
        

        var url: String! = url
        var isUser: Bool
        if url == "users" {
            isUser = false
            url = "\(BASE_URL)\(url!)?access_token=\(accesstoken)&page=\(Int(parameters["page"] as! Int))&per_page=\(Int(parameters["per_page"] as! Int))"
        }
        else if (url?.contains("users/featured"))! {
            isUser = false
            url = "\(BASE_URL)\(url!)?access_token=\(accesstoken)"
        }
        else if (url?.contains("users/search/"))! {
            isUser = false
            url = "\(BASE_URL)\(url!)?access_token=\(accesstoken)&page=\(Int(parameters["page"] as! Int))&per_page=\(Int(parameters["per_page"] as! Int))"
        }
        else if ((url?.contains("skills/search/"))! || (url?.contains("languages/search/"))!) {
            isUser = false
            url = "\(BASE_URL)\(url!)?access_token=\(accesstoken)"
        }
        else {
            isUser = true
            url = "\(BASE_URL)\(url!)?access_token=\(accesstoken)"
        }

        print("url : \(url)")
        sessionManager.requestSerializer = AFHTTPRequestSerializer()

        sessionManager.get(url!, parameters: [], progress: nil, success: { (task, responseObject) in
            if isUser == true {
                let response: NSArray = [responseObject]
                completionHandler(response, nil)
            }
            else {
                completionHandler(responseObject as? NSArray, nil)

            }
            
        }) { (task, error) in
            
            completionHandler(nil,error)
        }
    }
    
    func putAPICall(token: String, url: String!, parameters: NSDictionary!, completionHandler:@escaping (NSDictionary?, Error?)->()) ->() {
        let accesstoken = token
        let url : String = "\(BASE_URL)\(url!)?access_token=\(accesstoken)"
        print(url)
        print(parameters)
        
        sessionManager.requestSerializer = AFHTTPRequestSerializer()
        sessionManager.responseSerializer = AFHTTPResponseSerializer()
        //sessionManager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as! Set<String>
        sessionManager.put(url, parameters: parameters, success: { (task, responseObject) in
            completionHandler(responseObject as? NSDictionary, nil)
        }) { (task, error) in
            completionHandler(nil,error)
        }
    }
    
    func postAPICall(token: String, url: String!, parameters: NSDictionary!, completionHandler:@escaping (NSDictionary?, Error?)->()) ->() {
        let accesstoken = token
        let url : String = "\(BASE_URL)\(url!)?access_token=\(accesstoken)"
        print(url)
        print(parameters)
        sessionManager.requestSerializer = AFHTTPRequestSerializer()
        sessionManager.post(url, parameters: parameters, success: { (task, responseObject) in
            completionHandler(responseObject as? NSDictionary, nil)
        }) { (task, error) in
            completionHandler(nil,error)
        }
    }
    
    func deleteAPICall(token: String, url: String!, parameters: NSDictionary!, completionHandler:@escaping (NSDictionary?, Error?)->()) ->() {
        let accesstoken = token
        let url : String = "\(BASE_URL)\(url!)?access_token=\(accesstoken)"
        print(url)
        print(parameters)
        sessionManager.requestSerializer = AFHTTPRequestSerializer()
        sessionManager.delete(url, parameters: parameters, success: { (task, responseObject) in
            completionHandler(responseObject as? NSDictionary, nil)
        }) { (task, error) in
            completionHandler(nil,error)
        }
    }
    
    func postAPICallWithImage(url: String!, parameters: NSDictionary!, image : NSMutableArray?, completionHandler:@escaping (NSDictionary?, NSError?)->()) ->() {
        
        //SVProgressHUD.showProgress(0.0, status: "chargement...")
        let url : String = "\(BASE_URL)\(url)"
        print(url)
        print(parameters)
        sessionManager.requestSerializer = AFHTTPRequestSerializer()
        let arrayImageData = NSMutableArray()
        if ((image?.count)! > 0)
        {
            for img in image!
            {
                var imageData : NSData?
                imageData = UIImagePNGRepresentation(img as! UIImage)! as NSData?
                arrayImageData.add(imageData!)
            }
        }
        
        sessionManager.post(url, parameters: parameters, constructingBodyWith: { (multipartFormData) in
            if (arrayImageData.count > 0)
            {
                var i : Int = 0
                //print("annonce_pic[\(i)]")
                for imgData in arrayImageData
                {
                    multipartFormData.appendPart(withFileData: (imgData as! NSData) as Data, name: "annonce_pic[\(i)]", fileName: "png", mimeType: "image/png")
                    i += 1
                    //                    var imageData : NSData?
                    //                    imageData = UIImagePNGRepresentation(img as! UIImage)!
                    //                    arrayImageData.addObject(imageData!)
                }
                
            }
            
        }, progress: { (progress) in
            //SVProgressHUD.showProgress(Float(progress.fractionCompleted), status: "chargement...")
        }, success: { (task, responseObject) in
            //SVProgressHUD.dismiss()
            completionHandler(responseObject as? NSDictionary, nil)
        }) { (task, error) in
           // SVProgressHUD.dismiss()
            completionHandler(nil,error as NSError?)
        }
    }
    
    func updateProfileAPI(url: String!, parameters: NSDictionary!, image : UIImage?, completionHandler:@escaping (NSDictionary?, NSError?)->()) ->() {
        
       // SVProgressHUD.showProgress(0.0, status: "chargement...")
        let url : String = "\(BASE_URL)\(url)"
        print(url)
        print(parameters)
        sessionManager.requestSerializer = AFHTTPRequestSerializer()
        var imageData : NSData?
        imageData = UIImagePNGRepresentation(image!) as NSData?
        sessionManager.post(url, parameters: parameters, constructingBodyWith: { (multipartFormData) in
            
            if (imageData != nil)
            {
                multipartFormData.appendPart(withFileData: imageData! as Data, name: "avatar", fileName: "png", mimeType: "image/png")
            }
        }, progress: { (progress) in
           // SVProgressHUD.showProgress(Float(progress.fractionCompleted), status: "chargement...")
        }, success: { (task, responseObject) in
            //SVProgressHUD.dismiss()
            completionHandler(responseObject as? NSDictionary, nil)
        }) { (task, error) in
            //SVProgressHUD.dismiss()
            completionHandler(nil,error as NSError?)
        }
    }
    
    func updateProfilePicture(token: String, url: String!, parameters: NSDictionary!, image : UIImage?, completionHandler:@escaping (NSDictionary?, NSError?)->()) ->() {
        
        SVProgressHUD.showProgress(0.0, status: "Uploading...")
        
        let accesstoken = token
        let url : String = "\(BASE_URL)\(url!)?access_token=\(accesstoken)"
        print(url)
        print(parameters)
        sessionManager.requestSerializer = AFHTTPRequestSerializer()
//        sessionManager.responseSerializer = AFHTTPResponseSerializer()
        
        var imageData : NSData?
        imageData = UIImagePNGRepresentation(image!) as NSData?
        sessionManager.post(url, parameters: parameters, constructingBodyWith: { (multipartFormData) in
            
            if (imageData != nil)
            {
                multipartFormData.appendPart(withFileData: imageData! as Data, name: "profile_picture", fileName: "profile_picture", mimeType: "image/png")
            }
        }, progress: { (progress) in
             SVProgressHUD.showProgress(Float(progress.fractionCompleted), status: "Uploading...")
        }, success: { (task, responseObject) in
            SVProgressHUD.dismiss()
            completionHandler(responseObject as? NSDictionary, nil)
        }) { (task, error) in
            SVProgressHUD.dismiss()
            completionHandler(nil,error as NSError?)
        }
    }
    
}
