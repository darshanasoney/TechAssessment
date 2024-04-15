//
//  UserPhoto.swift
//  TechAssessment
//
//  Created by Darshana  on 14/04/24.
//

import Foundation

class UserPhoto {
    var profileLarge : String?
    var profileMedium : String?
    var profilSmall : String?
    
    init(profileDict: NSDictionary) {
        if let user = profileDict.object(forKey: "user") as? NSDictionary {
            if let profile = user.object(forKey: "profile_image") as? NSDictionary {
                self.profileLarge = profile.object(forKey: "large") as? String
                self.profileMedium = profile.object(forKey: "medium") as? String
                self.profilSmall = profile.object(forKey: "small") as? String
            }
        }
    }
}
