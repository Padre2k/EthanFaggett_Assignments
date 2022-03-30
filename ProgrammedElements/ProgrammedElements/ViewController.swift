//
//  ViewController.swift
//  ProgrammedElements
//
//  Created by Ethan Faggett on 3/25/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - TableView
    let tableView = UITableView()
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]
    var postsArrayID = [Int]()
    var postsArrayTitle = [String]()
    let customRed = UIColor(displayP3Red: 179/255, green: 15/255, blue: 9/255, alpha: 1.0)
    let customBlue = UIColor(displayP3Red: 9/255, green: 74/255, blue: 179/255, alpha: 1.0)
    
    private lazy var action1 = UIAction { [weak self] _ in
        self?.getImage()
    }
    
    private lazy var action2 = UIAction { [weak self] _ in
        self?.getDataFromAPI()
    }
    
    // MARK: - UI Elements
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action1)
        button.setTitle("Get Profile Image", for: UIControl.State.normal)
        button.backgroundColor = customBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.orange, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let profileImageview = UIImageView()
        profileImageview.translatesAutoresizingMaskIntoConstraints = false
        profileImageview.backgroundColor = .clear
        profileImageview.image?.withTintColor(UIColor.red)
        return profileImageview
    }()
    
    private let backGroundImageView: UIImageView = {
        let backGroundImageView = UIImageView()
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.backgroundColor = .lightGray
        return backGroundImageView
    }()
    
    private lazy var buttonAPI: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action2)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Get Posts Data", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = customRed
        button.setTitleColor(.yellow, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        setupTableView()
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
        
        buttonAPI.layer.cornerRadius = 5
        buttonAPI.layer.borderWidth = 1
        buttonAPI.layer.borderColor = UIColor.white.cgColor
        buttonAPI.layer.shadowOpacity = 1.0
        buttonAPI.layer.shadowRadius = 1.0
        buttonAPI.layer.masksToBounds = false
        buttonAPI.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        let image = UIImage(named: "sunset-ios-14-wallpaper-scaled")?.image(alpha: 0.35)
        backGroundImageView.image = image
    }

    // MARK: - Custom Functions
    @objc private func getImage() {
        let serialQueue = DispatchQueue(label: "queue-get image")
        serialQueue.async { [weak self] in
//            let urlS = "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg"
            let urlS = "https://1000logos.net/wp-content/uploads/2019/12/Texas-Arlington-Mavericks-Logo-1991.png"
            guard let url = URL(string: urlS)
            else { return }
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self?.profileImageView.image = UIImage(data: data)
                }
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - private methods
    private func setUpUI() {
        view.addSubview(backGroundImageView)
        view.addSubview(button)
        view.addSubview(buttonAPI)
        view.addSubview(profileImageView)
        
        // create constraints
        let safeArea = view.safeAreaLayoutGuide
        
        buttonAPI.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        buttonAPI.widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonAPI.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
        buttonAPI.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        
        profileImageView.topAnchor.constraint(equalTo: buttonAPI.bottomAnchor, constant: 15.0).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        backGroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0.0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
      }
    
    @objc private func getDataFromAPI() {
        
        let urlS = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlS) else { return }
        
        if postsArrayID.isEmpty {
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let data = data {
                
                do {
                    if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        for item in result {
                            if let identifier = item["id"] as? Int, let title = item["title"] as? String {
                                print(identifier)
                                self.postsArrayID.append(identifier)
                                self.postsArrayTitle.append(title)
                            }
                        }
                        DispatchQueue.main.async { [weak self] in
                            self?.tableView.reloadData()
                            self?.tableView.showsVerticalScrollIndicator = true
                        }
                    }
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }).resume()
        } else {return}
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)   //(withReuseIdentifier: "CardCell", for: indexPath)
//        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
//                        reuseIdentifier: "cell")
//        cell.sty
        if postsArrayID.count > 0 {
        cell.textLabel?.text = "\(postsArrayTitle[row])"
        cell.detailTextLabel?.text = "ID: \(postsArrayID[row])"
           
            if row % 2 == 0 {
                cell.backgroundColor = customRed  //UIColor(displayP3Red: 23/255, green: 23/255, blue: 176/255, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.white
                cell.detailTextLabel?.textColor = UIColor.white
                
//                let fontSize = UIFont(name: "System", size: 6.0)
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 13)
//                cell.textLabel?.font(bol)
            } else {
                cell.backgroundColor = UIColor.white
                cell.textLabel?.textColor = UIColor.black
                cell.detailTextLabel?.textColor = UIColor.black
            }
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        showAlert(row: row)
    }
    
    
    private func showAlert(row: Int) {
        let message = "Title: \(postsArrayTitle[row])"
        let messageTitle = "You Selected Row: \(postsArrayID[row])"
        let alert = UIAlertController(title: messageTitle, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArrayID.count    }
    
}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
