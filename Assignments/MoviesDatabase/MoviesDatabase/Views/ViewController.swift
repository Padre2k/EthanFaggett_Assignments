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

protocol ViewControllerDelegate {
    func setName(fName: String, lName: String)
}


class ViewController: UIViewController {
    
    
    let defaults = UserDefaults.standard
    var isEdit = false
    var fName = ""
    var lName = ""
   
    var delegate: ViewControllerDelegate?
//    var secondVC = SecondViewController()
//    var secondViewController = SecondViewController()
//    
//    var viewModel: ViewModelProtocol?
//    private var subscribers = Set<AnyCancellable>()
//    
//    private lazy var refreshAction: UIAction = UIAction { [weak self] _ in
//        self?.refreshData()
//    }
//    
//    
//    private lazy var refreshControl: UIRefreshControl = {
//        let refresh = UIRefreshControl(frame: .zero, primaryAction: refreshAction)
//        return refresh
//    }()
    
    // MARK: - UI Elements
    private lazy var firstNameTextField: UITextField = {
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
    
    private lazy var lastNameTextField: UITextField = {
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
    
    private lazy var myEditButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: action3)
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
        let largeBoldDoc = UIImage(systemName: "xmark", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .orange
        return button
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
   
    private lazy var buttonEditName: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action2)
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
    
    let labelView: UILabel = {
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
       
        //self!.defaults.set(self!.lastNameTextField.text!, forKey: "lastName")
        //self!.defaults.set(self!.firstNameTextField.text!, forKey: "firstName")
        
        guard let lastName = self?.lastNameTextField.text,
                let firstName = self?.firstNameTextField.text
        else { return }
        
        self?.defaults.set(lastName, forKey: "lastName")
        self?.defaults.set(firstName, forKey: "firstName")
        
        
        let destinationVC = SecondViewController()
        destinationVC.lastName = self!.lastNameTextField.text!
        destinationVC.firstName = self!.firstNameTextField.text!
//        destinationVC.isEdit = true
        self?.navigationController?.pushViewController(destinationVC, animated: true)

        
    }
    
    private lazy var action2 = UIAction { [weak self] _ in
        guard let lastName = self?.lastNameTextField.text,
                let firstName = self?.firstNameTextField.text
        else { return }
       
       self?.defaults.set(lastName, forKey: "lastName")
       self?.defaults.set(firstName, forKey: "firstName")
        
        print("Lastname: \(lastName), Firstname: \(firstName)")
       
        self!.dismiss(animated: true) {
            if lastName == "" && firstName == "" {
              //  self!.navigationController?.popToRootViewController(animated: true)
                
           //     print("# of VCs:  \(self!.navigationController!.viewControllers)")
                
                let firstVC = ViewController()
                self!.navigationController?.pushViewController(firstVC, animated: true)  //popToViewController(firstVC, animated: true)
            }
        }
        
       
        
      
     //   print(self!.defaults.string(forKey: "lastName"))
     //   print(self!.defaults.string(forKey: "firstName"))
//        secondVC.delegate = self
//        let destinationVC = SecondViewController()
//        destinationVC.lastName = self!.lastNameTextField.text!
//        destinationVC.delegate = self
//                                    if let presenter = self!.presentingViewController as? ViewController {
//                            //                presenter.contacts.append(newContact)
//                                        presenter.lName = lastName1!
//                                        presenter.fName = firstName1!
//                                        }
//        self!.dismiss(animated: true, completion: nil)
//        self!.dismiss(animated: true) {
//            self!.navigationController?.popToRootViewController(animated: true)
//            print(self!.navigationController?.viewControllers)
//
//        }

//                                 self!.dismiss(animated: true) {       //  *******
//                                        var secondVC = SecondViewController()
//                                        self!.delegate = secondVC
//                                        self!.delegate?.setName(fName: firstName1!, lName: lastName1!)
        
//                                    }
        
//        for controller in (self?.navigationController?.viewControllers)? as Array {
//            if controller.isKind(of: SecondViewController.self) {
//                self?.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }
        
     //   print("Num of Controllers: \(self?.navigationController?.viewControllers.count)")
        
        
        
        
    }
    
    private lazy var action3 = UIAction { [weak self] _ in
        self!.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        button.isEnabled = false
        button.setTitleColor(.systemGray, for: .disabled)
            [firstNameTextField, lastNameTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
//        ViewControllerConfigurator.assemblingMVVM(view: self)
        //Setting the Delegate for the TextField
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
                //Default checking and disabling of the Button
        
        
      //  print(FileManager.default.urls(for: .documentsDirectory, in .userDomainMask))
        print("FileManager: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        setUpUI()
//        setUpBinding()
//        viewModel?.loadMoreMovies()
        
        if isEdit {
            labelView.text = "Edit Username"
            
            stackView.addArrangedSubview(labelView)
            stackView.addArrangedSubview(firstNameTextField)
            stackView.addArrangedSubview(lastNameTextField)
            stackView.addArrangedSubview(buttonEditName)
            
            view.addSubview(myEditButton)
            
            myEditButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0 ).isActive = true
            myEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
            myEditButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            
            
        } else {
            labelView.text = "MovieDB App"
            
            stackView.addArrangedSubview(labelView)
            stackView.addArrangedSubview(firstNameTextField)
            stackView.addArrangedSubview(lastNameTextField)
            stackView.addArrangedSubview(button)
            
        }
        
        
        
//        if (self.firstNameTextField.text!.count <= 2) && (self.lastNameTextField.text!.count <= 2) {
//            self.button.isEnabled = false
//        }
//        if (self.firstNameTextField.text!.count >= 2) && (self.lastNameTextField.text!.count >= 2) {
//            self.button.isEnabled = true
//        }
    }

//    private func setUpBinding() {
//        
//        viewModel?
//            .publisherMovies
//            .dropFirst()
//            .receive(on: RunLoop.main)
//            .sink(receiveValue: { [weak self] _ in
//                self?.refreshControl.endRefreshing()
//                self!.secondViewController.tableView.reloadData()      /////**************************************************
//            })
//            .store(in: &subscribers)
//        
//        viewModel?
//            .publisherPhotoCache
//            .dropFirst()
//            .receive(on: RunLoop.main)
//            .sink(receiveValue: { [weak self] _ in
////                self?.tableView.reloadData()
//                self!.secondViewController.tableView.reloadData()
//            })
//            .store(in: &subscribers)
//        
//        viewModel?.getMovies()
//        
//    }
//    
//    private func refreshData() {
//        print("refreshData")
//        viewModel?.forceUpdate()
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        if isEdit {
            
            DispatchQueue.main.async { [weak self] in
                self!.firstNameTextField.text = self!.defaults.object(forKey: "firstName") as? String? ?? "nil"
                self!.lastNameTextField.text = self!.defaults.object(forKey: "lastName") as? String? ?? "nil"
            }
        }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 3 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let first = firstNameTextField.text, first.count > 2,
            let last = lastNameTextField.text, last.count > 2
          //  let frequency = frequencyField.text, !frequency.isEmpty
        else {
            self.button.isEnabled = false
            button.setTitleColor(.systemGray, for: .disabled)
            return
        }
        button.isEnabled = true
        button.setTitleColor(.white, for: .normal)
    }
    
    
    func setUpUI() {
        // create constraints
//        let safeArea = view.safeAreaLayoutGuide
       
        let image = UIImage(named: "luke-chesser-3rWagdKBF7U-unsplash")?.image(alpha: 0.55)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .small)
        let largeConfig2 = UIImage.SymbolConfiguration(pointSize: 50, weight: .thin, scale: .small)
        
        let largeBoldDoc = UIImage(systemName: "m.circle.fill", withConfiguration: largeConfig)
        let largeBoldDoc2 = UIImage(systemName: "pencil.circle", withConfiguration: largeConfig2)
        
        button.setImage(largeBoldDoc, for: .normal)
        buttonEditName.setImage(largeBoldDoc2, for: .normal)
        
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
        
        firstNameTextField.layer.shadowOpacity = 0.5
        firstNameTextField.layer.shadowRadius = 1.0
        firstNameTextField.layer.masksToBounds = true
        firstNameTextField.layer.cornerRadius = 5
        firstNameTextField.layer.borderWidth = 1
        firstNameTextField.layer.borderColor = UIColor.white.cgColor
        
        lastNameTextField.layer.shadowOpacity = 0.5
        lastNameTextField.layer.shadowRadius = 1.0
        lastNameTextField.layer.masksToBounds = true
        lastNameTextField.layer.cornerRadius = 5
        lastNameTextField.layer.borderWidth = 1
        lastNameTextField.layer.borderColor = UIColor.white.cgColor
        
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
        
       
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        firstNameTextField.widthAnchor.constraint(equalToConstant: 190).isActive = true
        
        backGroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20.0).isActive = true
        
        
    }
    
    
    func showEditSave() {
        view.addSubview(buttonEditName)
        
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


public extension UIFont {
    
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
        
    var italic : UIFont {
        return withTraits(.traitItalic)
    }
        
    var bold : UIFont {
        return withTraits(.traitBold)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("editing stops...H1")

        print(textField.text!.count)
        
//        if (lastNameTextField.text!.count >= 2) && (firstNameTextField.text!.count >= 2){
//            print("fname: \(firstNameTextField.text!.count), lname: \(lastNameTextField.text!.count)")
//            button.isEnabled = false // Disabling the button
//            button.setTitleColor(.systemGray, for: .disabled)
//        } else {
//            button.isEnabled = true // Disabling the button
//            button.setTitleColor(.none, for: .normal)
//        }
//
        
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("editing stops...H2")
//    }
    
}
