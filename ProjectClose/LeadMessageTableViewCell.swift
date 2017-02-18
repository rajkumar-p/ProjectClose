//
//  LeadMessageTableViewCell.swift
//  ProjectClose
//
//  Created by raj on 16/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class LeadMessageTableViewCell: UITableViewCell {
    var cellBackgroundView: UIView!
    var messageTypeView: UIView!
    var messageView: UIView!

    var messageTypeImageViewPlaceholderView: UIView!
    var messageTypeImageView: UIImageView!

    var mainLabel: UILabel!
    var subTitleLabel: UILabel!
    
//    override public var intrinsicContentSize: CGSize {
//        return CGSize(width: 200.0, height: 100.0)
//    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellBackgroundView = UIView()
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundView.backgroundColor = .white

        contentView.addSubview(cellBackgroundView)

        messageTypeView = UIView()
        messageTypeView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(messageTypeView)

        messageView = UIView()
        messageView.translatesAutoresizingMaskIntoConstraints = false

        cellBackgroundView.addSubview(messageView)
        
        messageTypeImageViewPlaceholderView = UIView()
        messageTypeImageViewPlaceholderView.translatesAutoresizingMaskIntoConstraints = false

        messageTypeImageViewPlaceholderView.layer.cornerRadius = 55.0 / 2
        messageTypeImageViewPlaceholderView.clipsToBounds = true
        messageTypeImageViewPlaceholderView.layer.borderColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerImageViewBackgroundColor)?.cgColor
        messageTypeImageViewPlaceholderView.layer.borderWidth = 2.0
        
        messageTypeView.addSubview(messageTypeImageViewPlaceholderView)

        messageTypeImageView = UIImageView()
        messageTypeImageView.translatesAutoresizingMaskIntoConstraints = false

        messageTypeImageViewPlaceholderView.addSubview(messageTypeImageView)

        mainLabel = UILabel()
        mainLabel.translatesAutoresizingMaskIntoConstraints = false

        messageView.addSubview(mainLabel)

        subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        messageView.addSubview(subTitleLabel)
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
        
        cellBackgroundView.addConstraint(messageTypeView.widthAnchor.constraint(equalTo: (messageTypeView.superview?.widthAnchor)!, multiplier: 0.20))
        cellBackgroundView.addConstraint(messageTypeView.heightAnchor.constraint(equalTo: (messageTypeView.superview?.heightAnchor)!))
        cellBackgroundView.addConstraint(messageTypeView.leftAnchor.constraint(equalTo: (messageTypeView.superview?.leftAnchor)!))
        
        cellBackgroundView.addConstraint(messageView.widthAnchor.constraint(equalTo: (messageView.superview?.widthAnchor)!, multiplier: 0.80))
        cellBackgroundView.addConstraint(messageView.heightAnchor.constraint(equalTo: (messageView.superview?.heightAnchor)!))
        cellBackgroundView.addConstraint(messageView.leftAnchor.constraint(equalTo: messageTypeView.rightAnchor))
        
        messageTypeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[messageTypeImageViewPlaceholderView]-10-|", metrics: nil, views: ["messageTypeImageViewPlaceholderView" : messageTypeImageViewPlaceholderView]))
        messageTypeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[messageTypeImageViewPlaceholderView]-10-|", metrics: nil, views: ["messageTypeImageViewPlaceholderView" : messageTypeImageViewPlaceholderView]))
        messageTypeView.addConstraint(messageTypeImageViewPlaceholderView.centerXAnchor.constraint(equalTo: (messageTypeImageViewPlaceholderView.superview?.centerXAnchor)!))
        messageTypeView.addConstraint(messageTypeImageViewPlaceholderView.centerYAnchor.constraint(equalTo: (messageTypeImageViewPlaceholderView.superview?.centerYAnchor)!))

        messageTypeImageViewPlaceholderView.addConstraint(messageTypeImageView.widthAnchor.constraint(equalToConstant: 30.0))
        messageTypeImageViewPlaceholderView.addConstraint(messageTypeImageView.heightAnchor.constraint(equalToConstant: 30.0))
        messageTypeImageViewPlaceholderView.addConstraint(messageTypeImageView.centerXAnchor.constraint(equalTo: (messageTypeImageView.superview?.centerXAnchor)!))
        messageTypeImageViewPlaceholderView.addConstraint(messageTypeImageView.centerYAnchor.constraint(equalTo: (messageTypeImageView.superview?.centerYAnchor)!))

        // Message View Constraints
        contentView.addConstraint(mainLabel.leftAnchor.constraint(equalTo: messageTypeImageViewPlaceholderView.rightAnchor, constant: 16.0))
        messageView.addConstraint(mainLabel.bottomAnchor.constraint(equalTo: (mainLabel.superview?.centerYAnchor)!, constant: -3.0))
        messageView.addConstraint(mainLabel.heightAnchor.constraint(equalToConstant: 24.0))

        contentView.addConstraint(subTitleLabel.leftAnchor.constraint(equalTo: messageTypeImageViewPlaceholderView.rightAnchor, constant: 16.0))
        messageView.addConstraint(subTitleLabel.topAnchor.constraint(equalTo: (subTitleLabel.superview?.centerYAnchor)!, constant: 3.0))
        messageView.addConstraint(subTitleLabel.heightAnchor.constraint(equalToConstant: 24.0))
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
