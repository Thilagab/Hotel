//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Thilagawathy Duraisamy on 19/12/2023.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, AddRoomTypeTableViewControllerDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var numberOfAdultStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var adultCountLabel: UILabel!
    @IBOutlet weak var childrenCountLabel: UILabel!
    
    @IBOutlet weak var wifiPriceLabel: UILabel!
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var detailRoomTypeLabel: UILabel!
    
    @IBOutlet weak var numberOfNightsLabel: UILabel!
    @IBOutlet weak var DateRangeForNightsLabel: UILabel!
    
    @IBOutlet weak var totalRateForRoomLabel: UILabel!
    @IBOutlet weak var roomTypeAndPriceLabel: UILabel!
    
    @IBOutlet weak var WifiRateLabel: UILabel!
    @IBOutlet weak var WifiAvailableLabel: UILabel!
    
    @IBOutlet weak var TotalLabel: UILabel!
    
    var guest: Registration?
    
    
    var registration: Registration? {
        get{
            
            
                guard let roomType = self.roomType else { return nil }
                
                let firstName = firstNameTextField.text ?? ""
                let lastName = lastNameTextField.text ?? ""
                let email = emailTextField.text ?? ""
                let checkIn = checkInDatePicker.date
                let checkOut = checkOutDatePicker.date
                let adult = Int(numberOfAdultStepper.value)
                let children = Int(numberOfChildrenStepper.value)
                let hasWifi = wifiSwitch.isOn
                let roomChoice = roomType//.name// detailRoomTypeLabel.text ?? ""
          
                return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkIn: checkIn, checkOut: checkOut, adult: adult, chiildren: children, wifi: hasWifi, roomType: roomChoice)
        
        }
    }
    
    
    var roomType: Room?
    var wifiOn: Bool = true
    
    
    let checkInDatePickerLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDatePickerLabelIndexPath = IndexPath(row: 2, section: 1)
    
    
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerVisible: Bool = false {
        didSet{
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var isCheckOutDatePickerVisible: Bool = false {
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    init?(coder: NSCoder, registration: Registration?) {
        super.init(coder: coder)
        self.guest = registration
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
         
        //Set today Date to check in date
        let midNightToday = Calendar.current.startOfDay(for: .now)
        checkInDatePicker.minimumDate = midNightToday
        checkInDatePicker.date = midNightToday
        
        
        updateDateChanges()
        updateNumberOfGuest()
        updateRoomType()
        
        if let guest = guest {
            firstNameTextField.text = guest.firstName
            lastNameTextField.text = guest.lastName
            emailTextField.text = guest.emailAddress
            let checkInDate = guest.checkIn
            checkInDateLabel.text = checkInDate.formatted(date: .abbreviated, time: .omitted)
            let checkOutDate = guest.checkOut
            
            checkOutDateLabel.text = checkOutDate.formatted(date: .abbreviated, time: .omitted)
            adultCountLabel.text = String(guest.adult)
            childrenCountLabel.text = String(guest.chiildren)
            
            wifiSwitch.isOn = guest.wifi
            detailRoomTypeLabel.text =  guest.roomType.name.rawValue
            self.roomType = guest.roomType
            title = "Edit guest details"
             let totalNumberDays = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate)
            print("totalNumberOfDays: \(totalNumberDays)")
            numberOfNightsLabel.text = "\(totalNumberDays.day ?? 0)"
            DateRangeForNightsLabel.text = "\((checkInDate..<checkOutDate).formatted(date: .abbreviated, time: .omitted))"
            var total = 0
            if guest.roomType == registration?.roomType {
                total = guest.roomType.price * (totalNumberDays.day ?? 0)
                totalRateForRoomLabel.text = "$\(total)"
            }
            roomTypeAndPriceLabel.text = "\(guest.roomType.name) @ \(guest.roomType.price)/night"
            WifiRateLabel.text = "$\(10 * (totalNumberDays.day ?? 0))"
            if guest.wifi { WifiAvailableLabel.text = "Yes"}
            else { WifiAvailableLabel.text = "No"}
            TotalLabel.text = "$\(total + (10 * (totalNumberDays.day ?? 0)))"
        }
        else {
            title = "Add new guest details"
            saveButton.isEnabled = false
        }
        
       
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker){
        updateDateChanges()
     
        tableView.reloadData()
    }
    
    @IBAction func stepperCountChanged(_ sender: UIStepper) {
        updateNumberOfGuest()
        print("stepper value \(sender.value)")
        
    }
    
    @IBAction func switchWifiChanged(_ sender: UISwitch){
   
        wifiOn = wifiSwitch.isOn
         updateRoomType()
        tableView.reloadData()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
    
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
       
        
    }
    
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> AddRoomTypeTableViewController? {
        
        let addRoomTypeViewController = HotelManzana.AddRoomTypeTableViewController(coder: coder)
        addRoomTypeViewController?.delegate = self
        addRoomTypeViewController?.roomType = roomType
        
        return addRoomTypeViewController
    }
    
    // MARK: - table view delegates

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
         
        if indexPath == checkInDatePickerLabelIndexPath && isCheckOutDatePickerVisible == false {
            isCheckInDatePickerVisible.toggle()
        } else if  indexPath == checkOutDatePickerLabelIndexPath && isCheckInDatePickerVisible == false {
            isCheckOutDatePickerVisible.toggle()
        }else if  indexPath == checkInDatePickerLabelIndexPath || indexPath == checkOutDatePickerLabelIndexPath {
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        }
    
        if let fName = firstNameTextField.text?.isEmpty , !fName,
           let lName = lastNameTextField.text?.isEmpty, !lName,
           let email = emailTextField.text?.isEmpty, !email,
           let checkInDate = checkInDateLabel.text?.isEmpty, !checkInDate,
           let checkOutDate = checkOutDateLabel.text?.isEmpty, !checkOutDate,
           let adult = adultCountLabel.text?.isEmpty, !adult,
           let children = childrenCountLabel.text?.isEmpty, !children {
        
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
        updateRoomType()
        tableView.beginUpdates()
        tableView.endUpdates()
            
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath where isCheckInDatePickerVisible == false:
            return 0
        case checkOutDatePickerIndexPath where isCheckOutDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
            
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath, checkOutDatePickerIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    func AddRoomTypeTableViewController(_ controller: AddRoomTypeTableViewController, didSelect roomType: Room) {
        self.roomType = roomType
        
        updateRoomType()
        
        tableView.reloadData()
    }
    
    // MARK: - User functions
    
    func updateDateChanges(){
        print("Checkin \(checkInDatePicker.date)")
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
        checkOutDateLabel.text = checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        //guest?.checkIn = registration?.checkIn
        guest?.checkIn = checkInDatePicker.date
        guest?.checkOut = checkOutDatePicker.date
        
    }
   
    // Update the number of guest details
    func updateNumberOfGuest(){
   
        adultCountLabel.text = "\(Int(numberOfAdultStepper.value))"
        childrenCountLabel.text = "\(Int(numberOfChildrenStepper.value))"
        
    }
    
    // Calculate and update the room charges
    func updateRoomType() {
    
        var total = 0
        if let room = roomType {
            
            detailRoomTypeLabel.text = room.name.rawValue
            
            guard let checkInDate = registration?.checkIn , let checkOutDate = registration?.checkOut else { return }
            
            let totalNumberDays = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate)
            total = room.price * (totalNumberDays.day ?? 0)
            totalRateForRoomLabel.text = "$\(total)"
            
            var wifiTotal = 0
            if wifiOn {
                WifiAvailableLabel.text = "Yes"
                wifiTotal = 10 * (totalNumberDays.day ?? 0)
            } else {
                WifiAvailableLabel.text = "No"
            }
            WifiRateLabel.text = "$\(wifiTotal)"
     
            TotalLabel.text = "$\(total + wifiTotal)"
            
            let totalDays = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate)
            numberOfNightsLabel.text = "\(String(describing: totalDays.day))"
            DateRangeForNightsLabel.text = "\((checkInDate..<checkOutDate).formatted(date: .abbreviated, time: .omitted))"
          
            roomTypeAndPriceLabel.text = "\(room.name) @ \(room.price)/night"
            
        } else {  detailRoomTypeLabel.text = "Not set" }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
  

}
