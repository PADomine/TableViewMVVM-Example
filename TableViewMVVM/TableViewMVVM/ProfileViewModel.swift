//
//  ProfileViewModel.swift
//  TableViewMVVM
//
//  Created by Pablo Dominé on 31/5/17.
//  Copyright © 2017 Pablo Dominé. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel: NSObject {
    var items = [ProfileViewModelItem]()
    
    // callback to reload tableViewSections
    var reloadSections: ((_ section: Int) -> Void)?
    
    override init() {
        super.init()
        guard let data = JSONParser.dataFromFile("ServerData"), let profile = Profile(data: data) else {
            return
        }
        
        if let name = profile.fullName, let pictureUrl = profile.pictureUrl {
            let nameAndPictureItem = ProfileViewModelNameAndPictureItem(pictureUrl: pictureUrl, userName: name)
            items.append(nameAndPictureItem)
        }
        if let about = profile.about {
            let aboutItem = ProfileViewModelAboutItem(about: about)
            items.append(aboutItem)
        }
        if let email = profile.email {
            let dobItem = ProfileViewModelEmailItem(email: email)
            items.append(dobItem)
        }
        let attributes = profile.profileAttributes
        // we only need attributes item if attributes not empty
        if !attributes.isEmpty {
            let attributesItem = ProfileViewModeAttributeItem(attributes: attributes)
            items.append(attributesItem)
        }
        let friends = profile.friends
        // we only need friends item if friends not empty
        if !profile.friends.isEmpty {
            let friendsItem = ProfileViewModeFriendsItem(friends: friends)
            items.append(friendsItem)
        }
    }
}

extension ProfileViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = items[section]
        
        guard item.isCollapsible else {
            return item.rowCount
        }
        
        if item.isCollapsed {
            return 0
        } else {
            return item.rowCount
        }
        
        
//        if item.isCollapsible && item.isCollapsed {
//            return 0
//        }
//        return item.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NameAndPictureCell.identifier, for: indexPath) as? NameAndPictureCell {
                cell.item = item
                return cell
            }
        case .about:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as? AboutCell {
                cell.item = item
                return cell
            }
        case .email:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.identifier, for: indexPath) as? EmailCell {
                cell.item = item
                return cell
            }
        case .friend:
            if let item = item as? ProfileViewModeFriendsItem, let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as? FriendCell {
                let friend = item.friends[indexPath.row]
                cell.item = friend
                return cell
            }
        case .attribute:
            if let item = item as? ProfileViewModeAttributeItem, let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.identifier, for: indexPath) as? AttributeCell {
                cell.item = item.attributes[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch items[indexPath.section].type {
//            // do appropriate action for each type
//        }
    }
}

extension ProfileViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.section]
        switch item.type {
        case .nameAndPicture:
            return 100
        case .friend:
            return 80
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView {
            headerView.item = self.items[section]
            headerView.section = section
            headerView.delegate = self
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension ProfileViewModel: HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int) {
        var item = items[section]
        if item.isCollapsible {
            // Toggle collapse
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.setCollapsed(collapsed: collapsed)
            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }
}
