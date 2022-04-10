//
//  MovieTableViewCell.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/7/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //create your closure here
             var buttonPressed : (() -> ()) = {}

//            @IBAction func buttonAction(_ sender: UIButton) {
//        //Call your closure here
//                buttonPressed()
//            }
    
    static let identifier = "MovieCell"
    let secondViewController = SecondViewController()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Menlo", size: 16)
//        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action1)
        button.setTitle("Details", for: UIControl.State.normal)
        button.backgroundColor = UIColor.customRed  //UIColor.black.withAlphaComponent(1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.orange, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.tintColor = .white  //customlightGray
        
        return button
    }()
    
    private let movieImageView: UIImageView = {
        let movieImageview = UIImageView()
        movieImageview.translatesAutoresizingMaskIntoConstraints = false
        movieImageview.backgroundColor = .lightGray
        movieImageview.image?.withTintColor(UIColor.red)
        return movieImageview
    }()
    
    private let backGroundImageView: UIImageView = {
        let backGroundImageView = UIImageView()
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.backgroundColor = .black
        return backGroundImageView
    }()

    private let textfield: UITextView = {
        let textfield = UITextView()
        textfield.textAlignment = .justified
        textfield.textColor = .white
        textfield.backgroundColor = .clear
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.isEditable = false
        textfield.isSelectable = false
//        textfield.set
        return textfield
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
       
        let image = UIImage(named: "orange-gradient-wallpaper-1448-1581-hd-wallpapers-1024x640")?.image(alpha: 0.75)
        backGroundImageView.image = image
//        backGroundImageView.contentMode = .scaleAspectFill
        
//        contentView.backgroundColor = .black
        
//        contentView.addSubview(backGroundImageView)
        contentView.addSubview(movieImageView)
        
        contentView.addSubview(titleLabel)
       
        contentView.addSubview(button)
        contentView.addSubview(textfield)
        
//        contentView.backgroundColor = .systemPink
        
        // create constraints
        let safeArea = contentView.safeAreaLayoutGuide
        
        button.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7.0).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 25.0).isActive = true
        
      //  titleLabel.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
      //  titleLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
//        backGroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
//        backGroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        backGroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        backGroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        textfield.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        textfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        textfield.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 7.0).isActive = true
      //  textfield.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7.0).isActive = true
       // textfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0).isActive = true
        textfield.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        textfield.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        
        
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 130.0).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
        
        
    }
    
    
    func configureCell(title: String?){ //, imageData: Data?) {
     //   var str = "Hello World"
//        if let titleStr: String = title {
//            titleLabel.text = titleStr.uppercased()
//        }else {
            titleLabel.text = title
//        }
        textfield.text = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia."
        
        
//        backgroundColor = .orange.withAlphaComponent(0.5)
//        tintColor = .clear
//        textLabel?.textColor = .white
        
//        storyImageView.image = nil
//        if let imageData = imageData {
//            storyImageView.image = UIImage(data: imageData)
//            storyImageView.contentMode = .scaleAspectFill
//            storyImageView.layer.masksToBounds = true
//        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    private lazy var action1 = UIAction { [weak self] _ in
//        self?.getImage()
        print("This is the button tapped...")
       
        self!.buttonPressed()
        
       
    }
}
