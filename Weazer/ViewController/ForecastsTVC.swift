//
//  ForecastsTVC.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import UIKit

class ForecastsTVC: UITableViewController, TableViewModelDelegate {

    // MARK: - Properties
    var viewModel: TableViewModel?
    
    // MARK: - Initialization
    
    init(viewModel: TableViewModel) {
        self.viewModel = viewModel
        super.init(style: UITableView.Style.plain)
        self.viewModel?.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInset = UIEdgeInsets(top: 0,
                                                     left: 16,
                                                     bottom: 0,
                                                     right: 16)
        
        let blurredBackgroundView = BlurredBackgroundView(frame: .zero)
        tableView.backgroundView = blurredBackgroundView
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurredBackgroundView.blurView.effect as! UIBlurEffect)

        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        self.configureNavBar()
        self.viewModel?.viewDidLoad(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.load()
    }
    
    // MARK: - Configuration
    func configureNavBar() {
        self.title = self.viewModel?.title
        self.navigationItem.rightBarButtonItem = self.viewModel?.rightBarButtonItem
        self.navigationItem.leftBarButtonItem = self.viewModel?.leftBarButtonItem
    }
    
    // MARK: - YMMTableViewModelDelegate
    
    func viewModelDidStartLoad() {
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
    }
    
    func viewModelDidLoad() {
        self.viewModel?.registerCells(tableView: self.tableView)
        self.tableView.reloadData()        
    }
    
    func viewModelDidFail(statusCode: Int) {
        // Displays error message or any error handling
    }
    
    func reloadVisibleCells() {
        guard let indexPaths = self.tableView.indexPathsForVisibleRows else { return }
        self.reloadRows(indexPaths: indexPaths)
    }
    
    func reload(section: TableSection) {
        self.tableView.reloadSections(IndexSet(integer: section.position),
                                      with: .automatic)
    }
    
    func reloadDataView() {
        self.tableView.reloadData()
    }
    
    func deleteRows(indexPaths: [IndexPath]) {
        self.tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func reloadRows(indexPaths: [IndexPath]) {
        self.tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
}

