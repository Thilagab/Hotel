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

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
}

protocol AddRoomTypeTableViewControllerDelegate: AnyObject {
    
    func AddRoomTypeTableViewController(_ controller: AddRoomTypeTableViewController, didSelect roomType: Room)
    
}
