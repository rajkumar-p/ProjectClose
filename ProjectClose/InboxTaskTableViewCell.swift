//
//  InboxTaskTableViewCell.swift
//  ProjectClose
//
//  Created by raj on 20/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class InboxTaskTableViewCell: UITableViewCell {
    var cellBackgroundView: UIView!
    var leadView: UIView!
    var taskView: UIView!

    var leadLabel: UILabel!

    var mainLabel: UILabel!
    var subTitleLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellBackgroundView = UIView()
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundView.backgroundColor = .white

        contentView.addSubview(cellBackgroundView)

        leadView = UIView()
        leadView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(leadView)

        taskView = UIView()
        taskView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(taskView)

        leadLabel = UILabel()
        leadLabel.translatesAutoresizingMaskIntoConstraints = false

        leadLabel.layer.cornerRadius = 55.0 / 2
        leadLabel.clipsToBounds = true
        leadLabel.layer.borderColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewCellLeadLabelBorderColor)?.cgColor
        leadLabel.layer.borderWidth = 2.0

        leadView.addSubview(leadLabel)

        mainLabel = UILabel()
        mainLabel.translatesAutoresizingMaskIntoConstraints = false

        taskView.addSubview(mainLabel)

        subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        taskView.addSubview(subTitleLabel)
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

        cellBackgroundView.addConstraint(leadView.widthAnchor.constraint(equalTo: (leadView.superview?.widthAnchor)!, multiplier: 0.20))
        cellBackgroundView.addConstraint(leadView.heightAnchor.constraint(equalTo: (leadView.superview?.heightAnchor)!))
        cellBackgroundView.addConstraint(leadView.leftAnchor.constraint(equalTo: (leadView.superview?.leftAnchor)!))

        cellBackgroundView.addConstraint(taskView.widthAnchor.constraint(equalTo: (taskView.superview?.widthAnchor)!, multiplier: 0.80))
        cellBackgroundView.addConstraint(taskView.heightAnchor.constraint(equalTo: (taskView.superview?.heightAnchor)!))
        cellBackgroundView.addConstraint(taskView.leftAnchor.constraint(equalTo: leadView.rightAnchor))

        leadView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[leadLabel]-10-|", metrics: nil, views: ["leadLabel" : leadLabel]))
        leadView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[leadLabel]-10-|", metrics: nil, views: ["leadLabel" : leadLabel]))
        leadView.addConstraint(leadLabel.centerXAnchor.constraint(equalTo: (leadLabel.superview?.centerXAnchor)!))
        leadView.addConstraint(leadLabel.centerYAnchor.constraint(equalTo: (leadLabel.superview?.centerYAnchor)!))

        // Task View Constraints
        contentView.addConstraint(mainLabel.leftAnchor.constraint(equalTo: leadLabel.rightAnchor, constant: 16.0))
        taskView.addConstraint(mainLabel.bottomAnchor.constraint(equalTo: (mainLabel.superview?.centerYAnchor)!, constant: -3.0))
        taskView.addConstraint(mainLabel.heightAnchor.constraint(equalToConstant: 24.0))

        contentView.addConstraint(subTitleLabel.leftAnchor.constraint(equalTo: leadLabel.rightAnchor, constant: 16.0))
        taskView.addConstraint(subTitleLabel.topAnchor.constraint(equalTo: (subTitleLabel.superview?.centerYAnchor)!, constant: 3.0))
        taskView.addConstraint(subTitleLabel.heightAnchor.constraint(equalToConstant: 24.0))
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
