//
//  ViewController.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//


import UIKit


class EmployeeListTableViewController: UIViewController {

    
    var tableView: UITableView! = UITableView(frame: .zero)
    var employees: [EmployeeInfo]?
    
    
    // - MARK: Overrided Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        tableView.register(EmployeeInfoCell.self,
                           forCellReuseIdentifier: EmployeeInfoCell.identifier)
        view.addSubview(tableView)
        wireDelegation()
        applyStyle()
        fetchEmployeeData()
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    
    // - MARK: Private Methods
    
    
    private func applyStyle() {
        view.backgroundColor = UIColor.black
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }

    
    private func fetchEmployeeData() {
        EmployeeDataProvider.shared.getInfo { [weak self] (employees, error) in
            DispatchQueue.main.async {
                if error != nil {
                    // show error message?
                    return
                }
                self?.employees = employees
                self?.tableView.reloadData()
            }
        }
    }
    
    
    private func wireDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}


extension EmployeeListTableViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.bounds.height
    }
    
    
}


extension EmployeeListTableViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return employees?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeInfoCell.identifier,
                                                 for: indexPath) as! EmployeeInfoCell
        if let employee = employees?[indexPath.row] {
            cell.employeeInfo = employee
        }
        
        return cell
    }
    
    
}
