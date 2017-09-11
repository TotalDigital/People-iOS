//
//  Contact.swift
//  justOne
//
//  Created by Florian Letellier on 29/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding {
    var email: String?
    var phone_number: String?
    var linkedin_profile:String?
    var twitter_profile:String?
    var agil_profile:String?
    var wat_profile: String?
    var skipe: String?
    
    override init() {
        
    }
    
    init(email: String?, phone_number: String?, linkedin_profile: String?,twitter_profile: String?,agil_profile: String?,wat_profile: String?,skipe: String?) {
        self.email = email
        self.phone_number = phone_number
        self.linkedin_profile = linkedin_profile
        self.twitter_profile = twitter_profile
        self.agil_profile = agil_profile
        self.wat_profile = wat_profile
        self.skipe = skipe
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let email = aDecoder.decodeObject(forKey: "email") as? String
        let phone_number = aDecoder.decodeObject(forKey: "phone_number") as? String
        let linkedin_profile = aDecoder.decodeObject(forKey: "linkedin_profile") as? String
        let twitter_profile = aDecoder.decodeObject(forKey: "twitter_profile") as? String
        let agil_profile = aDecoder.decodeObject(forKey: "agil_profile") as? String
        let wat_profile = aDecoder.decodeObject(forKey: "wat_profile")  as? String
        let skipe = aDecoder.decodeObject(forKey: "skipe")  as? String
        self.init(email: email, phone_number: phone_number, linkedin_profile: linkedin_profile,twitter_profile:twitter_profile,agil_profile: agil_profile,wat_profile: wat_profile,skipe: skipe)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phone_number, forKey: "phone_number")
        aCoder.encode(linkedin_profile, forKey: "linkedin_profile")
        aCoder.encode(twitter_profile, forKey: "twitter_profile")
        aCoder.encode(agil_profile, forKey: "agil_profile")
        aCoder.encode(wat_profile, forKey: "wat_profile")
        aCoder.encode(skipe, forKey: "skipe")
    }

}
