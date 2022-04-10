//
//  ViewController.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/5/22.
//

import UIKit
import Combine

protocol ViewControllerProtocol: AnyObject {
    var viewModel: ViewModelProtocol? { get set }
}



class ViewController: UIViewController, ViewControllerProtocol {
    
    var secondViewController = SecondViewController()
    
    var viewModel: ViewModelProtocol?
    private var subscribers = Set<AnyCancellable>()
    
    private lazy var refreshAction: UIAction = UIAction { [weak self] _ in
        self?.refreshData()
    }
    
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero, primaryAction: refreshAction)
        return refresh
    }()
    
    // MARK: - UI Elements
    private lazy var inputTextField1: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
       // textfield.placeholder = "Please enter a name..."
        textfield.backgroundColor = UIColor.customBlue
        UITextField.appearance().tintColor = .white
        textfield.textColor = .white
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Enter First Name...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customlightGray]
        )
        textfield.textAlignment = .center
        
        return textfield
    }()
    
    private lazy var inputTextField2: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
       // textfield.placeholder = "Please enter a name..."
        textfield.backgroundColor = UIColor.customBlue
        UITextField.appearance().tintColor = .white
        textfield.textColor = .white
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Enter Last Name...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customlightGray]
        )
        textfield.textAlignment = .center
        
        return textfield
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action1)
        button.setTitle("Save Name", for: UIControl.State.normal)
        button.backgroundColor = UIColor.customDarkBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.orange, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.tintColor = .white  //customlightGray
        return button
    }()
    
    private let backGroundImageView: UIImageView = {
        let backGroundImageView = UIImageView()
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.backgroundColor = .black
        return backGroundImageView
    }()
   
    private lazy var centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.customBlue //UIColor(displayP3Red: 66/255, green: 152/255, blue: 245/255, alpha: 1.0)
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
       // label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.font = UIFont.
        label.font = UIFont(name: "Avenir", size: 22)
       
        return label
    }()
    
    private lazy var action1 = UIAction { [weak self] _ in
        print("This is the button tapped...")
        
        let newViewController = SecondViewController()
        self?.navigationController?.pushViewController(newViewController, animated: true)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        ViewControllerConfigurator.assemblingMVVM(view: self)
        
      //  print(FileManager.default.urls(for: .documentsDirectory, in .userDomainMask))
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        setUpUI()
        setUpBinding()
    }

    private func setUpBinding() {
        
        viewModel?
            .publisherMovies
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.refreshControl.endRefreshing()
                self!.secondViewController.tableView.reloadData()      /////**************************************************
            })
            .store(in: &subscribers)
        
        viewModel?
            .publisherPhotoCache
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
//                self?.tableView.reloadData()
                self!.secondViewController.tableView.reloadData()
            })
            .store(in: &subscribers)
        
        viewModel?.getMovies()
        
    }
    
    private func refreshData() {
        print("refreshData")
        viewModel?.forceUpdate()
    }

    
    
    func setUpUI() {
        // create constraints
//        let safeArea = view.safeAreaLayoutGuide
       
        let image = UIImage(named: "luke-chesser-3rWagdKBF7U-unsplash")?.image(alpha: 0.55)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .small)
        let largeBoldDoc = UIImage(systemName: "m.circle.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
        
        inputTextField1.layer.shadowOpacity = 0.5
        inputTextField1.layer.shadowRadius = 1.0
        inputTextField1.layer.masksToBounds = true
        inputTextField1.layer.cornerRadius = 5
        inputTextField1.layer.borderWidth = 1
        inputTextField1.layer.borderColor = UIColor.white.cgColor
        
        inputTextField2.layer.shadowOpacity = 0.5
        inputTextField2.layer.shadowRadius = 1.0
        inputTextField2.layer.masksToBounds = true
        inputTextField2.layer.cornerRadius = 5
        inputTextField2.layer.borderWidth = 1
        inputTextField2.layer.borderColor = UIColor.white.cgColor
        
        centerView.layer.cornerRadius = 5
        centerView.layer.borderWidth = 1
        centerView.layer.borderColor = UIColor.white.cgColor
        
        backGroundImageView.image = image
        backGroundImageView.contentMode = .scaleAspectFill
        
        view.backgroundColor = .black
    
        view.addSubview(backGroundImageView)
        view.addSubview(centerView)
        view.addSubview(stackView)
//        view.addSubview(labelView)
        
        stackView.addArrangedSubview(labelView)
        stackView.addArrangedSubview(inputTextField1)
        stackView.addArrangedSubview(inputTextField2)
        stackView.addArrangedSubview(button)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        inputTextField1.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        inputTextField1.widthAnchor.constraint(equalToConstant: 190).isActive = true
        
        backGroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20.0).isActive = true
        
        labelView.text = "MovieDB App"
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

extension UIColor{
    
    //static let customBlueTest = UIColor(displayP3Red: 66/255, green: 152/255, blue: 245/255, alpha: 0.4)
    static let customBlue = UIColor(displayP3Red: 66/255, green: 152/255, blue: 245/255, alpha: 0.4)
    static let customDarkBlue = UIColor(displayP3Red: 43/255, green: 97/255, blue: 179/255, alpha: 0.6)
    static let customlightGray = UIColor(displayP3Red: 210/255, green: 210/255, blue: 210/255, alpha: 0.6)
    static let customColorGray = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
    static let customColorLightOrange = UIColor(red: 250/255, green: 132/255, blue: 22/255, alpha: 1.0)
    static let customColorDarkOrange = UIColor(red: 209/255, green: 109/255, blue: 8/255, alpha: 1.0)
    static let customColorLightOrange2 = UIColor(red: 250/255, green: 152/255, blue: 22/255, alpha: 1.0)
    static let customColorBlueRoyal = UIColor(red: 6/255, green: 79/255, blue: 214/255, alpha: 1.0)
    static let customColorBlue = UIColor(red: 21/255, green: 43/255, blue: 163/255, alpha: 1.0)
    static let customColorDarkYellow = UIColor(red: 235/255, green: 196/255, blue: 2/255, alpha: 1.0)
    static let customDarkBlue2 = UIColor(red: 1/255, green: 17/255, blue: 70/255, alpha: 0.6)
    static let customDarkBlue3 = UIColor(red: 1/255, green: 25/255, blue: 94/255, alpha: 1.0)
    static let customRed = UIColor(red: 189/255, green: 26/255, blue: 11/255, alpha: 1.0)
    
    
    //235, 196, 2
    
}
