//
//  DetailViewController.swift
//  MarsProject
//
//  Created by Ethan Faggett on 3/29/22.
//

import UIKit


protocol DetailViewControllerDelegate: AnyObject {
    func setStatus(_ status: Bool, name: String?, imageURL: String?, id: Int?)
}


class DetailViewController: UIViewController {
    
    // MARK: - Property Declarations
    var name: String = ""
    var body: String = ""
    var status = false
    var id: Int = 0
    var imgURL: String = ""
    var itemIndex: Int = 0
    
    let customRed = UIColor(displayP3Red: 179/255, green: 15/255, blue: 9/255, alpha: 0.70)
    let customGreen = UIColor(displayP3Red: 9/255, green: 214/255, blue: 12/255, alpha: 1.0)
    
    weak var delegate: DetailViewControllerDelegate?
    var returnMasterVC: ((_ status: Bool, _ id: Int?, _ name: String?, _ imageURL: String?) -> Void)?
    
    
    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .blue
        return label
    }()
   
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .blue
        return label
    }()
    
    private let nasaImageView: UIImageView = {
        let profileImageview = UIImageView()
        profileImageview.translatesAutoresizingMaskIntoConstraints = false
        profileImageview.backgroundColor = .clear
        profileImageview.image?.withTintColor(UIColor.red)
        return profileImageview
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action1)
        button.setTitle("Save", for: UIControl.State.normal)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.orange, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
  
    private lazy var switchControl: UISwitch = {
        let control = UISwitch(frame: .zero, primaryAction: switchAction)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let backGroundImageView: UIImageView = {
        let backGroundImageView = UIImageView()
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.backgroundColor = .lightGray
        return backGroundImageView
    }()
    
    
    
    //MARK: - Custom Methods
    private lazy var action1 = UIAction { [weak self] _ in
        
        self!.status = self!.switchControl.isOn
        
        self!.delegate?.setStatus(self!.status, name: self!.name, imageURL: self!.imgURL, id: self!.id)
            self?.navigationController?.popViewController(animated: true)
    }
    
    private lazy var switchAction: UIAction = UIAction { [weak self] _ in
//        self?.returnMasterViewController()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "space-1648267457129-5048")?.image(alpha: 0.55)
        backGroundImageView.image = image
        backGroundImageView.contentMode = .scaleAspectFill
        
        title = "ID: \(id)"
        
        setUpUI()
        populateUI()
    }
    
    private func setUpUI() {
    
        let onColor  = customGreen
        let offColor = UIColor.red

//        let mSwitch = UISwitch(frame: CGRect.zero)
        switchControl.isOn = true

        /*For on state*/
        switchControl.onTintColor = onColor

        /*For off state*/
        switchControl.tintColor = offColor
        switchControl.layer.cornerRadius = switchControl.frame.height / 2.0
        switchControl.backgroundColor = offColor
        switchControl.clipsToBounds = true
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
        
        view.backgroundColor = .darkGray
        
        view.addSubview(backGroundImageView)
        view.addSubview(nameLabel)
        view.addSubview(bodyLabel)
        view.addSubview(switchControl)
        view.addSubview(button)
        view.addSubview(idLabel)
        view.addSubview(nasaImageView)
        
        
        self.navigationController!.navigationBar.tintColor = .white
            
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        ]
   
        let boldText = NSAttributedString(string: name, attributes: boldAttribute)
        //           let regularText = NSAttributedString(string: " regular", attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        
        nameLabel.attributedText = newString
        
        // create constraints
        let safeArea = view.safeAreaLayoutGuide
        
        button.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 15.0).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
       // button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15.0).isActive = true
        
        idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15.0).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15.0).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15.0).isActive = true
        
        bodyLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 15.0).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15.0).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15.0).isActive = true
        
        switchControl.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 15.0).isActive = true
        switchControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15.0).isActive = true
        
        backGroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        nasaImageView.topAnchor.constraint(equalTo: switchControl.bottomAnchor, constant: 25.0).isActive = true
        nasaImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8.0).isActive = true
        nasaImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8.0).isActive = true
        nasaImageView.heightAnchor.constraint(equalToConstant: 400.0).isActive = true
     
        
    }
    
    private func populateUI() {
     //   nameLabel.text = name
        nameLabel.textColor = .white
        bodyLabel.text = "Rover: " + body
        bodyLabel.textColor = .white
        switchControl.isOn = status
       
        idLabel.textColor = .white
        
            idLabel.text = "ID: " +  String(id)
        
        loadImage()
        
   //     print("ID: \(id), ImageURL: \(imgURL)")
        
    }
    
    private func loadImage() {
        
        let serialQueue = DispatchQueue(label: "queue-get image")
        serialQueue.async { [weak self] in
            
            var inputString = self!.imgURL
            let fourthIndex = inputString.index(inputString.startIndex, offsetBy: 4)
            inputString.insert("s", at: fourthIndex)

            //print(inputString)
            
            guard let url = URL(string: (inputString))
            else { return }
            do {
                print("url..: \(url)")
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async { [self] in
                    self?.nasaImageView.image = UIImage(data: data)
                    self?.nasaImageView.contentMode = .scaleAspectFill
                    
                    self!.nasaImageView.layer.borderColor = UIColor.lightGray.cgColor
                    self!.nasaImageView.layer.borderWidth = 2
                    self!.nasaImageView.layer.cornerRadius = 15
                    self!.nasaImageView.layer.masksToBounds = true
                }
                
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func returnMasterViewController() {
        status = switchControl.isOn
        delegate?.setStatus(status, name: name, imageURL: imgURL, id: id)
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}
