//
//  ProfileViewModelItem.swift
//  TableViewMVVM
//
//  Created by Pablo Dominé on 31/5/17.
//  Copyright © 2017 Pablo Dominé. All rights reserved.
//

import Foundation

enum ProfileViewModelItemType {
    case nameAndPicture
    case about
    case email
    case friend
    case attribute
}

protocol ProfileViewModelItem {
    var type: ProfileViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

extension ProfileViewModelItem {
    var rowCount: Int {
        return 1
    }
    var isCollapsible: Bool {
        return true
    }
}
