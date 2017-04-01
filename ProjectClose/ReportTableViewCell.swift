//
//  MetricTableViewCell.swift
//  ProjectClose
//
//  Created by raj on 24/03/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {
    var titleView: UIView!
    var titleLabel: UILabel!

    var metricView: UIView!
    var leftMetricView: UIView!
    var rightMetricView: UIView!

    var outerCircle: UIView!
    var percentageLayer: CAShapeLayer!
    var percentageLabel: UILabel!

    var leftFooterView: UIView!
    var rightFooterView: UIView!
    var footerView: UIView!
    var leftMetricTitleLabel: UILabel!
    var rightMetricTitleLabel: UILabel!

    var week1Value: Int!
    var week2Value: Int!

    var week1Label: UILabel!
    var week2Label: UILabel!

    var topBarView: UIView!
    var bottomBarView: UIView!
    var topBarLabel: UILabel!
    var bottomBarLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleView)

        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.sizeToFit()

        titleView.addSubview(titleLabel)

        metricView = UIView()
        metricView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(metricView)

        footerView = UIView()
        footerView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(footerView)

        leftFooterView = UIView()
        leftFooterView.translatesAutoresizingMaskIntoConstraints = false

        footerView.addSubview(leftFooterView)

        rightFooterView = UIView()
        rightFooterView.translatesAutoresizingMaskIntoConstraints = false

        footerView.addSubview(rightFooterView)

        leftMetricView = UIView()
        leftMetricView.translatesAutoresizingMaskIntoConstraints = false

        metricView.addSubview(leftMetricView)

        rightMetricView = UIView()
        rightMetricView.translatesAutoresizingMaskIntoConstraints = false

        metricView.addSubview(rightMetricView)

        outerCircle = UIView()
        outerCircle.translatesAutoresizingMaskIntoConstraints = false

        leftMetricView.addSubview(outerCircle)

        percentageLabel = UILabel()
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false

        percentageLabel.sizeToFit()

        outerCircle.addSubview(percentageLabel)

        percentageLayer = CAShapeLayer.init()
        percentageLayer.fillColor = UIColor.clear.cgColor
        percentageLayer.strokeColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellGraphColor)?.cgColor
        percentageLayer.lineWidth = 15.0

        outerCircle.layer.addSublayer(percentageLayer)

        leftMetricTitleLabel = UILabel()
        leftMetricTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        leftMetricTitleLabel.sizeToFit()

        leftFooterView.addSubview(leftMetricTitleLabel)

        rightMetricTitleLabel = UILabel()
        rightMetricTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        rightMetricTitleLabel.sizeToFit()

        rightFooterView.addSubview(rightMetricTitleLabel)

        topBarView = UIView()
        topBarView.translatesAutoresizingMaskIntoConstraints = false

        rightMetricView.addSubview(topBarView)

        bottomBarView = UIView()
        bottomBarView.translatesAutoresizingMaskIntoConstraints = false

        rightMetricView.addSubview(bottomBarView)

        topBarLabel = UILabel()
        topBarLabel.translatesAutoresizingMaskIntoConstraints = false

        topBarLabel.sizeToFit()

        rightMetricView.addSubview(topBarLabel)

        bottomBarLabel = UILabel()
        bottomBarLabel.translatesAutoresizingMaskIntoConstraints = false

        bottomBarLabel.sizeToFit()

        rightMetricView.addSubview(bottomBarLabel)

        week1Label = UILabel()
        week1Label.translatesAutoresizingMaskIntoConstraints = false

        week1Label.sizeToFit()

        topBarView.addSubview(week1Label)

        week2Label = UILabel()
        week2Label.translatesAutoresizingMaskIntoConstraints = false

        week2Label.sizeToFit()

        bottomBarView.addSubview(week2Label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addConstraint(titleView.widthAnchor.constraint(equalTo: (titleView.superview?.widthAnchor)!))
        contentView.addConstraint(titleView.heightAnchor.constraint(equalTo: (titleView.superview?.heightAnchor)!, multiplier: 0.15))
        contentView.addConstraint(titleView.leftAnchor.constraint(equalTo: (titleView.superview?.leftAnchor)!))
        contentView.addConstraint(titleView.topAnchor.constraint(equalTo: (titleView.superview?.topAnchor)!))

        titleView.addConstraint(titleLabel.leftAnchor.constraint(equalTo: (titleLabel.superview?.leftAnchor)!, constant: 16.0))
        titleView.addConstraint(titleLabel.centerYAnchor.constraint(equalTo: (titleLabel.superview?.centerYAnchor)!))

        contentView.addConstraint(metricView.widthAnchor.constraint(equalTo: (metricView.superview?.widthAnchor)!))
        contentView.addConstraint(metricView.heightAnchor.constraint(equalTo: (metricView.superview?.heightAnchor)!, multiplier: 0.70))
        contentView.addConstraint(metricView.topAnchor.constraint(equalTo: titleView.bottomAnchor))

        metricView.addConstraint(leftMetricView.widthAnchor.constraint(equalTo: (leftMetricView.superview?.widthAnchor)!, multiplier: 0.50))
        metricView.addConstraint(leftMetricView.heightAnchor.constraint(equalTo: (leftMetricView.superview?.heightAnchor)!))
        metricView.addConstraint(leftMetricView.topAnchor.constraint(equalTo: (leftMetricView.superview?.topAnchor)!))
        metricView.addConstraint(leftMetricView.leftAnchor.constraint(equalTo: (leftMetricView.superview?.leftAnchor)!))

        leftMetricView.addConstraint(outerCircle.heightAnchor.constraint(equalToConstant: 100.0))
        leftMetricView.addConstraint(outerCircle.widthAnchor.constraint(equalToConstant: 100.0))
        leftMetricView.addConstraint(outerCircle.centerXAnchor.constraint(equalTo: (outerCircle.superview?.centerXAnchor)!))
        leftMetricView.addConstraint(outerCircle.centerYAnchor.constraint(equalTo: (outerCircle.superview?.centerYAnchor)!))

        outerCircle.addConstraint(percentageLabel.centerXAnchor.constraint(equalTo: (percentageLabel.superview?.centerXAnchor)!))
        outerCircle.addConstraint(percentageLabel.centerYAnchor.constraint(equalTo: (percentageLabel.superview?.centerYAnchor)!))

        metricView.addConstraint(rightMetricView.widthAnchor.constraint(equalTo: (rightMetricView.superview?.widthAnchor)!, multiplier: 0.50))
        metricView.addConstraint(rightMetricView.heightAnchor.constraint(equalTo: (rightMetricView.superview?.heightAnchor)!))
        metricView.addConstraint(rightMetricView.topAnchor.constraint(equalTo: (rightMetricView.superview?.topAnchor)!))
        metricView.addConstraint(rightMetricView.rightAnchor.constraint(equalTo: (rightMetricView.superview?.rightAnchor)!))

        rightMetricView.addConstraint(topBarView.heightAnchor.constraint(equalToConstant: 20.0))
        rightMetricView.addConstraint(topBarView.bottomAnchor.constraint(equalTo: (topBarView.superview?.centerYAnchor)!, constant: -5.0))
        rightMetricView.addConstraint(topBarView.rightAnchor.constraint(equalTo: (topBarView.superview?.rightAnchor)!, constant: -5.0))

        rightMetricView.addConstraint(topBarLabel.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor))
        rightMetricView.addConstraint(topBarLabel.rightAnchor.constraint(equalTo: topBarView.leftAnchor, constant: -3.0))

        rightMetricView.addConstraint(bottomBarView.heightAnchor.constraint(equalToConstant: 20.0))
        rightMetricView.addConstraint(bottomBarView.topAnchor.constraint(equalTo: (bottomBarView.superview?.centerYAnchor)!, constant: 5.0))
        rightMetricView.addConstraint(bottomBarView.rightAnchor.constraint(equalTo: (bottomBarView.superview?.rightAnchor)!, constant: -5.0))
        
        if week1Value == week2Value {
            rightMetricView.addConstraint(topBarView.widthAnchor.constraint(equalTo: (topBarView.superview?.widthAnchor)!, multiplier: 0.90))
            rightMetricView.addConstraint(bottomBarView.widthAnchor.constraint(equalTo: (bottomBarView.superview?.widthAnchor)!, multiplier: 0.90))
        } else if week1Value < week2Value {
            rightMetricView.addConstraint(bottomBarView.widthAnchor.constraint(equalTo: (bottomBarView.superview?.widthAnchor)!, multiplier: 0.90))
            rightMetricView.addConstraint(topBarView.widthAnchor.constraint(equalTo: (topBarView.superview?.widthAnchor)!, multiplier: 0.90 * (CGFloat(week1Value) / CGFloat(week2Value))))
        } else {
            rightMetricView.addConstraint(topBarView.widthAnchor.constraint(equalTo: (topBarView.superview?.widthAnchor)!, multiplier: 0.90))
            rightMetricView.addConstraint(bottomBarView.widthAnchor.constraint(equalTo: (bottomBarView.superview?.widthAnchor)!, multiplier: 0.90 * (CGFloat(week2Value) / CGFloat(week1Value))))
        }

        rightMetricView.addConstraint(bottomBarLabel.centerYAnchor.constraint(equalTo: bottomBarView.centerYAnchor))
        rightMetricView.addConstraint(bottomBarLabel.rightAnchor.constraint(equalTo: bottomBarView.leftAnchor, constant: -3.0))

        topBarView.addConstraint(week1Label.rightAnchor.constraint(equalTo: (week1Label.superview?.rightAnchor)!))
        topBarView.addConstraint(week1Label.bottomAnchor.constraint(equalTo: (week1Label.superview?.topAnchor)!))
//        topBarView.addConstraint(week1Label.centerYAnchor.constraint(equalTo: (week1Label.superview?.centerYAnchor)!))

        bottomBarView.addConstraint(week2Label.rightAnchor.constraint(equalTo: (week2Label.superview?.rightAnchor)!))
        bottomBarView.addConstraint(week2Label.topAnchor.constraint(equalTo: (week2Label.superview?.bottomAnchor)!))
//        bottomBarView.addConstraint(week2Label.centerYAnchor.constraint(equalTo: (week2Label.superview?.centerYAnchor)!))

        contentView.addConstraint(footerView.widthAnchor.constraint(equalTo: (footerView.superview?.widthAnchor)!))
        contentView.addConstraint(footerView.heightAnchor.constraint(equalTo: (footerView.superview?.heightAnchor)!, multiplier: 0.15))
        contentView.addConstraint(footerView.topAnchor.constraint(equalTo: metricView.bottomAnchor))

        footerView.addConstraint(leftFooterView.widthAnchor.constraint(equalTo: (leftFooterView.superview?.widthAnchor)!, multiplier: 0.50))
        footerView.addConstraint(leftFooterView.heightAnchor.constraint(equalTo: (leftFooterView.superview?.heightAnchor)!))
        footerView.addConstraint(leftFooterView.leftAnchor.constraint(equalTo: (leftFooterView.superview?.leftAnchor)!))
        footerView.addConstraint(leftFooterView.topAnchor.constraint(equalTo: (leftFooterView.superview?.topAnchor)!))

        footerView.addConstraint(rightFooterView.widthAnchor.constraint(equalTo: (rightFooterView.superview?.widthAnchor)!, multiplier: 0.50))
        footerView.addConstraint(rightFooterView.heightAnchor.constraint(equalTo: (rightFooterView.superview?.heightAnchor)!))
        footerView.addConstraint(rightFooterView.rightAnchor.constraint(equalTo: (rightFooterView.superview?.rightAnchor)!))
        footerView.addConstraint(rightFooterView.topAnchor.constraint(equalTo: (rightFooterView.superview?.topAnchor)!))

        leftFooterView.addConstraint(leftMetricTitleLabel.centerXAnchor.constraint(equalTo: (leftMetricTitleLabel.superview?.centerXAnchor)!))
        leftFooterView.addConstraint(leftMetricTitleLabel.centerYAnchor.constraint(equalTo: (leftMetricTitleLabel.superview?.centerYAnchor)!))

        rightFooterView.addConstraint(rightMetricTitleLabel.centerXAnchor.constraint(equalTo: (rightMetricTitleLabel.superview?.centerXAnchor)!))
        rightFooterView.addConstraint(rightMetricTitleLabel.centerYAnchor.constraint(equalTo: (rightMetricTitleLabel.superview?.centerYAnchor)!))
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
