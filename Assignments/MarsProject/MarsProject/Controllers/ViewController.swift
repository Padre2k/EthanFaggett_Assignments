//
//  ViewController.swift
//  MarsProject
//
//  Created by Ethan Faggett on 3/25/22.
//

import UIKit


class ViewController: UIViewController {

    // MARK: - Properties
    let tableView = UITableView()
    var postsArrayID = [Int]()
    var postsArrayTitle = [String]()
    var marsItems = [MarsSingle]()
    var marsItemsAux = [MarsItemAux]()
    var marsItemsAux2 = [MarsItemAux2]()
    let customRed = UIColor(displayP3Red: 179/255, green: 15/255, blue: 9/255, alpha: 0.50)
    let customRedDark = UIColor(displayP3Red: 82/255, green: 4/255, blue: 4/255, alpha: 1)
    let customBlue = UIColor(displayP3Red: 9/255, green: 74/255, blue: 179/255, alpha: 1.0)
    let midGray = UIColor(displayP3Red: 145/255, green: 145/255, blue: 145/255, alpha: 0.4)
    var favCount = 0
    var favArray = [Bool]()
    
    var detailVC = DetailViewController()
    
    let userDefaults = UserDefaults.standard
    
    lazy var theFavArray = userDefaults.value(forKey: "favoredItemsArray") as? [Bool] ?? [Bool]()
    
    
    
    // MARK: - UI Elements
    private let backGroundImageView: UIImageView = {
        let backGroundImageView = UIImageView()
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.backgroundColor = .darkGray
        return backGroundImageView
    }()
    
    
    // MARK: - Custom Methods
    private func updateDataPersist() {
        
        var check1 = 0
        var check2 = 0
        
        favArray.forEach {item in
            if item == true {
                check1 += 1
            }
        }
        
        marsItems.forEach { item in
            if item.status == true {
                check2 += 1
            }
        }
        
        
        if marsItems.count == 0 && userDefaults.value(forKey: "favoredItemsArray") == nil  {
            //Do nothiung at the moment
            //            userDefaults.value(forKey: "favoredItemsArray")
            print("--------1---------")
            
        } else if check1 != check2 {
            favArray = []
            marsItems.forEach { item in
                favArray.append(item.status)
            }
            print("favArray: \(favArray)")
            userDefaults.set(favArray, forKey: "favoredItemsArray")
            let checkValue = userDefaults.object(forKey: "favoredItemsArray") as? [Bool]
            print("UserD2________: \(String(describing: checkValue))")
            
        } else if marsItems.count > 0 && userDefaults.value(forKey: "favoredItemsArray") != nil{
            let tempArray = userDefaults.object(forKey: "favoredItemsArray") as? [Bool]
            // let strings = userDefaults.object(forKey: "myKey")
            print("--------3---------")
            var i = 0
            for item in tempArray! {
                print("The Bool Value: \(item)")
                marsItems[i].status = item
                i += 1
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let colorLightBlue2 = UIColor(red: 34/255, green: 108/255, blue: 227/255, alpha: 0.05)
        let colorDarkBlue2 = UIColor(red: 22/255, green: 77/255, blue: 166/255, alpha: 1.0)
        
        let gradientLayer = CAGradientLayer()
        var updatedFrame = self.navigationController!.navigationBar.bounds
        updatedFrame.size.height += 150
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = [colorLightBlue2.cgColor, colorDarkBlue2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0) // vertical gradient start
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0) // vertical gradient end

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationController!.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
       // self.tabBarController?.tabBar.tintColor = .white
        
        // Navigation Bar:
        navigationController?.navigationBar.backgroundColor = colorDarkBlue2
        navigationController?.navigationBar.shadowImage = colorDarkBlue2.as1ptImage()
        
        // Navigation Bar Text:
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        if #available(iOS 13.0, *) {
                let app = UIApplication.shared
                let statusBarHeight: CGFloat = app.statusBarFrame.size.height

                let statusbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight - 10))
            statusbarView.backgroundColor = colorDarkBlue2
                view.addSubview(statusbarView)
            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = colorDarkBlue2
            }
        
        print("UD value: \(theFavArray)")
        
        setUpUI()
        setupTableView()
        
       
        let imageBG = UIImage(named: "space-1648267457129-5048")?.image(alpha: 0.55)
        backGroundImageView.image = imageBG
        backGroundImageView.contentMode = .scaleAspectFill
        
        getDataFromAPI()
        getDataFromNasaAPI()
        
        detailVC.delegate = self
        
        updateDataPersist()
        
        let textAttributesNav = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributesNav

    }

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: - private methods
    private func setUpUI() {
        view.addSubview(backGroundImageView)
        
        // create constraints
        backGroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 45.0).isActive = true
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
//                                print(identifier)
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
    
    override func viewWillAppear(_ animated: Bool) {
        favCount = 0
        theFavArray.forEach {
            let check = $0
            if check == true {
                self.favCount += 1
            }
        }
        if favCount > 0 {
            title = "Favorited Items Count: \(favCount)"
        } else {
            title = "No Items Favored"
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateDataPersist()
    }
    
    @objc private func getDataFromNasaAPI() {
        
      
        let newURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=Q9YNbzmt8C5OpY7L3MV4DHJhrdIGCbjx3tVWxRcf&sol=2000&page=1"
      
        guard let url = URL(string: newURL) else { return }
        
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            self!.marsItems = []
            
            if let data = data {
                do {
                    let item = try decoder.decode(MarsItem.self, from: data)
                    
                    item.photos.forEach {
                        let id = $0.id
                        let imgUrl = $0.img_src
                        let sol = $0.sol
                        let earthDate = $0.earth_date
                        let status = false
                        
                        let currentItem = MarsSingle(id: id, sol: sol, img_src: imgUrl, earth_date: earthDate, status: status)
                        self!.marsItems.append(currentItem)
                        
                        let roverName = $0.rover.name
                        let roverId = $0.rover.id
                        let roverLandingDate = $0.rover.landing_date
                        let roverLaunchDate = $0.rover.launch_date
                        var roverStatus: Bool = false
                        
                        if $0.rover.status == "active" {
                            roverStatus = true
                        }
                        let currentItemRover = MarsItemAux(id: roverId, name: roverName, landingDate: roverLandingDate, launchDate: roverLaunchDate, status: roverStatus)
                        self!.marsItemsAux.append(currentItemRover)
                        
                        let cameraName = $0.camera.name
                        let cameraID = $0.camera.id
                        let cameraRoverID = $0.camera.rover_id
                        let cameraFullName = $0.camera.full_name
                        
                        let currentItemCamera = MarsItemAux2(id: cameraID, name: cameraName, rover_id: cameraRoverID, full_name: cameraFullName)
                        self!.marsItemsAux2.append(currentItemCamera)
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                    
                    print(item)
                    print(self!.marsItems)
                    print("----")
                    print(self!.marsItems.count)
                } catch let error {
                    print(error.localizedDescription)
                }
                
            }}.resume()

                                   
    }
    
}

// MARK: - Extension Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if marsItems.count > 0 {
            cell.textLabel?.text = "\(marsItems[row].img_src)"
            cell.detailTextLabel?.text = "ID: \(marsItems[row].id)"
            
            if  marsItems[row].status || theFavArray[row] {
                
                if marsItems[row].status != theFavArray[row] {
                    updateDataPersist()
                }
                
            cell.accessoryType = .checkmark
            cell.tintColor = .red
            } else {
                cell.accessoryType = .none
            }
                
            if row % 2 == 0 {
                cell.backgroundColor = midGray  //UIColor(displayP3Red: 23/255, green: 23/255, blue: 176/255, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.white
                cell.detailTextLabel?.textColor = UIColor.white
                
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 13)
                
            } else {
                cell.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
                cell.textLabel?.textColor = UIColor.black
                cell.detailTextLabel?.textColor = UIColor.black
            }
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let destination = DetailViewController()
        destination.status = marsItems[row].status
        destination.body = marsItemsAux[row].name
        destination.name = marsItemsAux2[row].full_name
        destination.id = marsItems[row].id
        destination.imgURL = marsItems[row].img_src
        destination.delegate = self
        
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView()
           imageView.image = UIImage(named: "124582_mars")!
        let headerView = UIView()
        
        headerView.backgroundColor = customRedDark
           headerView.addSubview(imageView)
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
           imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
           imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
           imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
           return headerView
    }
    
    
    private func showAlert(row: Int) {
        let message = "Image: \(marsItems[row].img_src)"
        let messageTitle = "You Selected Item #: \(marsItems[row].id)"
        let alert = UIAlertController(title: messageTitle, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marsItems.count    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Mars Photo Items"
        }
        return "Mars Photos"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = customRed
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
        }
    }
    
    
    
    
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

extension ViewController: DetailViewControllerDelegate {
    func setStatus(_ status: Bool, name: String?, imageURL: String?, id: Int?) {
        
     //   print("Status: \(status), Name: \(String(describing: name)), ImageURL: \(imageURL), id: \(id)")
        
        
        if let localId = id, let localImageURL = imageURL {
            
            print("Status: \(status), ImageURL: \(localImageURL), id: \(localId)")
            
            if let index = marsItems.firstIndex(where: { $0.id == localId && $0.img_src == localImageURL }) {
                print("Index: \(index)")
                marsItems[index].status = status
                theFavArray[index] = status
                tableView.reloadData()
                print("Status: \( marsItems[index].status)")
            }
            var i = 0
            for item in marsItems {
                print("The ArrayStatus Value: #\(i) \(item.status)")
                i += 1
            }
        }
    }
    
}

extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 2, height: 3))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 2, height: 3))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func as1ptImageBottom() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 2, height: 3))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 20, height: 30))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
