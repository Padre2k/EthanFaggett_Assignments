//
//  MovieCollectionViewCell.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
      
        static let identifier = "movieCollectionCell"
        
        private var movieImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.backgroundColor = .gray
            return image
        }()
        
        var titleLabel: UILabel = {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = "Title"
            title.textColor = .black
            title.font = UIFont.boldSystemFont(ofSize: 20)
            return title
        }()
        
         var movieText: UILabel = {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = "overview"
            title.textColor = .black
            return title
        }()
        
         var favorite: UILabel = {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = "✓"
            title.textColor = .black
             title.tintColor = .white
            return title
        }()
        
         var showDetails: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("show details", for: .normal)
            button.backgroundColor = .systemBlue
            
            button.setTitleColor(.white, for: .normal)
            return button
            
        }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
        func setUp(){
          //  contentView.addSubview(movieImage)
            contentView.addSubview(titleLabel)
            contentView.addSubview(movieText)
//            contentView.addSubview(showDetails)
            contentView.addSubview(favorite)
            
            let container = contentView.safeAreaLayoutGuide
            
            
//            movieImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
//            movieImage.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10).isActive = true
//         //   movieImage.widthAnchor.constraint(equalToConstant: contentView.frame.height * 2.2).isActive = true
//            movieImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
//            movieImage.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10).isActive = true
//            
//            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
//            titleLabel.leftAnchor.constraint(equalTo: movieImage.rightAnchor, constant: 10).isActive = true
            
            movieText.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
            movieText.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10).isActive = true
            
//            showDetails.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10).isActive = true
//            showDetails.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
//            showDetails.widthAnchor.constraint(equalToConstant: 120).isActive = true
            
            favorite.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -3).isActive = true
            favorite.topAnchor.constraint(equalTo: container.topAnchor, constant: 3).isActive = true
            
        }
    }
