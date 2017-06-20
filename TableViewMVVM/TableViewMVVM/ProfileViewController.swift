//
//  ViewController.swift
//  TableViewMVVM
//
//  Created by Pablo Dominé on 5/31/17.
//  Copyright © 2017 Pablo Dominé. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var profileViewModel: ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileViewModel = ProfileViewModel()
        
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.sectionHeaderHeight = 60
        tableView?.separatorStyle = .none
        
        let nib = UINib(nibName: HeaderView.identifier, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        
        tableView.dataSource = profileViewModel
        tableView.delegate = profileViewModel
        
        profileViewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableView?.beginUpdates()
            self?.tableView?.reloadSections([section], with: .fade)
            self?.tableView?.endUpdates()
        }
    }

}

