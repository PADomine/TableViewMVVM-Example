//
//  ProfileViewModeFriendsItem.swift
//  TableViewMVVM
//
//  Created by Pablo Dominé on 31/5/17.
//  Copyright © 2017 Pablo Dominé. All rights reserved.
//

import Foundation

class ProfileViewModeFriendsItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .friend
    }
    var sectionTitle: String {
        return "Friends"
    }
    var rowCount: Int {
        return friends.count
    }
    var isCollapsed = true
    
    var friends: [Friend]
    
    init(friends: [Friend]) {
        self.friends = friends
    }
}
