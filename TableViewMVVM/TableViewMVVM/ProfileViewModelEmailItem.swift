//
//  ProfileViewModelEmailItem.swift
//  TableViewMVVM
//
//  Created by Pablo Dominé on 31/5/17.
//  Copyright © 2017 Pablo Dominé. All rights reserved.
//

import Foundation

class ProfileViewModelEmailItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .email
    }
    var sectionTitle: String {
        return "Email"
    }
    var isCollapsed = true
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
}
