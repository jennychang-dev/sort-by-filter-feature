//
//  ViewController.swift
//  SortByFilter
//
//  Created by Jenny Chang on 11/04/2019.
//  Copyright © 2019 Jenny Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, DropDownViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortByFilterView: SortByFilterView!
    @IBOutlet weak var sortByFilterViewHeight: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.topAnchor.constraint(equalTo: sortByFilterView.bottomAnchor, constant: 0).isActive = true
        
        sortByFilterView.toggled = false
        sortByFilterView.dropdownTableHeight.constant = 0
        
        setUpDropDownList()
    }
    
    func setUpDropDownList() {
        sortByFilterViewHeight.constant = 50
        sortByFilterView.list = ["Body Part", "Spot number", "Modified Date", "Spot color"]
        sortByFilterView.delegate = self
    }
    
    func openDropDownList() {
        sortByFilterView.dropdownTableHeight.constant = CGFloat(sortByFilterView.list.count * 40)
        sortByFilterViewHeight.constant = 210
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func closeDropDownList() {
        sortByFilterViewHeight.constant = 50
        sortByFilterView.dropdownTableHeight.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Mole \(indexPath.row+1)"
        return cell
    }
    
}

