//
//  SecondViewController.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/6/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    var isMovieList = true
    var viewModel: ViewModelProtocol?
    
    //   var movieCell = MovieTableViewCell()
    
    let testData = ["Sample Item 1","Sample Item 2", "Sample Item 3","Sample Item 4", "Sample Item 5", "Sample Item 6","Sample Item 7", "Sample Item 8","Sample Item 9" ,"Sample Item 9", "Sample Item 11","Sample Item 12", "Sample Item 13","Sample Item 14" ,"Sample Item 15"]
    let testData2 = ["Work Item 1","Work Item 2", "Work Item 3","Work Item 4" ,"Work Item 4"]
    
    //    private lazy var button: UIButton = {
    //        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action1)
    //        button.setTitle("Get Image", for: UIControl.State.normal)
    //        button.backgroundColor = .systemPink
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        button.setTitleColor(.white, for: .normal)
    //        button.setTitleColor(.orange, for: .selected)
    //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    //        return button
    //    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        //        tableview.prefetchDataSource = self
        tableview.delegate = self
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        //        tableview.addSubview(refreshControl)
        return tableview
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    // MARK: UIButton
    private lazy var myEditButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: action1)
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
        let largeBoldDoc = UIImage(systemName: "square.and.pencil", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .orange
        return button
    }()
    
    private let searchBar: UISearchBar = {
        let searchLabel = UISearchBar()
        //        label.font = UIFont(name: "Avenir", size: 22)
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        searchLabel.tintColor = .orange.withAlphaComponent(0.2)//UIColor(displayP3Red: 79/255, green: 146/255, blue: 247/255, alpha: 1.0)
        //        searchLabel.isTranslucent = true
        //        searchLabel.backgroundColor = .red //UIColor(displayP3Red: 79/255, green: 146/255, blue: 247/255, alpha: 1.0)
        searchLabel.barTintColor = .tintColor
        searchLabel.setImage(UIImage(named: "SearchIcon"), for: .search, state: .normal)
        searchLabel.searchTextField.leftView?.tintColor = .white
        
        // searchLabel.setImage(UIImage(named: "multiply.square.fill"), for: .clear, state: .focused)   //ic_clear
        if let searchTextField = searchLabel.searchTextField as? UITextField, let clearButton =  searchTextField.value(forKey: "clearButton") as? UIButton {
            // Create a template copy of the original button image
            let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            // Set the template image copy as the button image
            clearButton.setImage(templateImage, for: .normal)
            // Finally, set the image color
            clearButton.tintColor = .white
        }
        
        
        var attr = [NSAttributedString.Key.font: UIFont(name: "Menlo", size: 16.0)!]
        searchLabel.searchTextField.textColor = .white
        searchLabel.searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter Search Here", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.7)])
        // var attr = [NSAttributedString.Key.font: UIFont(name: "Menlo", size: 14.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        //  UISegmentedControl.appearance().setTitleTextAttributes(attr, for: .normal)
        return searchLabel
    }()
    
    private let segmentSwitch: UISegmentedControl = {
        let segment = UISegmentedControl (items: ["Movie List","Favorites"])
        segment.selectedSegmentIndex = 0
        //        label.font = UIFont(name: "Avenir", size: 22)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = .orange//UIColor(displayP3Red: 79/255, green: 146/255, blue: 247/255, alpha: 1.0)
        //        segment.selectedSegmentTintColor = UIColor(displayP3Red: 79/255, green: 146/255, blue: 247/255, alpha: 1.0)
        
        var attr = [NSAttributedString.Key.font: UIFont(name: "Menlo", size: 14.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(attr, for: .normal)
        var attr2 = [NSAttributedString.Key.font: UIFont(name: "Menlo", size: 21.0)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        UISegmentedControl.appearance().setTitleTextAttributes(attr2, for: .selected)
        
        // Add function to handle Value Changed events
        segment.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        
        
        
        return segment
    }()
    
    private let backGroundImageView: UIImageView = {
        let backGroundImageView = UIImageView()
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.backgroundColor = .black
        return backGroundImageView
    }()
    
    lazy var action1 = UIAction { [weak self] _ in
        print("This is the button tapped...")
        
//        self!.showDetailView()
        
        let destination = EditUserViewController()
        //        destination.imgData =  viewModel?.getImageData(by: row)
        //        destination.storyTitle = viewModel?.getTitle(by: row)
        
        //        self!.present(destination, animated: true, completion: nil)
        self!.present(destination, animated: true, completion: {
            print("It is done.")
        })
        
        
        
    }
    
    //    private lazy var action1 = UIAction { [weak self] _ in
    //        print("This is the button tapped...")
    //
    //
    //    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.customDarkBlue3
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0.0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    func loadingData(isList: Bool) {
        
        if isList {
            isMovieList = true
        } else {
            isMovieList = false
        }
        
        tableView.reloadData()
    }
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentSwitch.selectedSegmentIndex
        {
        case 0:
            NSLog("Movie List")
            loadingData(isList: true)
            //show popular view
        case 1:
            NSLog("Fovorites List")
            loadingData(isList: false)
            //show history view
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // movieCell.delegate = self
//        print("Num of Rows: \((viewModel?.totalRowsMovies)!))")
        viewModel?.getMovies()
       
        view.backgroundColor = .cyan
        // Do any additional setup after loading the view.
        setUpUI()
        setupTableView()
        
        nameLabel.text = "Name: Faggett, Ethan"
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchTextField = searchBar.value(forKey: "searchBar") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {
            
            if let img3 = clearButton.image(for: .highlighted) {
                clearButton.isHidden = false
                let tintedClearImage = img3.withTintColor( UIColor.white)
                //                    clearButton.currentTitleShadowColor = .blue
                clearButton.setImage(tintedClearImage, for: .normal)
                clearButton.setImage(tintedClearImage, for: .highlighted)
            }else{
                clearButton.isHidden = true
            }
        }
    }
    
    func setUpUI() {
        
        let image = UIImage(named: "luke-chesser-3rWagdKBF7U-unsplash")?.image(alpha: 0.55)
        backGroundImageView.image = image
        backGroundImageView.contentMode = .scaleAspectFill
        
        let add = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(addTapped))
        //  let newItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        add.tintColor = .orange
        
        // Image needs to be added to project.
        let buttonIcon = UIImage(named: "left_side")
        
        let leftBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.done, target: self, action: #selector(myLeftSideBarButtonItemTapped))
        leftBarButton.image = buttonIcon
        //navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = add
        
        
        
        view.addSubview(backGroundImageView)
        view.addSubview(nameLabel)
        view.addSubview(myEditButton)
        view.addSubview(segmentSwitch)
        view.addSubview(searchBar)
        
        //        navigationController.a
        
        // create constraints
        let safeArea = view.safeAreaLayoutGuide
        
        
        nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor ).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        //        nameLabel.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        
        myEditButton.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0.0 ).isActive = true
        myEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        myEditButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        segmentSwitch.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -0.0).isActive = true
        segmentSwitch.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10.0).isActive = true
        segmentSwitch.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10.0).isActive = true
        segmentSwitch.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        searchBar.topAnchor.constraint(equalTo: segmentSwitch.bottomAnchor, constant: 3.0).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        backGroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        //        nameLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        //        nameLabel.widthAnchor.constraint(equalToConstant: 190).isActive = true
        
        //           nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //           nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    @objc private func addTapped() {
        print("Add Tapped....")
    }
    
    @objc private func myLeftSideBarButtonItemTapped() {
        print("Add Tapped....")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        print("Second will Appear...")
        viewModel?.getMovies()
    }
    
    func showDetailView() {
        print("Inside showDetailView() method ")
        let destination = DetailViewController()
        //        destination.imgData =  viewModel?.getImageData(by: row)
        //        destination.storyTitle = viewModel?.getTitle(by: row)
        
        //        self!.present(destination, animated: true, completion: nil)
        navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isMovieList {
            return testData.count
        } else {
            return testData2.count
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        //        cell.backgroundColor = .orange.withAlphaComponent(0.5)
        //        cell.tintColor = .clear
        //        cell.textLabel?.textColor = .white
        
        cell.backgroundColor = .lightGray
        cell.layer.borderColor = UIColor.darkGray.cgColor //UIColor.white.cgColor
        cell.layer.borderWidth = 1
        
        
        cell.buttonPressed = {
            //Code
            self.showDetailView()
        }
        
        
        if isMovieList {
            //return testData.count
            let title = "Moon Valley Theatres"
            
            cell.configureCell(title: title)  // imageData: data)
            cell.configureCell(title: testData[row])  //cell.textLabel?.text = testData[row]
            //     cell.backgroundColor = .blue.withAlphaComponent(0.5)
            cell.backgroundColor = UIColor.customDarkBlue2   //UIColor.customColorLightOrange2   //.orange.withAlphaComponent(0.75)
            cell.tintColor = .clear
            cell.textLabel?.textColor = .white
            
            cell.accessoryType = .checkmark
            //            cell.accessoryType
            
            //            UIView.animate(withDuration: 0.25) {
            //                     self.view.backgroundColor = UIColor.blue
            //                cell.backgroundColor = .purple.withAlphaComponent(0.5)
            //                  }
            
        } else {
            
            let title = "Moon Valley Theatres"
            cell.configureCell(title: title)   //testData2[row])
            cell.backgroundColor = UIColor.customDarkBlue3    //UIColor.customColorLightOrange.withAlphaComponent(0.70)    //.yellow.withAlphaComponent(0.75)
            cell.tintColor = .white
            cell.textLabel?.textColor = .white
            cell.accessoryType = .checkmark
            
            //return testData2.count
        }
        
        
        //TableView selected cell color
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.green
        cell.selectedBackgroundView = bgColorView
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
