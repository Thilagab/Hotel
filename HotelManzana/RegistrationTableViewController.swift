//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Thilagawathy Duraisamy on 27/12/2023.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    
    var pastDate = DateComponents(day: 2)
    
    
     var registrations: [Registration] = []
/*    [Registration(firstName: "John", lastName: "Smith", emailAddress: "email@gmail.com", checkIn: Date.now, checkOut: DateComponents(day: 2).date!, adult: 2, chiildren: 2, wifi: true, roomType: Roomtype.OneKingBe*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue){
      
        
        
        guard let addRegistrationViewController = unwindSegue.source as? AddRegistrationTableViewController,
              let guest = addRegistrationViewController.registration
        else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            registrations[indexPath.row] = guest
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }else {
            registrations.append(guest)
            tableView.reloadData()
            
        }
        print(#function,"segue returned from done: \(guest)")
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        // Configure the cell...
        var config = cell.defaultContentConfiguration()
        let guest = registrations[indexPath.row]
        //print(#function,": \(guest)")
        config.text = guest.firstName + " " + guest.lastName
        let guestAccDate = (guest.checkIn..<guest.checkOut)
        print(#function,"\(guestAccDate)")
        config.secondaryText =  (guest.checkIn..<guest.checkOut).formatted(date: .numeric, time: .omitted) + " : \(guest.roomType.name.rawValue)"
        cell.contentConfiguration = config
        
        return cell
    }
   
    @IBSegueAction func editRegistration(_ coder: NSCoder, sender: Any?) -> AddRegistrationTableViewController? {
        
        if let cell = sender as? UITableViewCell,
           let index =  tableView.indexPath(for: cell){
            let guest = registrations[index.row]
            
            print(#function,": ",guest)
            return AddRegistrationTableViewController(coder: coder, registration: guest)
        }else {
            return AddRegistrationTableViewController(coder: coder,registration: nil)
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
