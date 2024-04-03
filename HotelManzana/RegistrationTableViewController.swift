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
   
}
