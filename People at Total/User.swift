//
//  User.swift
//  justOne
//
//  Created by Florian Letellier on 29/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject, NSCoding {
    var first_name: String!
    var last_name: String!
    var job: String?
    var location: String?
    var entities: String?
    var image: String?
    var user_id: Int = 0
    var is_external: Bool = false
    
    override init() {
        
    }
    
    init(first_name: String?, last_name: String?, job: String?,location: String?,entities: String?,image: String?,user_id: Int, is_external: Bool) {
        self.first_name = first_name
        self.last_name = last_name
        self.job = job
        self.location = location
        self.entities = entities
        self.image = image
        self.user_id = user_id
        self.is_external = is_external
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let first_name = aDecoder.decodeObject(forKey: "first_name") as? String
        let last_name = aDecoder.decodeObject(forKey: "last_name") as? String
        let job = aDecoder.decodeObject(forKey: "job") as? String
        let location = aDecoder.decodeObject(forKey: "location") as? String
        let entities = aDecoder.decodeObject(forKey: "entities")  as? String
        let image = aDecoder.decodeObject(forKey: "image")  as? String
        let user_id = aDecoder.decodeInteger(forKey: "user_id")
        let is_external = aDecoder.decodeObject(forKey: "is_external") as? Bool ?? aDecoder.decodeBool(forKey: "is_external")
        self.init(first_name: first_name, last_name: last_name, job: job,location: location,entities: entities,image: image,user_id: user_id, is_external: is_external)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(first_name, forKey: "first_name")
        aCoder.encode(last_name, forKey: "last_name")
        aCoder.encode(job, forKey: "job")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(entities, forKey: "entities")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(user_id, forKey: "user_id")
        aCoder.encode(is_external, forKey: "is_external")

    }
    
}
