//
//  Language.swift
//  justOne
//
//  Created by Florian Letellier on 29/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import Foundation

class Language: NSObject, NSCoding {
    var langues: [String] = []
    var id: Int?
    var name:String?
    var languesIds: [Int] = []
    
    override init() {
        
    }
    
    init(langues: [String]?, id: Int?, name: String?, languesIds: [Int]?) {
        self.langues = langues!
        self.id = id
        self.name = name
        self.languesIds = languesIds!
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let langues = aDecoder.decodeObject(forKey: "langues") as? [String]
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let languesIds = aDecoder.decodeObject(forKey: "languesIds") as? [Int]
        self.init(langues: langues, id: id, name: name, languesIds: languesIds)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(langues, forKey: "langues")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(languesIds, forKey: "languesIds")
    }

}
