//
//  ViewController.swift
//  RedditChallenge
//
//  Created by Christian Quicano on 3/31/22.
//

import UIKit
import Combine

protocol MyViewControllerDelegate: AnyObject {
    func refreshTableView ()
}


class ViewController: UIViewController {

    let customRedDark = UIColor(displayP3Red: 82/255, green: 4/255, blue: 4/255, alpha: 1)
    let customBlue = UIColor(displayP3Red: 55/255, green: 63/255, blue: 81/255, alpha: 0.50)
    let customLightBlue = UIColor(displayP3Red: 0/255, green: 141/255, blue: 213/255, alpha: 1)
    let customRedBeige = UIColor(displayP3Red: 223/255, green: 187/255, blue: 177/255, alpha: 1)
    let customPink = UIColor(displayP3Red: 245/255, green: 100/255, blue: 100/255, alpha: 1)
    let customLightGray = UIColor(displayP3Red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
    let customPurple = UIColor(displayP3Red: 75/255, green: 63/255, blue: 114/255, alpha: 1)
    
    
    private var viewModel: ViewControllerViewModelProtocol?
    private var subscribers = Set<AnyCancellable>()
    
    private lazy var refreshAction: UIAction = UIAction { [weak self] _ in
        self?.refreshData()
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero, primaryAction: refreshAction)
        refresh.tintColor = .white
        return refresh
    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.prefetchDataSource = self
        tableview.delegate = self
        tableview.register(StoryCell.self, forCellReuseIdentifier: StoryCell.identifier)
        tableview.addSubview(refreshControl)
        return tableview
    }()
    
    weak var delegate: MyViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     //   lazy var delegate = MyViewControllerDelegate?//.self
        
        assemblingMVVM()
        setUpUI()
        setUpBinding()
        
        
        
    }

    private func assemblingMVVM() {
        // create mvvm
        let mainNetworkManager = MainNetworkManager()
        viewModel = ViewControllerViewModel(networkManager: mainNetworkManager)
    }
    
    private func setUpUI() {
        
        view.addSubview(tableView)
        
//        tableView.backgroundView?.backgroundColor = .orange
        view.backgroundColor = customPurple  //customLightBlue
        tableView.backgroundColor = customBlue
        
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    private func setUpBinding() {
        
        viewModel?
            .publisherStories
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            })
            .store(in: &subscribers)
        
        viewModel?
            .publisherCache
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &subscribers)
        
        viewModel?.getStories()
        
    }
    
    private func refreshData() {
    //    print("refreshData")
        viewModel?.forceUpdate()
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.totalRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryCell.identifier, for: indexPath) as! StoryCell
        let row = indexPath.row
        let title = viewModel?.getTitle(by: row)
        let data = viewModel?.getImageData(by: row)
        cell.configureCell(title: title, imageData: data)
//        cell.imageView?.contentMode = .scaleToFill
        cell.backgroundColor = customBlue
//        cellLabel.textColor=[UIColor redColor]
//        cell.textLabel!.textColor = UIColor.white
//        cell.largeContentTitle = true
//        cell.contentView.get
//        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = customLightGray
        cell.selectedBackgroundView = bgColorView
        
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.cornerRadius = 7
        cell.layer.borderWidth = 2
        cell.layer.borderColor = customLightGray.cgColor       //UIColor.lightGray.cgColor     //UIColor.red.cgColor
        cell.layer.masksToBounds = true
        
        return cell
    }
    
}

extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let row = indexPath.row
   //     print("deselected...")
        
       
    }
    
//    table
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let indexes = indexPaths.map { $0.row }
        let total = viewModel?.totalRows ?? 0
        if indexes.contains(total - 1) {
            viewModel?.loadMoreStories()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let destination = DetailViewController()
        destination.imgData =  viewModel?.getImageData(by: row)
        destination.storyTitle = viewModel?.getTitle(by: row)
        
        present(destination, animated: true, completion: nil)
    //    navigationController?.pushViewController(destination, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   //     print(indexPath)
    //    print("cell is deleting...")
        let row = indexPath.row
        viewModel?.deleteCell(by: row)
        
  //      print("Total Rows: \(viewModel?.totalRows)")
        
        DispatchQueue.main.async {
     //       print("removed...")
            UIView.transition(with: tableView, duration: 0.25, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
        }
    }
    
}
