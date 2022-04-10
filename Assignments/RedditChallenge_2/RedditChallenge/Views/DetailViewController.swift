//
//  DetailViewController.swift
//  RedditChallenge
//
//  Created by Ethan Faggett on 4/2/22.
//

import UIKit

class DetailViewController: UIViewController {

    let customPurple = UIColor(displayP3Red: 75/255, green: 63/255, blue: 114/255, alpha: 1)
    
    
    var storyTitle: String?
    var imgData: Data?
    
    private let yellowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
//        view.numberOfLines = 0
//        view.textAlignment = .left
//        view.textColor = .white
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action1)
        button.setTitle("Dismiss", for: UIControl.State.normal)
        button.backgroundColor = customPurple
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.orange, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.backgroundColor = .orange
//        label.text = "Testing..."
        return label
    }()
    
    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.lightGray
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 1.0
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = customPurple
        // Do any additional setup after loading the view.
        
        setUpUI()
        populateUI()
    }
    
    //MARK: - Custom Methods
    private lazy var action1 = UIAction { [weak self] _ in
        
    //    print("Action Button tapped....")
        
        self!.dismiss(animated: true, completion: nil)
    }
    
    func setUpUI() {
        
        view.addSubview(yellowView)
        view.addSubview(button)
        view.addSubview(titleLabel)
        view.addSubview(storyImageView)
        
        let safeArea = view.safeAreaLayoutGuide
        yellowView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        yellowView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        yellowView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        yellowView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        button.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10.0).isActive = true
        button.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 19.0).isActive = true
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
        
        titleLabel.topAnchor.constraint(equalTo: yellowView.topAnchor, constant: 8.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor,constant: 8.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: 8.0).isActive = true
        
        storyImageView.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 16.0).isActive = true
        storyImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10.0).isActive = true
        storyImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10.0).isActive = true
        storyImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20.0).isActive = true
        
  //      print("ImageData: \(imgData), Title: \(storyTitle)")
        
    }

    
    
    private func populateUI() {
        titleLabel.text = storyTitle
        loadImage()
        
    }
    
    private func loadImage() {
        
        if let image = imgData {
            DispatchQueue.main.async { [self] in
                storyImageView.isHidden = false
                self.storyImageView.image = UIImage(data: image)
                self.storyImageView.contentMode = .scaleAspectFill
                
                self.storyImageView.layer.borderColor = UIColor.lightGray.cgColor
                self.storyImageView.layer.borderWidth = 2
                self.storyImageView.layer.cornerRadius = 15
                self.storyImageView.layer.masksToBounds = true
            }
        } else {
//            storyImageView.image = UIImage(named: "placeholder-image")
            storyImageView.isHidden = true
        }
//
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
