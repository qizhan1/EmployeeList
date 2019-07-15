// *************************************************************************************************
// - MARK: Imports


import UIKit


// *************************************************************************************************
// - MARK: EmployeeListTableViewController


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
        tableView.estimatedRowHeight = view.bounds.size.height
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
        // TODO: For optimization, we can prefetch employee photos
//        tableView.prefetchDataSource = self
    }
    
    
}

// *************************************************************************************************
// - MARK: UITableViewDelegate


extension EmployeeListTableViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.bounds.height
    }
    
    
}


// *************************************************************************************************
// - MARK: UITableViewDataSource


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


// *************************************************************************************************
// - MARK: UITableViewDataSourcePrefetching


extension EmployeeListTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // TODO: For optimization, we can prefetch employee photos
        for indexPath in indexPaths {
            if let employee = employees?[indexPath.row] {
                PhotoDataProvider.shared.fetchPhoto(for: employee, at: indexPath)
            }
        }
        
    }
}
