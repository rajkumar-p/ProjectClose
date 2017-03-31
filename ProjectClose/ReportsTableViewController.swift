//
//  ReportsTableViewController.swift
//  ProjectClose
//
//  Created by raj on 18/03/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class ReportsTableViewController: UITableViewController {
    let reportTableViewCellReuseIdentifier = "reportCell"

    let metricTitles = ["Tasks Closed", "Emails Read", "Emails Replied", "Opportunities Closed"]
    let metricHighs = [30, 70, 50, 10]

    var lowsHighsData = [ String : [ String : UInt32 ] ]()
    let weeksData = [["week1" : 23, "week2" : 45], ["week1" : 37, "week2" : 22], ["week1" : 22, "week2" : 10], ["week1" : 10, "week2" : 12]]

    var realm: Realm!
    var leadsResultSet: Results<Lead>!

    var leadsNotificationToken: NotificationToken!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        initTitle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initTitle() {
        self.title = NSLocalizedString("reports_table_vc_title", value: "Reports", comment: "Reports Table VC title")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        setupRealm()
        loadLeads()
        listenForLeadsNotifications()
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(MetricTableViewCell.classForCoder(), forCellReuseIdentifier: reportTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 190.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLeads() {
        leadsResultSet = realm.objects(Lead.self)
    }

    func listenForLeadsNotifications() {
        leadsNotificationToken = leadsResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.reloadTableView()
                break
            case .update(_, _, _, _):
                self?.reloadTableView()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : ReportsTableViewController")
    }

    deinit {
        leadsNotificationToken.stop()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return leadsResultSet.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let leadInSection = leadsResultSet[section]

        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 70.0))
        headerView.backgroundColor = UIColor(hexString: ProjectCloseColors.reportsTableViewControllerSectionBackgroundColor)

        let leadNameLabel = UILabel()
        leadNameLabel.translatesAutoresizingMaskIntoConstraints = false

        leadNameLabel.textAlignment = .left
        leadNameLabel.text = leadInSection.companyName
        leadNameLabel.textColor = UIColor(hexString: ProjectCloseColors.reportsTableViewControllerSectionLeadNameTitleColor)
        leadNameLabel.font = UIFont(name: ProjectCloseFonts.reportsTableViewControllerSectionLeadNameTitleFont, size: 20.0)
        leadNameLabel.sizeToFit()

        headerView.addSubview(leadNameLabel)

        headerView.addConstraint(leadNameLabel.heightAnchor.constraint(equalTo: (leadNameLabel.superview?.heightAnchor)!))
        headerView.addConstraint(leadNameLabel.centerYAnchor.constraint(equalTo: (leadNameLabel.superview?.centerYAnchor)!))
        headerView.addConstraint(leadNameLabel.leftAnchor.constraint(equalTo: (leadNameLabel.superview?.leftAnchor)!, constant: 16.0))

        let showDetailsImageView = UIImageView(image: UIImage(named: ProjectCloseStrings.reportsTableViewControllerHeaderShowDetailsImageName))
        showDetailsImageView.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(showDetailsImageView)

        headerView.addConstraint(showDetailsImageView.heightAnchor.constraint(equalToConstant: 30.0))
        headerView.addConstraint(showDetailsImageView.widthAnchor.constraint(equalToConstant: 30.0))
        headerView.addConstraint(showDetailsImageView.centerYAnchor.constraint(equalTo: (showDetailsImageView.superview?.centerYAnchor)!))
        headerView.addConstraint(showDetailsImageView.rightAnchor.constraint(equalTo: (showDetailsImageView.superview?.rightAnchor)!, constant: -16.0))

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let high: UInt32!
        let low: UInt32!
        let key = "\(indexPath.section)-\(indexPath.row)"
        if let lowHigh = lowsHighsData[key] {
            high = lowHigh["high"]!
            low = lowHigh["low"]!
        } else {
            let percent30 = UInt32(30.0 * CGFloat(metricHighs[indexPath.row]) / 100.0)
            high = arc4random_uniform(UInt32(metricHighs[indexPath.row]) + 1) + percent30
            low = arc4random_uniform(high)
            
            lowsHighsData[key] = ["high" : high, "low" : low]
        }

        let week1 = weeksData[indexPath.row]["week1"]!
        let week2 = weeksData[indexPath.row]["week2"]!

        let cell = tableView.dequeueReusableCell(withIdentifier: reportTableViewCellReuseIdentifier, for: indexPath)
        cell.selectionStyle = .none

        if let metricTableViewCell = cell as? MetricTableViewCell {
            // Init data
            metricTableViewCell.week1Value = week1
            metricTableViewCell.week2Value = week2

            metricTableViewCell.titleLabel.text = metricTitles[indexPath.row]
            metricTableViewCell.titleLabel.font = UIFont(name: ProjectCloseFonts.metricTableViewCellTitleFont, size: 18.0)
            metricTableViewCell.titleLabel.textColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellReportTitleColor)

            metricTableViewCell.outerCircle.layer.borderWidth = 1.0
            metricTableViewCell.outerCircle.layer.borderColor = UIColor(hexString: ProjectCloseColors.metricTableViewCellGraphColor)?.cgColor

            metricTableViewCell.outerCircle.layer.cornerRadius = 100.0 / 2.0
            metricTableViewCell.outerCircle.clipsToBounds = true

            metricTableViewCell.percentageLabel.text = String(Int(round(100.0 * (Double(low) / Double(high))))) + "%"
            metricTableViewCell.percentageLabel.font = UIFont(name: ProjectCloseFonts.metricTableViewCellPercentageTitleFont, size: 14.0)
            metricTableViewCell.percentageLabel.textColor = UIColor(hexString: ProjectCloseColors.metricTableViewCellPercentageTitleColor)

            metricTableViewCell.leftMetricTitleLabel.text = String(low) + " / " + String(high)
            metricTableViewCell.leftMetricTitleLabel.font = UIFont(name: ProjectCloseFonts.metricTableViewLeftMetricTitleFont, size: 15.0)
            metricTableViewCell.leftMetricTitleLabel.textColor = UIColor(hexString: ProjectCloseColors.metricTableViewLeftMetricTitleColor)

            let percentageChange = Int( round ((CGFloat(week2) - CGFloat(week1)) / CGFloat(week1) * 100.0) )
            if percentageChange < 0 {
                metricTableViewCell.rightMetricTitleLabel.text = "WoW (\(percentageChange)%)"
            } else {
                metricTableViewCell.rightMetricTitleLabel.text = "WoW (+\(percentageChange)%)"
            }

            metricTableViewCell.rightMetricTitleLabel.font = UIFont(name: ProjectCloseFonts.metricTableViewRightMetricTitleFont, size: 15.0)
            metricTableViewCell.rightMetricTitleLabel.textColor = UIColor(hexString: ProjectCloseColors.metricTableViewRightMetricTitleColor)

            metricTableViewCell.topBarView.backgroundColor = UIColor(hexString: ProjectCloseColors.metricTableViewTopBarTitleColor)

            metricTableViewCell.topBarLabel.text = "\(String(describing: week1))"
            metricTableViewCell.topBarLabel.font = UIFont(name: ProjectCloseFonts.metricTableViewTopBarTitleFont, size: 14.0)
            metricTableViewCell.topBarLabel.textColor = UIColor(hexString: ProjectCloseColors.metricTableViewTopBarTitleColor)

            metricTableViewCell.bottomBarView.backgroundColor = UIColor(hexString: ProjectCloseColors.metricTableViewBottomBarTitleColor)

            metricTableViewCell.bottomBarLabel.text = "\(String(describing: week2))"
            metricTableViewCell.bottomBarLabel.font = UIFont(name: ProjectCloseFonts.metricTableViewBottomBarTitleFont, size: 14.0)
            metricTableViewCell.bottomBarLabel.textColor = UIColor(hexString: ProjectCloseColors.metricTableViewBottomBarTitleColor)

            metricTableViewCell.week1Label.text = "Week 1"
            metricTableViewCell.week1Label.textColor = UIColor(hexString: ProjectCloseColors.metricTableViewWeekTextColor)
            metricTableViewCell.week1Label.font = UIFont(name: ProjectCloseFonts.metricTableViewWeekTextFont, size: 14.0)

            metricTableViewCell.week2Label.text = "Week 2"
            metricTableViewCell.week2Label.textColor = UIColor(hexString: ProjectCloseColors.metricTableViewWeekTextColor)
            metricTableViewCell.week2Label.font = UIFont(name: ProjectCloseFonts.metricTableViewWeekTextFont, size: 14.0)

            metricTableViewCell.setNeedsLayout()
            metricTableViewCell.layoutIfNeeded()

            let radius = CGFloat(min(metricTableViewCell.outerCircle.bounds.width, metricTableViewCell.outerCircle.bounds.height) / 2.0)
            let centerX = metricTableViewCell.outerCircle.bounds.midX
            let centerY = metricTableViewCell.outerCircle.bounds.midY

            let percentage = 100.0 * (Double(low) / Double(high))
            let degree = round(percentage * 360.0 / 100.0)

            let percentageLayer = CAShapeLayer.init()
            percentageLayer.path = UIBezierPath.init(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0, endAngle: ProjectCloseUtilities.degreeToRadian(degree: CGFloat(degree)), clockwise: true).cgPath
            percentageLayer.fillColor = UIColor.clear.cgColor
            percentageLayer.strokeColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellGraphColor)?.cgColor
            percentageLayer.lineWidth = 15.0

            metricTableViewCell.outerCircle.layer.addSublayer(percentageLayer)
        }

        return cell
    }
    
    func makeReportTableViewCell(low: Int, high: Int, metricTitle: String, metric: String) -> ReportTableViewCell {
        let reportTableViewCell = ReportTableViewCell(style: .default, reuseIdentifier: reportTableViewCellReuseIdentifier, metricTitle: metricTitle, low: low, high: high, metric: metric)
        
        reportTableViewCell.selectionStyle = .none
        
        reportTableViewCell.setNeedsLayout()
        reportTableViewCell.layoutIfNeeded()
        
        let radius = CGFloat(min(reportTableViewCell.outerCircle.bounds.width, reportTableViewCell.outerCircle.bounds.height) / 2.0)
        let centerX = reportTableViewCell.outerCircle.bounds.midX
        let centerY = reportTableViewCell.outerCircle.bounds.midY
        
        let percentage = 100.0 * (Double(low) / Double(high))
        let degree = Int(percentage * 360.0 / 100.0)
        
        let percentageLayer = CAShapeLayer.init()
        percentageLayer.path = UIBezierPath.init(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0, endAngle: ProjectCloseUtilities.degreeToRadian(degree: CGFloat(degree)), clockwise: true).cgPath
        percentageLayer.fillColor = UIColor.clear.cgColor
        percentageLayer.strokeColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellGraphColor)?.cgColor
        percentageLayer.lineWidth = 15.0
        
        reportTableViewCell.outerCircle.layer.addSublayer(percentageLayer)
        
        return reportTableViewCell

    }

    func makeTasksCompletedReportTableViewCell() -> ReportTableViewCell {
        let maxTasks = arc4random_uniform(21) + 10
        let closedTasks = arc4random_uniform(maxTasks)

        let reportTableViewCell = ReportTableViewCell(style: .default, reuseIdentifier: reportTableViewCellReuseIdentifier, metricTitle: "Tasks Completed", low: Int(closedTasks), high: Int(maxTasks), metric: "Tasks")

        reportTableViewCell.setNeedsLayout()
        reportTableViewCell.layoutIfNeeded()

        let radius = CGFloat(min(reportTableViewCell.outerCircle.bounds.width, reportTableViewCell.outerCircle.bounds.height) / 2.0)
        let centerX = reportTableViewCell.outerCircle.bounds.midX
        let centerY = reportTableViewCell.outerCircle.bounds.midY

        let percentage = 100.0 * (Double(closedTasks) / Double(maxTasks))
        let degree = Int(percentage * 360.0 / 100.0)

        let percentageLayer = CAShapeLayer.init()
        percentageLayer.path = UIBezierPath.init(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0, endAngle: ProjectCloseUtilities.degreeToRadian(degree: CGFloat(degree)), clockwise: true).cgPath
        percentageLayer.fillColor = UIColor.clear.cgColor
        percentageLayer.strokeColor = UIColor(hexString: ProjectCloseColors.reportTableViewCellGraphColor)?.cgColor
        percentageLayer.lineWidth = 15.0

        reportTableViewCell.outerCircle.layer.addSublayer(percentageLayer)

        return reportTableViewCell
    }

    func reloadTableView() {
        self.tableView.reloadData()
    }
    
}
