//
//  UserProfileTableViewCell.swift
//  ProjectClose
//
//  Created by raj on 28/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {
    var cellBackgroundView: UIView!
    var avatarView: UIView!
    var userDetailsView: UIView!

    var avatarButton: UIButton!

    var mainLabel: UILabel!
    var subTitleLabel: UILabel!
    var logoutButton: UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellBackgroundView = UIView()
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundView.backgroundColor = .white

        contentView.addSubview(cellBackgroundView)

        avatarView = UIView()
        avatarView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(avatarView)

        userDetailsView = UIView()
        userDetailsView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(userDetailsView)

        avatarButton = UIButton()
        avatarButton.translatesAutoresizingMaskIntoConstraints = false

        avatarButton.layer.cornerRadius = 55.0 / 2.0
        avatarButton.clipsToBounds = true

        avatarView.addSubview(avatarButton)

        mainLabel = UILabel()
        mainLabel.translatesAutoresizingMaskIntoConstraints = false

        userDetailsView.addSubview(mainLabel)

        subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        userDetailsView.addSubview(subTitleLabel)

        logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        logoutButton.layer.cornerRadius = 10.0
        logoutButton.clipsToBounds = true

        userDetailsView.addSubview(logoutButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addConstraint(cellBackgroundView.widthAnchor.constraint(equalTo: (cellBackgroundView.superview?.widthAnchor)!))
        contentView.addConstraint(cellBackgroundView.heightAnchor.constraint(equalTo: (cellBackgroundView.superview?.heightAnchor)!))

        cellBackgroundView.addConstraint(avatarView.widthAnchor.constraint(equalTo: (avatarView.superview?.widthAnchor)!, multiplier: 0.20))
        cellBackgroundView.addConstraint(avatarView.heightAnchor.constraint(equalTo: (avatarView.superview?.heightAnchor)!))
        cellBackgroundView.addConstraint(avatarView.leftAnchor.constraint(equalTo: (avatarView.superview?.leftAnchor)!))

        cellBackgroundView.addConstraint(userDetailsView.widthAnchor.constraint(equalTo: (userDetailsView.superview?.widthAnchor)!, multiplier: 0.80))
        cellBackgroundView.addConstraint(userDetailsView.heightAnchor.constraint(equalTo: (userDetailsView.superview?.heightAnchor)!))
        cellBackgroundView.addConstraint(userDetailsView.leftAnchor.constraint(equalTo: avatarView.rightAnchor))

        avatarView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[avatarButton]-10-|", metrics: nil, views: ["avatarButton" : avatarButton]))
        avatarView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[avatarButton]-10-|", metrics: nil, views: ["avatarButton" : avatarButton]))
        avatarView.addConstraint(avatarButton.centerXAnchor.constraint(equalTo: (avatarButton.superview?.centerXAnchor)!))
        avatarView.addConstraint(avatarButton.centerYAnchor.constraint(equalTo: (avatarButton.superview?.centerYAnchor)!))

        // Task View Constraints
        contentView.addConstraint(mainLabel.leftAnchor.constraint(equalTo: avatarButton.rightAnchor, constant: 16.0))
        userDetailsView.addConstraint(mainLabel.bottomAnchor.constraint(equalTo: (mainLabel.superview?.centerYAnchor)!, constant: -3.0))
        userDetailsView.addConstraint(mainLabel.heightAnchor.constraint(equalToConstant: 24.0))

        contentView.addConstraint(subTitleLabel.leftAnchor.constraint(equalTo: avatarButton.rightAnchor, constant: 16.0))
        userDetailsView.addConstraint(subTitleLabel.topAnchor.constraint(equalTo: (subTitleLabel.superview?.centerYAnchor)!, constant: 3.0))
        userDetailsView.addConstraint(subTitleLabel.heightAnchor.constraint(equalToConstant: 24.0))

        userDetailsView.addConstraint(logoutButton.rightAnchor.constraint(equalTo: (logoutButton.superview?.rightAnchor)!, constant: -10.0))
        userDetailsView.addConstraint(logoutButton.heightAnchor.constraint(equalToConstant: 24.0))
        userDetailsView.addConstraint(logoutButton.widthAnchor.constraint(equalTo: (logoutButton.superview?.widthAnchor)!, multiplier: 0.30))
//        userDetailsView.addConstraint(logoutButton.centerXAnchor.constraint(equalTo: (logoutButton.superview?.centerXAnchor)!))
        userDetailsView.addConstraint(logoutButton.centerYAnchor.constraint(equalTo: (logoutButton.superview?.centerYAnchor)!))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
