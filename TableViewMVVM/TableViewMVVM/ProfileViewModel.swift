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
        return items[section].rowCount
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
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
}
