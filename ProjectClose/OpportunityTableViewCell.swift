//
//  OpportunityTableViewCell.swift
//  ProjectClose
//
//  Created by raj on 09/03/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class OpportunityTableViewCell: UITableViewCell {
    var cellBackgroundView: UIView!
    var leadView: UIView!
    var leadLabel: UILabel!

    var leftView: UIView!
    var rightView: UIView!

    var valueLabel: UILabel!
    var userLabel: UILabel!

    var confidenceView: UIView!
    var confidenceInPrecentageView: UIView!

    var confidencePercentage: Double!
    var confidencePercentageLabel: UILabel!

    var statusLabel: UILabel!

    init(style: UITableViewCellStyle, reuseIdentifier: String?, confidencePercentage: Double) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.confidencePercentage = confidencePercentage

        cellBackgroundView = UIView()
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundView.backgroundColor = .white

        contentView.addSubview(cellBackgroundView)

        leadView = UIView()
        leadView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(leadView)

        leadLabel = UILabel()
        leadLabel.translatesAutoresizingMaskIntoConstraints = false

        leadLabel.layer.cornerRadius = 55.0 / 2
        leadLabel.clipsToBounds = true
        leadLabel.layer.borderColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellLeadLabelBorderColor)?.cgColor
        leadLabel.layer.borderWidth = 2.0

        leadView.addSubview(leadLabel)

        leftView = UIView()
        leftView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(leftView)

        rightView = UIView()
        rightView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(rightView)

        valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.sizeToFit()

        leftView.addSubview(valueLabel)

        userLabel = UILabel()
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.sizeToFit()

        leftView.addSubview(userLabel)

        confidenceView = UIView()
        confidenceView.translatesAutoresizingMaskIntoConstraints = false

        rightView.addSubview(confidenceView)

        confidenceInPrecentageView = UIView()
        confidenceInPrecentageView.translatesAutoresizingMaskIntoConstraints = false

        confidenceView.addSubview(confidenceInPrecentageView)

        confidencePercentageLabel = UILabel()
        confidencePercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        confidencePercentageLabel.backgroundColor = .white
        confidencePercentageLabel.sizeToFit()

        confidenceView.addSubview(confidencePercentageLabel)

        statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.sizeToFit()

        rightView.addSubview(statusLabel)
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

        leadView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[leadLabel]-10-|", metrics: nil, views: ["leadLabel" : leadLabel]))
        leadView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[leadLabel]-10-|", metrics: nil, views: ["leadLabel" : leadLabel]))
        leadView.addConstraint(leadLabel.centerXAnchor.constraint(equalTo: (leadLabel.superview?.centerXAnchor)!))
        leadView.addConstraint(leadLabel.centerYAnchor.constraint(equalTo: (leadLabel.superview?.centerYAnchor)!))

        cellBackgroundView.addConstraint(leftView.widthAnchor.constraint(equalTo: (leftView.superview?.widthAnchor)!, multiplier: 0.50))
        cellBackgroundView.addConstraint(leftView.heightAnchor.constraint(equalTo: (leftView.superview?.heightAnchor)!))
        cellBackgroundView.addConstraint(leftView.leftAnchor.constraint(equalTo: leadView.rightAnchor))

        cellBackgroundView.addConstraint(rightView.widthAnchor.constraint(equalTo: (rightView.superview?.widthAnchor)!, multiplier: 0.30))
        cellBackgroundView.addConstraint(rightView.heightAnchor.constraint(equalTo: (rightView.superview?.heightAnchor)!))
        cellBackgroundView.addConstraint(rightView.rightAnchor.constraint(equalTo: (rightView.superview?.rightAnchor)!))

        leftView.addConstraint(valueLabel.heightAnchor.constraint(equalToConstant: 24.0))
        cellBackgroundView.addConstraint(valueLabel.leftAnchor.constraint(equalTo: leadLabel.rightAnchor, constant: 16.0))
//        leftView.addConstraint(valueLabel.leftAnchor.constraint(equalTo: (valueLabel.superview?.leftAnchor)!, constant: 5.0))
        leftView.addConstraint(valueLabel.bottomAnchor.constraint(equalTo: (valueLabel.superview?.centerYAnchor)!, constant: -3.0))

        leftView.addConstraint(userLabel.heightAnchor.constraint(equalToConstant: 24.0))
        cellBackgroundView.addConstraint(userLabel.leftAnchor.constraint(equalTo: leadLabel.rightAnchor, constant: 16.0))
//        leftView.addConstraint(userLabel.leftAnchor.constraint(equalTo: (userLabel.superview?.leftAnchor)!, constant: 5.0))
        leftView.addConstraint(userLabel.topAnchor.constraint(equalTo: (userLabel.superview?.centerYAnchor)!, constant: 3.0))

        rightView.addConstraint(confidenceView.widthAnchor.constraint(equalTo: (confidenceView.superview?.widthAnchor)!, multiplier: 0.90))
        rightView.addConstraint(confidenceView.heightAnchor.constraint(equalToConstant: 25.0))
        rightView.addConstraint(confidenceView.centerXAnchor.constraint(equalTo: (confidenceView.superview?.centerXAnchor)!))
        rightView.addConstraint(confidenceView.bottomAnchor.constraint(equalTo: (confidenceView.superview?.centerYAnchor)!, constant: -3.0))

        rightView.addConstraint(statusLabel.heightAnchor.constraint(equalToConstant: 24.0))
        rightView.addConstraint(statusLabel.centerXAnchor.constraint(equalTo: (statusLabel.superview?.centerXAnchor)!))
        rightView.addConstraint(statusLabel.topAnchor.constraint(equalTo: (statusLabel.superview?.centerYAnchor)!, constant: 3.0))

        confidenceView.addConstraint(confidenceInPrecentageView.widthAnchor.constraint(equalTo: (confidenceInPrecentageView.superview?.widthAnchor)!, multiplier: CGFloat(confidencePercentage! / 100.0)))
        confidenceView.addConstraint(confidenceInPrecentageView.heightAnchor.constraint(equalTo: (confidenceInPrecentageView.superview?.heightAnchor)!))
        confidenceView.addConstraint(confidenceInPrecentageView.leftAnchor.constraint(equalTo: (confidenceInPrecentageView.superview?.leftAnchor)!))
        confidenceView.addConstraint(confidenceInPrecentageView.topAnchor.constraint(equalTo: (confidenceInPrecentageView.superview?.topAnchor)!))

        confidenceView.addConstraint(confidencePercentageLabel.centerXAnchor.constraint(equalTo: (confidencePercentageLabel.superview?.centerXAnchor)!))
        confidenceView.addConstraint(confidencePercentageLabel.centerYAnchor.constraint(equalTo: (confidencePercentageLabel.superview?.centerYAnchor)!))
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
