//
//  CustomTableViewCell.swift
//  MarsProject
//
//  Created by Ethan Faggett on 3/25/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
