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
    var deletedEmail: Email?
    
    let spamEmail = Email(sender: "spam@asu.edu", recipient: "me@asu.edu", subject: "Spam!", contents: "You have spam!")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if selectedFolder == "Inbox" {
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
        //let addButton = UIBarButtonItem(barButtonSystemItem:.add, target:self, action: @selector(addAction:))

        if selectedFolder == "Sent" {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
            
        }
    }

    func addButtonTapped(){
        emails.append(spamEmail)
        performSegue(withIdentifier: "returnToMenuTVC", sender: self)

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
            // Delete the row from the data source
            deletedEmail = emails.remove(at: indexPath.row)
            index = indexPath.row
            tableView.deleteRows(at: [indexPath], with: .fade)
            performSegue(withIdentifier: "returnToMenuTVC", sender: self)
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
        if selectedFolder == "Inbox" {
            if index > -1 {
                destVC.dataDictionary["Inbox"] = emails
                destVC.dataDictionary["Trash"]!.append(deletedEmail!)
                
            }
        }
        if selectedFolder == "Sent" {
            destVC.dataDictionary["Sent"]=emails
        }
    }
    


}
