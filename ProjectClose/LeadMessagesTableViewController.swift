//
//  LeadMessagesTableViewController.swift
//  ProjectClose
//
//  Created by raj on 23/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class LeadMessagesTableViewController: UITableViewController {
    let leadMessageTableViewCellReuseIdentifier = "LeadMessageCell"

    var leadId: String!

    var realm: Realm!
    var messagesResultSet: Results<Message>!
    
    let currentUserName = "Rajkumar P"

    var commsOptionsView: UIView!
    var commsOptionsViewTopAnchorConstraint: NSLayoutConstraint!

    init() {
        super.init(nibName: nil, bundle: nil)
        setupAddMessageButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        setupRealm()
        loadMessages()
    }

    func setupAddMessageButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        rightBarButtonItem.tintColor = UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerAddTaskButtonColor)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(LeadMessageTableViewCell.classForCoder(), forCellReuseIdentifier: leadMessageTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadMessages() {
        messagesResultSet = realm.objects(Message.self).filter(NSPredicate(format: "leadId == %@", leadId)).sorted(byKeyPath: "messageId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LeadMessagesTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messagesResultSet[indexPath.row]

        let messageCell = tableView.dequeueReusableCell(withIdentifier: leadMessageTableViewCellReuseIdentifier, for: indexPath) as! LeadMessageTableViewCell
        messageCell.selectionStyle = .none

        if message.messageType == "EMAIL" {
            messageCell.messageTypeImageView.image = UIImage(named: ProjectCloseStrings.leadMessagesTableViewControllerMessageEmailImageName)?.withRenderingMode(.alwaysTemplate)
            messageCell.messageTypeImageView.contentMode = .center

            let participantsList = message.emailConversation?.participants.components(separatedBy: ", ")
            var participantsTextRepresentation = ""
            if (participantsList?.count)! > 2 {
                participantsTextRepresentation = (participantsList?[0])! + ", " + (participantsList?[1])! + "  +\((participantsList?.count)! - 2)"
            }

            messageCell.mainLabel?.text = participantsTextRepresentation
            messageCell.mainLabel?.sizeToFit()

            let subjectWithMessagesCount = (message.emailConversation?.subject)! + " (\((message.emailConversation?.messages.count)!))"
            messageCell.subTitleLabel?.text = subjectWithMessagesCount
            messageCell.subTitleLabel?.sizeToFit()
        } else if message.messageType == "TEXT" {
            messageCell.messageTypeImageView.image = UIImage(named: ProjectCloseStrings.leadMessagesTableViewControllerMessageTextMessageImageName)?.withRenderingMode(.alwaysTemplate)
            messageCell.contentMode = .center

            messageCell.mainLabel?.text = message.textMessage?.to
            messageCell.subTitleLabel?.text = message.textMessage?.message
        } else if message.messageType == "PHONE" {
            let resizedPhoneImage: UIImage!
            if message.phoneCall.from == currentUserName {
                // Outgoing phone call
                resizedPhoneImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellPhoneOutgoingImageName)!, to: CGSize(width: 48.0, height: 49.0)).withRenderingMode(.alwaysTemplate)
                messageCell.mainLabel?.text = message.phoneCall.to
            } else {
                // Incoming phone call
                resizedPhoneImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellPhoneIncomingImageName)!, to: CGSize(width: 48.0, height: 49.0)).withRenderingMode(.alwaysTemplate)
                messageCell.mainLabel?.text = message.phoneCall.from
            }

            messageCell.messageTypeImageView.image = resizedPhoneImage

            let phoneCallDuration = message.phoneCall?.endTime.timeIntervalSince((message.phoneCall?.startTime)!)
            let phoneCallDurationFormatter = DateComponentsFormatter()
            phoneCallDurationFormatter.unitsStyle = .abbreviated

            messageCell.subTitleLabel?.text = phoneCallDurationFormatter.string(from: phoneCallDuration!)
        }

        messageCell.messageTypeImageView.tintColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerImageViewBackgroundColor)

        messageCell.mainLabel?.font = UIFont(name: ProjectCloseFonts.leadMessagesTableViewControllerTitleFont, size: 20.0)
        messageCell.mainLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerTitleColor)

        messageCell.subTitleLabel?.font = UIFont(name: ProjectCloseFonts.leadMessagesTableViewControllerSubtitleFont, size: 18.0)
        messageCell.subTitleLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerSubtitleColor)

        return messageCell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let replyAction = UITableViewRowAction(style: .normal, title: "Reply", handler: { action, indexPath in

        })
        replyAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerReplyActionBackgroundColor)

        let replyAllAction = UITableViewRowAction(style: .normal, title: "Reply All", handler: { action, indexPath in

        })
        replyAllAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerReplyAllActionBackgroundColor)

        return [replyAction, replyAllAction]
    }

}
