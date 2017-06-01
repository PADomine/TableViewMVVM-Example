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
        
        tableView.dataSource = profileViewModel
    }

}

