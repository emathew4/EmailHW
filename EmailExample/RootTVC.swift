//
//  RootTVC.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

protocol CellSelectedDelegate {
    func read(email: Email)
}


class RootTVC: UITableViewController {

    var emails = [Email]()
    var selectedFolder = ""
    var delegate: CellSelectedDelegate?
    var index: Int = -1
    var deletedEmails = [Email]()
    
    let spamEmail = Email(sender: "spam@asu.edu", recipient: "me@asu.edu", subject: "Spam!", contents: "You have spam!")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // add custom back button
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RootTVC.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if selectedFolder == "Inbox" {
            // add edit button if in inbox
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }

        if selectedFolder == "Sent" {
            // add + button if in sent folder
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
            
        }
    }
    
    func back(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "returnToMenuTVC", sender: self)
        _ = navigationController?.popViewController(animated: true)
    }

    func addButtonTapped(){
        // change emails to add new sent email
        emails.append(spamEmail)
        
        // update tableView to display new email
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: emails.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emails.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: react to user selecting row
        //I want the detail view controller to update based on the row that I selected
        
        let selectedEmail = emails[indexPath.row]
        delegate?.read(email: selectedEmail)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let currentEmail = emails[indexPath.row]
        cell.textLabel?.text = currentEmail.subject
        cell.detailTextLabel?.text = currentEmail.sender

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source and added to deletedEmails
            deletedEmails.append(emails.remove(at:indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
            //performSegue(withIdentifier: "returnToMenuTVC", sender: self)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 
        } 
    }
    

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! MenuTVC
        
        // perform segue if user was in Inbox
        if selectedFolder == "Inbox" {
            // check to make sure that they actually deleted an email
            if index > -1 {
                // delete deleted emails from Inbox in datadictionary
                destVC.dataDictionary["Inbox"] = emails
                // added deleted emails to Trash in dataDictionary
                destVC.dataDictionary["Trash"] = destVC.dataDictionary["Trash"]! + deletedEmails
                
            }
        }
        // see if user was in sent folder
        if selectedFolder == "Sent" {
            // update sent folder emails
            destVC.dataDictionary["Sent"]=emails
        }
    }
    


}
