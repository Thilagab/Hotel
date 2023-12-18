//
//  AddRoomTypeTableViewController.swift
//  HotelManzana
//
//  Created by Thilagawathy Duraisamy on 26/12/2023.
//

import UIKit




class AddRoomTypeTableViewController: UITableViewController {

    weak var delegate: AddRoomTypeTableViewControllerDelegate?
    
    static var allRoom: [Room] = [Room(id: 0, name: .OneKingBed, shortName: "K", price: 309),
                                  Room(id: 1, name: .TwoQueenBed, shortName: "Q", price: 209),
                                  Room(id: 2, name: .Suite, shortName: "S", price: 509)]
    
    var roomType: Room?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AddRoomTypeTableViewController.allRoom.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)

        // Configure the cell...
        let rooms = AddRoomTypeTableViewController.allRoom[indexPath.row]
        let roomType = rooms.name
        var config = cell.defaultContentConfiguration()
        config.text = roomType.rawValue
        config.secondaryText = "$\(rooms.price)"
        print(#function, rooms.price)
        cell.contentConfiguration = config

        if self.roomType?.name.rawValue == roomType.rawValue {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let roomType = AddRoomTypeTableViewController.allRoom[indexPath.row]
        self.roomType = roomType
        delegate?.AddRoomTypeTableViewController(self, didSelect: roomType)
        tableView.reloadData()
       
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


protocol AddRoomTypeTableViewControllerDelegate: AnyObject {
    
    func AddRoomTypeTableViewController(_ controller: AddRoomTypeTableViewController, didSelect roomType: Room)
    
}
