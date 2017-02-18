//
//  LeadDetailsContainerViewController.swift
//  ProjectClose
//
//  Created by raj on 31/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class LeadDetailsContainerViewController: UIViewController {
    var realm: Realm!
    var leadResultSet: Results<Lead>!
    var lead: Lead!
    var leadId: String!

    var selectedViewController: UIViewController!

    var changeDelegate: ChangeLeadDelegate!

//    init() {
//        super.init(nibName: nil, bundle: nil)
//
//        setupAddButton()
//        setupLeftBarButton()
//    }

    init(leadId: String) {
        super.init(nibName: nil, bundle: nil)

        self.leadId = leadId
        setupAddButton()
        setupLeftBarButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()

        setupPagingMenuMoveHandler()
        setupRealm()
        loadLeadDetails(leadId: leadId)

        initTitle()
        loadFreshMessagesForLead()
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLeadDetails(leadId: String) {
        lead = realm.object(ofType: Lead.self, forPrimaryKey: leadId)
    }

    func loadFreshMessagesForLead() {
        try! realm.write {
            realm.delete(realm.objects(ToItem.self))
            realm.delete(realm.objects(TextMessage.self))
            realm.delete(realm.objects(PhoneCall.self))
            realm.delete(realm.objects(EmailMessage.self))
            realm.delete(realm.objects(EmailConversation.self))
            realm.delete(realm.objects(Message.self))

            realm.add(makeTextMessage(messageId: "11", leadId: leadId, from: "Rajkumar P", to: ["Jack Black", "Robert De Niro"], dateTime: Date(), messageContent: "Hope you liked the proposal."), update: true)
            realm.add(makeTextMessage(messageId: "10", leadId: leadId, from: "Jack Black", to: ["Rajkumar P"], dateTime: Date(timeIntervalSinceNow: 3*60), messageContent: "I have requested Robert to follow up."), update: true)
            realm.add(makeTextMessage(messageId: "9", leadId: leadId, from: "Robert De Niro", to: ["Rajkumar P"], dateTime: Date(timeIntervalSinceNow: 4*60), messageContent: "Let me check it out and get back to you."), update: true)
            realm.add(makeTextMessage(messageId: "8", leadId: leadId, from: "Rajkumar P", to: ["Robert De Niro"], dateTime: Date(timeIntervalSinceNow: 4*60), messageContent: "Thank you."), update: true)

            realm.add(makePhoneCall(messageId: "7", leadId: leadId, from: "Rajkumar P", to: "Jack Black", dateTime: Date(timeIntervalSinceNow: 6*60), endTime: Date(timeIntervalSinceNow: 9*60)))
            realm.add(makePhoneCall(messageId: "5", leadId: leadId, from: "Jack Black", to: "Rajkumar P", dateTime: Date(timeIntervalSinceNow: 10*60), endTime: Date(timeIntervalSinceNow: 15*60)))
            realm.add(makePhoneCall(messageId: "6", leadId: leadId, from: "Robert De Niro", to: "Rajkumar P", dateTime: Date(timeIntervalSinceNow: 9*60), endTime: Date(timeIntervalSinceNow: 9*15*60)))
            realm.add(makePhoneCall(messageId: "4", leadId: leadId, from: "Rajkumar P", to: "Robert De Niro", dateTime: Date(timeIntervalSinceNow: 30*60), endTime: Date(timeIntervalSinceNow: 30*2*60)))
            
            makeOrEditEmailMessage(messageId: "1", leadId: leadId, from: "Rajkumar P", to: ["Jack Black", "Robert De Niro"], dateTime: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, subject: "Proposal Detail", messageContent: "Some message")
            makeOrEditEmailMessage(messageId: "2", leadId: leadId, from: "Jack Black", to: ["Rajkumar P", "Robert De Niro"], dateTime: Calendar.current.date(byAdding: .day, value: -1, to: Date(timeIntervalSinceNow: 5*60))!, subject: "Proposal Detail", messageContent: "Some Message")
            makeOrEditEmailMessage(messageId: "3", leadId: leadId, from: "Rajkumar P", to: ["Jack Black", "Robert De Niro"], dateTime: Calendar.current.date(byAdding: .day, value: -1, to: Date(timeIntervalSinceNow: 7*60))!, subject: "Proposal Detail", messageContent: "Some Message")
            
            makeOrEditEmailMessage(messageId: "12", leadId: leadId, from: "Rajkumar P", to: ["Robert De Niro", "Jack Black"], dateTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, subject: "Proposal Sent to Jack Black", messageContent: "Some Message 8.")
            makeOrEditEmailMessage(messageId: "13", leadId: leadId, from: "Robert De Niro", to: ["Rajkumar P", "Jack Black"], dateTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, subject: "Proposal Sent to Jack Black", messageContent: "Some Message 9.")
        }
    }

    func makeTextMessage(messageId: String, leadId: String, from: String, to: [String], dateTime: Date, messageContent: String) -> Message {
        let message = Message()
        message.messageId = messageId
        message.leadId = leadId

        let textMessage = TextMessage()
        textMessage.from = from
        textMessage.to = to.joined(separator: ", ")
        
        textMessage.message = messageContent
        textMessage.dateTime = dateTime

        message.messageType = MessageType.Text.rawValue
        message.textMessage = textMessage

        return message
    }

    func makeOrEditEmailMessage(messageId: String, leadId: String, from: String, to: [String]!, dateTime: Date, subject: String, messageContent: String) {
        if let emailConversation = realm.object(ofType: EmailConversation.self, forPrimaryKey: "\(leadId) :: \(subject)") {
            if let participants = emailConversation.participants {
                var participantsList = participants.components(separatedBy: ", ")
                for eachTo in to {
                    if participantsList.contains(eachTo) {
                        let presentIndex = participantsList.index(of: eachTo)
                        participantsList.remove(at: presentIndex!)
                    }

                    participantsList.insert(eachTo, at: 0)
                }

                emailConversation.participants = participantsList.joined(separator: ", ")
            } else {
                emailConversation.participants = to.joined(separator: ", ")
            }

            let emailMessage = EmailMessage()
            emailMessage.from = from
            emailMessage.to = to.joined(separator: ", ")
            emailMessage.message = messageContent
            emailMessage.dateTime = dateTime

            emailConversation.messages.append(emailMessage)
        } else {
            let emailMessage = EmailMessage()
            emailMessage.from = from
            emailMessage.to = to.joined(separator: ", ")
            emailMessage.message = messageContent
            emailMessage.dateTime = dateTime

            let emailConversation = EmailConversation()
            emailConversation.participants = to.joined(separator: ", ")
            emailConversation.leadId = leadId
            emailConversation.subject = subject

            emailConversation.messages.append(emailMessage)

            let message = Message()
            message.messageId = messageId
            message.leadId = leadId
            message.emailConversation = emailConversation
            message.messageType = MessageType.Email.rawValue

            message.emailConversation = emailConversation

            realm.add(message, update: true)
        }
    }

    func makePhoneCall(messageId: String, leadId: String, from: String, to: String, dateTime: Date, endTime: Date) -> Message {
        let message = Message()
        message.messageId = messageId
        message.leadId = leadId

        let phoneCall = PhoneCall()
        phoneCall.from = from
        phoneCall.to = to
        phoneCall.startTime = dateTime
        phoneCall.endTime = endTime

        message.messageType = MessageType.Phone.rawValue
        message.phoneCall = phoneCall

        return message
    }

    func initTitle() {
        self.title = lead.companyName
    }

    func setupAddButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonPressed(_:)))
        rightBarButtonItem.tintColor = UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerAddTaskButtonColor)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupPagingMenuMoveHandler() {
        let leadDetailsPagingMenuViewController = self.childViewControllers.first as! LeadDetailsPagingMenuViewController
        selectedViewController = leadDetailsPagingMenuViewController.childViewControllers.first?.childViewControllers.first

//        let leadStatusTableViewController = leadDetailsPagingMenuViewController.childViewControllers.first?.childViewControllers.last as! LeadStatusTableViewController
//        leadStatusTableViewController.leadId = leadId

        leadDetailsPagingMenuViewController.onMove = { state in
            switch state {
            case .willMoveController(_, _): break
            case let .didMoveController(menuViewController, _):
                self.selectedViewController = menuViewController
            case .willMoveItem(_, _): break
            case .didMoveItem(_, _): break
            }
        }
    }

    func addButtonPressed(_ sender: UIBarButtonItem) {
        if selectedViewController is LeadTasksTableViewController {
            let addLeadTaskViewController = AddLeadTaskViewController()
            addLeadTaskViewController.leadId = leadId
            addLeadTaskViewController.addLeadTaskDelegate = selectedViewController as! LeadTasksTableViewController

            self.navigationController?.pushViewController(addLeadTaskViewController, animated: true)
        } else if selectedViewController is LeadContactsTableViewController {
            let addLeadContactViewController = AddLeadContactViewController()
            addLeadContactViewController.leadId = leadId
            addLeadContactViewController.addLeadContactDelegate = selectedViewController as! LeadContactsTableViewController

            self.navigationController?.pushViewController(addLeadContactViewController, animated: true)
        } else if selectedViewController is LeadMessagesTableViewController {
            let commsOptionsAlertController = UIAlertController(title: nil, message: "Communication Options", preferredStyle: .actionSheet)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                print("Cancel Action.")
            })
            commsOptionsAlertController.addAction(cancelAction)

            let callAction = UIAlertAction(title: "Make a Call", style: .default, handler: { action in
                print("Call Action.")
            })
            commsOptionsAlertController.addAction(callAction)

            let textMessageAction = UIAlertAction(title: "Send a Text Message", style: .default, handler: { action in
                print("Text Message Action")
            })
            commsOptionsAlertController.addAction(textMessageAction)

            let emailAction = UIAlertAction(title: "Send an Email", style: .default, handler: { action in
                print("Email Action.")
            })
            commsOptionsAlertController.addAction(emailAction)

            commsOptionsAlertController.view.tintColor = UIColor(hexString: ProjectCloseColors.leadMessagesTableViewControllerCommsOptionsTintColor)
            self.present(commsOptionsAlertController, animated: true, completion: {

            })
        }
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(LeadDetailsContainerViewController.backButtonPressed(_:)))
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        changeDelegate.didChangeLead(sender: self)
        let _ = self.navigationController?.popToViewController(changeDelegate as! UIViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LeadDetailsContainerViewController")
    }
    
}
