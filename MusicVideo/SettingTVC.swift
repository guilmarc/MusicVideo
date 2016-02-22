//
//  SettingTVCTableViewController.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-22.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {

    
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var APICount: UILabel!
    @IBOutlet weak var sliderCount: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.alwaysBounceVertical = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        self.touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecuritySetting")
    }

    func preferredFontChange(){
        print("The preferred font has changed")
        self.aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.APICount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    @IBAction func touchIDSecurity(sender: UISwitch) {
    
        NSUserDefaults.standardUserDefaults().setBool(self.touchID.on, forKey: "SecuritySetting")
    }
    
    
    // Is called just as the object is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name : UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
