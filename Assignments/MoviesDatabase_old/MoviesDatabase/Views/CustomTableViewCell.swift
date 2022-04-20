//
//  CustomTableViewCell.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/7/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    private let labelView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
       // label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.font = UIFont.
        label.font = UIFont(name: "Avenir", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }()
    
    private let movieImageView: UIImageView = {
        let profileImageview = UIImageView()
        profileImageview.translatesAutoresizingMaskIntoConstraints = false
        profileImageview.backgroundColor = .clear
        profileImageview.image?.withTintColor(UIColor.red)
        return profileImageview
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
