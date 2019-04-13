//
//  SortByFilter.swift
//  SortByFilter
//
//  Created by Jenny Chang on 11/04/2019.
//  Copyright © 2019 Jenny Chang. All rights reserved.
//

import UIKit
import Foundation

@objc protocol DropDownViewProtocol {
    func openDropDownList()
    func closeDropDownList()
}

class SortByFilterView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var sortByLabel: UILabel!
    
    static var turquoiseColor = UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1.0)
    var list: [String] = []
    var label: UILabel!
    var selectedRow = 0
    
    @IBOutlet weak var dropdownTableView: UITableView! {
        didSet {
            dropdownTableView.register(UINib(nibName: "FilterListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
            dropdownTableView.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var dropdownTableHeight: NSLayoutConstraint!
    @objc weak var delegate: DropDownViewProtocol?
    
    var toggled: Bool = false {
        didSet {
            if toggled == true {
                delegate?.openDropDownList()
            } else {
                delegate?.closeDropDownList()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        nibSetUp()
    }
    
    func nibSetUp() {
        let myView = UINib(nibName: "FilterListView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        myView.frame = bounds
        myView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(myView)
        clipsToBounds = false
    }
    
    @IBAction func toggleButtonTapped(_ sender: Any) {
        adjustFilterView()
    }
    
    @objc func adjustFilterView() {
        
        if toggled == true {
            toggled = false
        } else {
        toggled = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dropdownTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FilterListTableViewCell
        
        cell.filterLabel.text = list[indexPath.row]
        
        if selectedRow == indexPath.row {
            cell.setSelection(selected: true)
        } else {
            cell.setSelection(selected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        sortByLabel.text = "Sort by \(list[indexPath.row])"
        selectedRow = indexPath.row
        toggled = false
        
        tableView.reloadData()
        
    }
}


class FilterListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var filterLabel: UILabel!
    
    func setSelection(selected: Bool) {
        
        if selected == true {
            checkbox.layer.borderColor = SortByFilterView.turquoiseColor.cgColor
            filterLabel.textColor = SortByFilterView.turquoiseColor
        } else {
            checkbox.layer.borderColor = UIColor.black.cgColor
            filterLabel.textColor = UIColor.black
        }
    }
}
