//
//  ProfileViewModelAboutItem.swift
//  TableViewMVVM
//
//  Created by Pablo Dominé on 31/5/17.
//  Copyright © 2017 Pablo Dominé. All rights reserved.
//

import Foundation

class ProfileViewModelAboutItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .about
    }
    var sectionTitle: String {
        return "About"
    }
    var about: String
    
    init(about: String) {
        self.about = about
    }
}
