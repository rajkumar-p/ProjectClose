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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        messagesResultSet = realm.objects(Message.self).sorted(byProperty: "messageId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LeadMessagesTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messagesResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messagesResultSet[indexPath.row]

        let messageCell = tableView.dequeueReusableCell(withIdentifier: leadMessageTableViewCellReuseIdentifier, for: indexPath) as! LeadMessageTableViewCell
        messageCell.selectionStyle = .none

//        messageCell.messageTypeImageViewPlaceholderView.backgroundColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerImageViewBackgroundColor)

        if message.messageType == "EMAIL" {
            let resizedEmailImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellEmailImageName)!, to: CGSize(width: 48.0, height: 33.0)).withRenderingMode(.alwaysTemplate)
            messageCell.messageTypeImageView.image = resizedEmailImage

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
            let resizedTextImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellTextIncomingImageName)!, to: CGSize(width: 48.0, height: 45.0)).withRenderingMode(.alwaysTemplate)
            messageCell.messageTypeImageView.image = resizedTextImage

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

//        messageCell.messageTypeImageView.tintColor = .white
        messageCell.messageTypeImageView.tintColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerImageViewBackgroundColor)

        messageCell.mainLabel?.font = UIFont(name: ProjectCloseFonts.leadMessagesTableViewControllerTitleFont, size: 20.0)
        messageCell.mainLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerTitleColor)

        messageCell.subTitleLabel?.font = UIFont(name: ProjectCloseFonts.leadMessagesTableViewControllerSubtitleFont, size: 18.0)
        messageCell.subTitleLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerSubtitleColor)

        return messageCell
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let message = messagesResultSet[indexPath.row]
//
//        let messageCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadMessageTableViewCellReuseIdentifier)
//        messageCell.selectionStyle = .none
//
//        if message.messageType == "TEXT" {
//            let resizedTextImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellTextIncomingImageName)!, to: CGSize(width: 20.0, height: 20.0)).withRenderingMode(.alwaysTemplate)
//
//            messageCell.textLabel?.text = message.textMessage?.to
//            messageCell.detailTextLabel?.text = message.textMessage?.message
//            messageCell.imageView?.image = resizedTextImage
//        } else if message.messageType == "PHONE" {
//            let resizedPhoneImage: UIImage!
//            if message.phoneCall.from == currentUserName {
//                // Outgoing phone call
//                resizedPhoneImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellPhoneOutgoingImageName)!, to: CGSize(width: 20.0, height: 20.0)).withRenderingMode(.alwaysTemplate)
//                messageCell.textLabel?.text = message.phoneCall.to
//            } else {
//                // Incoming phone call
//                resizedPhoneImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellPhoneIncomingImageName)!, to: CGSize(width: 20.0, height: 20.0)).withRenderingMode(.alwaysTemplate)
//                messageCell.textLabel?.text = message.phoneCall.from
//            }
//
//            let phoneCallDuration = message.phoneCall?.endTime.timeIntervalSince((message.phoneCall?.startTime)!)
//            let phoneCallDurationFormatter = DateComponentsFormatter()
//            phoneCallDurationFormatter.unitsStyle = .abbreviated
//
//            messageCell.detailTextLabel?.text = phoneCallDurationFormatter.string(from: phoneCallDuration!)
//            messageCell.imageView?.image = resizedPhoneImage
//        } else if message.messageType == "EMAIL" {
//            let resizedEmailImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellEmailImageName)!, to: CGSize(width: 20.0, height: 20.0)).withRenderingMode(.alwaysTemplate)
//
//            let participantsList = message.emailConversation?.participants.components(separatedBy: ", ")
//            var participantsTextRepresentation = ""
//            if (participantsList?.count)! > 2 {
//                participantsTextRepresentation = (participantsList?[0])! + ", " + (participantsList?[1])! + "  +\((participantsList?.count)! - 2)"
//            }
//            messageCell.textLabel?.text = participantsTextRepresentation
//
//            let subjectWithMessagesCount = (message.emailConversation?.subject)! + " (\((message.emailConversation?.messages.count)!))"
//            messageCell.detailTextLabel?.text = subjectWithMessagesCount
//            messageCell.imageView?.image = resizedEmailImage
//        }
//
//        messageCell.imageView?.contentMode = .center
//        messageCell.imageView?.clipsToBounds = true
//        messageCell.imageView?.tintColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerImageViewTintColor)
//
//        messageCell.textLabel?.font = UIFont(name: ProjectCloseFonts.leadMessagesTableViewControllerTitleFont, size: 20.0)
//        messageCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerTitleColor)
//
//        messageCell.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.leadMessagesTableViewControllerSubtitleFont, size: 18.0)
//        messageCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerSubtitleColor)
//
//        return messageCell
//    }
/*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messagesResultSet[indexPath.row]

        let messageCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadMessageTableViewCellReuseIdentifier)
        messageCell.selectionStyle = .none

        if message.messageType == "Text" {
            let resizedTextImage: UIImage!
            if message.from == currentUserName {
                // Outgoing message
                resizedTextImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellTextOutgoingImageName)!, to: CGSize(width: 40.0, height: 40.0)).withRenderingMode(.alwaysTemplate)
            } else {
                // Incoming message
                resizedTextImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellTextIncomingImageName)!, to: CGSize(width: 40.0, height: 40.0)).withRenderingMode(.alwaysTemplate)
            }

            messageCell.textLabel?.text = message.from
            messageCell.detailTextLabel?.text = message.textMessage?.message
            messageCell.imageView?.image = resizedTextImage
        } else if message.messageType == "Phone" {
            let resizedPhoneImage: UIImage!
            if message.from == currentUserName {
                // Outgoing message
                resizedPhoneImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellPhoneOutgoingImageName)!, to: CGSize(width: 40.0, height: 40.0)).withRenderingMode(.alwaysTemplate)
                messageCell.textLabel?.text = message.to
            } else {
                // Incoming message
                resizedPhoneImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellPhoneIncomingImageName)!, to: CGSize(width: 40.0, height: 40.0)).withRenderingMode(.alwaysTemplate)
                messageCell.textLabel?.text = message.from
            }

            let phoneCallDuration = message.phoneCall?.endTime.timeIntervalSince(message.dateTime)
            let phoneCallDurationFormatter = DateComponentsFormatter()
            phoneCallDurationFormatter.unitsStyle = .abbreviated
            
            messageCell.detailTextLabel?.text = phoneCallDurationFormatter.string(from: phoneCallDuration!)
            messageCell.imageView?.image = resizedPhoneImage
        } else if message.messageType == "Email" {
            let resizedEmailImage: UIImage!
            if message.from == currentUserName {
                // Outgoing message
                resizedEmailImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellEmailOutgoingImageName)!, to: CGSize(width: 40.0, height: 40.0)).withRenderingMode(.alwaysTemplate)
                messageCell.textLabel?.text = message.to
            } else {
                // Incoming message
                resizedEmailImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.leadMessageTableViewCellEmailIncomingImageName)!, to: CGSize(width: 40.0, height: 40.0)).withRenderingMode(.alwaysTemplate)
                messageCell.textLabel?.text = message.from
            }

            messageCell.detailTextLabel?.text = message.emailMessage?.subject
            messageCell.imageView?.image = resizedEmailImage
        }

        messageCell.imageView?.contentMode = .center
//        messageCell.imageView?.layer.cornerRadius = 35.0
        messageCell.imageView?.clipsToBounds = true
        messageCell.imageView?.tintColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerImageViewTintColor)
//        messageCell.imageView?.backgroundColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerImageViewBackgroundColor)

        messageCell.textLabel?.font = UIFont(name: ProjectCloseFonts.leadMessagesTableViewControllerTitleFont, size: 20.0)
        messageCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerTitleColor)

        messageCell.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.leadMessagesTableViewControllerSubtitleFont, size: 18.0)
        messageCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerSubtitleColor)

        return messageCell
    }
 */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
