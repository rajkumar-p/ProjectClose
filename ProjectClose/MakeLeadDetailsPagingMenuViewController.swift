//
//  MakeLeadDetailsPagingMenuViewController.swift
//  ProjectClose
//
//  Created by raj on 25/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import PagingMenuController

func makeLeadDetailsPagingViewController(leadId: String) -> LeadDetailsPagingMenuViewController {
    struct PageMenuItemLeadTasks: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("lead_details_paging_menu_vc_lead_tasks_menu_title", value: "TASKS", comment: "Lead Details Paging Menu VC Lead Tasks Menu Title"),
                    color: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuTitleColor)!,
                    selectedColor: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuSelectedTitleColor)!,
                    font: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerTitleFont, size: 18.0)!,
                    selectedFont: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerSelectedTitleFont, size: 18.0)!
            ))
        }

        var horizontalMargin: CGFloat {
            return 5.0
        }
    }

    struct PageMenuItemLeadOpportunities: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("lead_details_paging_menu_vc_lead_opportunities_menu_title", value: "OPPORTUNITIES", comment: "Lead Details Paging Menu VC Lead Opportunities Menu Title"),
                    color: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuTitleColor)!,
                    selectedColor: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuSelectedTitleColor)!,
                    font: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerTitleFont, size: 18.0)!,
                    selectedFont: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerSelectedTitleFont, size: 18.0)!
            ))
        }

        var horizontalMargin: CGFloat {
            return 5.0
        }
    }

    struct PageMenuItemLeadContacts: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("lead_details_paging_menu_vc_lead_contants_menu_title", value: "CONTACTS", comment: "Lead Details Paging Menu VC Lead Contacts Menu Title"),
                    color: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuTitleColor)!,
                    selectedColor: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuSelectedTitleColor)!,
                    font: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerTitleFont, size: 18.0)!,
                    selectedFont: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerSelectedTitleFont, size: 18.0)!
            ))
        }

        var horizontalMargin: CGFloat {
            return 5.0
        }
    }

    struct PageMenuItemLeadMessages: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("lead_details_paging_menu_vc_lead_messages_menu_title", value: "MESSAGES", comment: "Lead Details Paging Menu VC Lead Messages Menu Title"),
                    color: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuTitleColor)!,
                    selectedColor: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuSelectedTitleColor)!,
                    font: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerTitleFont, size: 18.0)!,
                    selectedFont: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerSelectedTitleFont, size: 18.0)!
            ))
        }

        var horizontalMargin: CGFloat {
            return 5.0
        }
    }

    struct PageMenuItemLeadStatus: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("lead_details_paging_menu_vc_lead_status_menu_title", value: "STATUS", comment: "Lead Details Paging Menu VC Lead Status Menu Title"),
                    color: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuTitleColor)!,
                    selectedColor: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuSelectedTitleColor)!,
                    font: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerTitleFont, size: 18.0)!,
                    selectedFont: UIFont(name: ProjectCloseFonts.leadDetailsPagingMenuViewControllerSelectedTitleFont, size: 18.0)!
            ))
        }

        var horizontalMargin: CGFloat {
            return 5.0
        }
    }

    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            //            return .segmentedControl
            //            return .infinite(widthMode: .fixed(width: 100), scrollingMode: .pagingEnabled)
//            return .standard(widthMode: .fixed(width: 150.0), centerItem: false, scrollingMode: .scrollEnabledAndBouces)
            return .standard(widthMode: .fixed(width: 150.0), centerItem: false, scrollingMode: .pagingEnabled)
        }

        var focusMode: MenuFocusMode {
            return .underline(height: 3.0, color: UIColor(hexString: ProjectCloseColors.leadDetailsPagingMenuUnderlineColor)!, horizontalPadding: 10.0, verticalPadding: 0.0)
        }

        var itemsOptions: [MenuItemViewCustomizable] {
            return [PageMenuItemLeadTasks(), PageMenuItemLeadOpportunities(), PageMenuItemLeadContacts(), PageMenuItemLeadMessages(), PageMenuItemLeadStatus()]
        }
        
    }

    struct PagingMenuOptions: PagingMenuControllerCustomizable {
        let leadTasksTableViewController = LeadTasksTableViewController()
        let leadOpportunitiesTableViewController = LeadOpportunitiesTableViewController()
        let leadContactsTableViewController = LeadContactsTableViewController()
        let leadMessagesTableViewController = LeadMessagesTableViewController()
        var leadStatusTableViewController: LeadStatusTableViewController!
        
        init(leadId: String) {
            leadStatusTableViewController = LeadStatusTableViewController(leadId: leadId)
        }

        var componentType: ComponentType {
            return .all(menuOptions: MenuOptions(), pagingControllers: [leadTasksTableViewController, leadOpportunitiesTableViewController, leadContactsTableViewController, leadMessagesTableViewController, leadStatusTableViewController])
        }

        var lazyLoadingPage: LazyLoadingPage {
            return .all
        }
        
        var isScrollEnabled: Bool {
            return false
        }
    }

    return LeadDetailsPagingMenuViewController(options: PagingMenuOptions(leadId: leadId), leadId: leadId)
}
