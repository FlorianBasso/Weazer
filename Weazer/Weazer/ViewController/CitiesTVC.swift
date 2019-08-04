//
//  ForecastsTVC.swift
//  Weazer
//
//  Created by Florian Basso on 04/14/2019.
//  Copyright © 2018 Roaflin. All rights reserved.
//

import UIKit

class ForecastsTVC: UITableViewController, TableViewModelDelegate {

    // MARK: - Properties
    var viewModel: SearchableTVM?
    var searchController: UISearchController?
    
    // MARK: - Initialization
    
    init(viewModel: SearchableTVM) {
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
        self.configureNavBar()
        self.configureSearchController()
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
    
    func configureSearchController() {
        // Create the search results controller and store a reference to it.
        // We will display the result on this current controller, so we put nil for the results controller
        self.searchController = UISearchController(searchResultsController: nil)
        
        self.searchController?.searchBar.barTintColor = .clear
        self.searchController?.searchBar.isTranslucent = true
        
        // Use the current view controller to update the search results.
        self.searchController?.searchResultsUpdater = self.viewModel
        self.searchController?.searchBar.placeholder = self.viewModel?.searchBarPlaceholder
        
        // Install the search bar as the table header.
        self.tableView.tableHeaderView = self.searchController?.searchBar
        
        // It is usually good to set the presentation context.
        self.definesPresentationContext = true
        
        // Avoid to obscure background when showing search screen
        self.searchController?.obscuresBackgroundDuringPresentation = false
        
        // Sets self as delegate to the search controller
        self.searchController?.delegate = self.viewModel
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



class BlurredBackgroundView: UIView {
    let imageView: UIImageView
    let blurView: UIVisualEffectView
    
    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        imageView = UIImageView(image: UIImage.gorgeousImage())
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(blurView)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect.zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        blurView.frame = bounds
    }
}

extension UIImage {
    class func gorgeousImage() -> UIImage {
        return UIImage(named: "gorgeousimage")!
    }
}
