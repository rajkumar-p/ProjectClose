//
//  ReportTableViewCell.swift
//  ProjectClose
//
//  Created by raj on 19/03/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {
    var titleView: UIView!
    var metricTitleLabel: UILabel!
    var metricStarImageView: UIImageView!
    var metricView: UIView!
    var graphView: UIView!
    var totalView: UIView!

    var lowLabel: UILabel!
    var highLabel: UILabel!
    var metricLabel: UILabel!

    var outerCircle: UIView!

    var percentageLabel: UILabel!

    init(style: UITableViewCellStyle, reuseIdentifier: String?, metricTitle: String, low: Int, high: Int, metric: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false

        titleView.backgroundColor = .white

        contentView.addSubview(titleView)

        metricTitleLabel = UILabel()
        metricTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        metricTitleLabel.text = metricTitle
        metricTitleLabel.font = UIFont(name: ProjectCloseFonts.reportTableViewCellReportTitleFont, size: 18.0)
        metricTitleLabel.textColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellReportTitleColor)
        metricTitleLabel.sizeToFit()

        titleView.addSubview(metricTitleLabel)

        metricStarImageView = UIImageView(image: UIImage(named: ProjectCloseStrings.reportTableViewCellStarImageName)?.withRenderingMode(.alwaysTemplate))
        metricStarImageView.translatesAutoresizingMaskIntoConstraints = false

        metricStarImageView.tintColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellStarImageTintColor)

        titleView.addSubview(metricStarImageView)

        metricView = UIView()
        metricView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(metricView)

        graphView = UIView()
        graphView.translatesAutoresizingMaskIntoConstraints = false

        metricView.addSubview(graphView)

        totalView = UIView()
        totalView.translatesAutoresizingMaskIntoConstraints = false

        metricView.addSubview(totalView)

        lowLabel = UILabel()
        lowLabel.translatesAutoresizingMaskIntoConstraints = false

        lowLabel.text = String(low) + " /"
        lowLabel.font = UIFont(name: ProjectCloseFonts.reportTableViewCellLowTitleFont, size: 25.0)
        lowLabel.textColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellLowTitleColor)
        lowLabel.sizeToFit()

        totalView.addSubview(lowLabel)

        highLabel = UILabel()
        highLabel.translatesAutoresizingMaskIntoConstraints = false

        highLabel.text = String(high)
        highLabel.font = UIFont(name: ProjectCloseFonts.reportTableViewCellHighTitleFont, size: 35.0)
        highLabel.textColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellHighTitleColor)
        highLabel.sizeToFit()

        totalView.addSubview(highLabel)

        metricLabel = UILabel()
        metricLabel.translatesAutoresizingMaskIntoConstraints = false

        metricLabel.text = metric
        metricLabel.font = UIFont(name: ProjectCloseFonts.reportTableViewCellMetricFont, size: 15.0)
        metricLabel.textColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellMetricColor)
        metricLabel.sizeToFit()

        totalView.addSubview(metricLabel)

        outerCircle = UIView()
        outerCircle.translatesAutoresizingMaskIntoConstraints = false

        outerCircle.layer.borderWidth = 1.0
        outerCircle.layer.borderColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellGraphColor)?.cgColor

        outerCircle.layer.cornerRadius = 100.0 / 2.0
        outerCircle.clipsToBounds = true

        graphView.addSubview(outerCircle)

        percentageLabel = UILabel()
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false

        percentageLabel.text = String(Int(100.0 * (Double(low) / Double(high)))) + "%"
        percentageLabel.font = UIFont(name: ProjectCloseFonts.reportTableViewCellPercentageTitleFont, size: 20.0)
        percentageLabel.textColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellPercentageTitleColor)
        percentageLabel.sizeToFit()

        outerCircle.addSubview(percentageLabel)
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
        contentView.addConstraint(titleView.heightAnchor.constraint(equalTo: (titleView.superview?.heightAnchor)!, multiplier: 0.20))
        contentView.addConstraint(titleView.leftAnchor.constraint(equalTo: (titleView.superview?.leftAnchor)!))
        contentView.addConstraint(titleView.topAnchor.constraint(equalTo: (titleView.superview?.topAnchor)!))

        titleView.addConstraint(metricTitleLabel.leftAnchor.constraint(equalTo: (metricTitleLabel.superview?.leftAnchor)!, constant: 16.0))
        titleView.addConstraint(metricTitleLabel.centerYAnchor.constraint(equalTo: (metricTitleLabel.superview?.centerYAnchor)!))

        titleView.addConstraint(metricStarImageView.leftAnchor.constraint(equalTo: metricTitleLabel.rightAnchor, constant: 15.0))
        titleView.addConstraint(metricStarImageView.centerYAnchor.constraint(equalTo: (metricStarImageView.superview?.centerYAnchor)!))

        contentView.addConstraint(metricView.widthAnchor.constraint(equalTo: (metricView.superview?.widthAnchor)!))
        contentView.addConstraint(metricView.heightAnchor.constraint(equalTo: (metricView.superview?.heightAnchor)!, multiplier: 0.80))
        contentView.addConstraint(metricView.topAnchor.constraint(equalTo: titleView.bottomAnchor))

        metricView.addConstraint(graphView.widthAnchor.constraint(equalTo: (graphView.superview?.widthAnchor)!, multiplier: 0.40))
        metricView.addConstraint(graphView.heightAnchor.constraint(equalTo: (graphView.superview?.heightAnchor)!))
        metricView.addConstraint(graphView.topAnchor.constraint(equalTo: (graphView.superview?.topAnchor)!))
        metricView.addConstraint(graphView.leftAnchor.constraint(equalTo: (graphView.superview?.leftAnchor)!))

        metricView.addConstraint(totalView.widthAnchor.constraint(equalTo: (totalView.superview?.widthAnchor)!, multiplier: 0.60))
        metricView.addConstraint(totalView.heightAnchor.constraint(equalTo: (totalView.superview?.heightAnchor)!))
        metricView.addConstraint(totalView.topAnchor.constraint(equalTo: (totalView.superview?.topAnchor)!))
        metricView.addConstraint(totalView.rightAnchor.constraint(equalTo: (totalView.superview?.rightAnchor)!))

        totalView.addConstraint(lowLabel.centerXAnchor.constraint(equalTo: (lowLabel.superview?.centerXAnchor)!))
        totalView.addConstraint(lowLabel.bottomAnchor.constraint(equalTo: (lowLabel.superview?.centerYAnchor)!))

        totalView.addConstraint(highLabel.rightAnchor.constraint(equalTo: (highLabel.superview?.centerXAnchor)!, constant: -3.0))
        totalView.addConstraint(highLabel.topAnchor.constraint(equalTo: (highLabel.superview?.centerYAnchor)!))

        totalView.addConstraint(metricLabel.leftAnchor.constraint(equalTo: (metricLabel.superview?.centerXAnchor)!, constant: 3.0))
        totalView.addConstraint(metricLabel.lastBaselineAnchor.constraint(equalTo: highLabel.lastBaselineAnchor))

        graphView.addConstraint(outerCircle.heightAnchor.constraint(equalToConstant: 100.0))
        graphView.addConstraint(outerCircle.widthAnchor.constraint(equalToConstant: 100.0))
        graphView.addConstraint(outerCircle.centerXAnchor.constraint(equalTo: (outerCircle.superview?.centerXAnchor)!))
        graphView.addConstraint(outerCircle.centerYAnchor.constraint(equalTo: (outerCircle.superview?.centerYAnchor)!))

        outerCircle.addConstraint(percentageLabel.centerXAnchor.constraint(equalTo: (percentageLabel.superview?.centerXAnchor)!))
        outerCircle.addConstraint(percentageLabel.centerYAnchor.constraint(equalTo: (percentageLabel.superview?.centerYAnchor)!))
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
