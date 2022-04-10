//
//  StoryCell.swift
//  RedditChallenge
//
//  Created by Christian Quicano on 3/31/22.
//

import UIKit

class StoryCell: UITableViewCell {

    static let identifier = "StoryCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds
        
//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 1.0
        imageView.layer.masksToBounds = true
        
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(storyImageView)
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 8.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 8.0).isActive = true
        
        storyImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        storyImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        storyImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        storyImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20.0).isActive = true
    }
    
    func configureCell(title: String?, imageData: Data?) {
     //   var str = "Hello World"
        if let titleStr: String = title {
            titleLabel.text = titleStr.uppercased()
        }else {
            titleLabel.text = title
        }

        
        storyImageView.image = nil
        if let imageData = imageData {
            storyImageView.image = UIImage(data: imageData)
            storyImageView.contentMode = .scaleAspectFill
            storyImageView.layer.masksToBounds = true
        }
    }
    
   
    
    
}
