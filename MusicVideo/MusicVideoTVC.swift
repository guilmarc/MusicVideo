//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-21.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    var filterSearch = [Videos]()
    
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    var limit = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChange(){
        print("The preferred font has changed")
    }
    
    func didLoadData(videos: [Videos])  {
        
        
        self.title = "iTunes Top \(limit) videos"
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for (index, item) in videos.enumerate() {
            print ("\(index) name : \(item.vName)")
        }
        
        
        definesPresentationContext = true
        
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search for Artist"
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        
        tableView.tableHeaderView = resultSearchController.searchBar
        
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged()
    {
        
        switch reachabilityStatus {
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            
            //Prnsent this Alert only while the View is completelly loaded
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
                    print("cancel")
                })
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
                    print("delete")
                })
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (alert) -> Void in
                    print("ok")
                })
                alert.addAction(cancelAction) ; alert.addAction(deleteAction) ; alert.addAction(okAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            
            })
        
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("do not refresh the api, refresh will be done manually")
            } else {
                runAPI()
            }
        }
        
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        runAPI()
    }
    
    func getAPICount() {
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("APICount") as? Int {
            self.limit = value
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDate = formatter.stringFromDate(NSDate())
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    func runAPI(){
        
        getAPICount()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/ca/rss/topmusicvideos/limit=\(self.limit)/json", completion: didLoadData)
    }
    
    // Is called just as the object is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name : UIContentSizeCategoryDidChangeNotification, object: nil)
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if resultSearchController.active {
            return filterSearch.count
        }
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MusicVideoTableViewCell
        if resultSearchController.active {
            cell.video = filterSearch[indexPath.row]
        } else {
            cell.video =  videos[indexPath.row]
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "musicDetail" {
            if let indexPath =  self.tableView.indexPathForSelectedRow  {
                
                let video : Videos
                if resultSearchController.active {
                    video = filterSearch[indexPath.row]
                } else {
                    video = videos[indexPath.row]
                }
                
                let controller = segue.destinationViewController as! MusicVideoDetailVC
                controller.videos = video
                
                
            }
        }
        
    }

}
