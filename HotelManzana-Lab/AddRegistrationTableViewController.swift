//
//  AddRegistrationTableViewController.swift
//  HotelManzana-Lab
//
//  Created by Jadson on 8/03/22.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAdress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            numberOfAdults: numberOfAdults,
                            numberOfChildren: numberOfChildren,
                            roomType: roomType,
                            wifi: hasWifi)
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var numberOfNightsLabel: UILabel!
    @IBOutlet weak var shortNameRoomLabel: UILabel!
    @IBOutlet weak var totalCostRoomLabel: UILabel!
    @IBOutlet weak var wifiYesNoLabel: UILabel!
    @IBOutlet weak var wifiTotalCostLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    var wifiPrice = 0
    
    var roomType: RoomType?
    
    
    //storing the index path for easy comparison in the delegate methods
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    
    //store whether or not the date picker will be shown / show or hide them (not adjust the cell height / both start as not shown
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        disableDoneButton()
        
        numberOfNightsLabel.text = " "
        shortNameRoomLabel.text = " "
        totalCostLabel.text = " "
        totalCostRoomLabel.text = " "
    }
    
    func disableDoneButton() {
        if self.registration == nil {
            doneButton.isEnabled = false
            tableView.reloadData()
        } else {
            doneButton.isEnabled = true
            tableView.reloadData()
        }
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        
        checkInDateLabel.text = dateFormater.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormater.string(from: checkOutDatePicker.date)
        
        disableDoneButton()
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
        disableDoneButton()
    }
    
    func updateCharges () {
        if let diffInDays = Calendar.current.dateComponents([.day], from: checkInDatePicker.date, to: checkOutDatePicker.date).day {
            numberOfNightsLabel.text = "\(diffInDays)"
            
            if let shortName = registration?.roomType.shortName {
                shortNameRoomLabel.text = shortName
                let totalRoomCost = roomType!.price * (diffInDays)
                totalCostRoomLabel.text = String("$ \(totalRoomCost)")
            } else {
                shortNameRoomLabel.text = " "
            }
            
            if wifiSwitch.isOn {
                wifiYesNoLabel.text = "Yes"
                wifiPrice = 10
                wifiTotalCostLabel.text = String ("$ \(diffInDays * (wifiPrice))")
            } else {
                wifiYesNoLabel.text = "No"
                wifiPrice = 0
                wifiTotalCostLabel.text = "$ 0"
            }
            
            if roomTypeLabel.text == "Not Set" {
                totalCostLabel.text = " "
            } else {
                let totalCost = (roomType!.price * diffInDays) + (diffInDays + (wifiPrice))
                totalCostLabel.text = String(totalCost)
            }
            tableView.reloadData()
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
        updateCharges()
        disableDoneButton()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        updateCharges()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
        disableDoneButton()
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    /*   // ibaction to test all inputs b4 implementing the unwindSegue
     @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
     let firstName = firstNameTextField.text ?? ""
     let lastName = lastNameTextField.text ?? ""
     let email = emailTextField.text ?? ""
     let checkInDate = checkInDatePicker.date
     let checkOutDate = checkOutDatePicker.date
     let numberOfAdults = Int(numberOfAdultsStepper.value)
     let numberOfChildren = Int(numberOfChildrenStepper.value)
     let hasWifi = wifiSwitch.isOn
     let roomChoice = roomType?.name ?? "N/A"
     
     print("DONE TAPPED")
     print("firstName: \(firstName)")
     print("lastName: \(lastName)")
     print("email: \(email)")
     print("checkIn: \(checkInDate)")
     print("checkOut: \(checkOutDate)")
     print("numberOfAdulsts: \(numberOfAdults)")
     print("numberOfChildren: \(numberOfChildren)")
     print("wifi: \(hasWifi)")
     print("roomType: \(roomChoice)")
     } */
    
    
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
            updateCharges()
            disableDoneButton()
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    
    
    
    //MARK: - Delegate Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //checking if the index path is equal to one of the pickers cells and if the date picker is displayed to set up its height to 216 points
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row): if isCheckInDatePickerShown {
            return 216.0
        } else {
            return 0.0
        }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row): if isCheckOutDatePickerShown {
            return 216.0
        } else {
            return 0.0
        }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // check which row is selected and if one of them is the check-in date, show the date picker.
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1): if isCheckInDatePickerShown {
            isCheckInDatePickerShown = false
        } else if isCheckOutDatePickerShown {
            isCheckOutDatePickerShown = false
            isCheckInDatePickerShown = true
        } else {
            isCheckInDatePickerShown = true
        }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1): if isCheckOutDatePickerShown {
            isCheckOutDatePickerShown = false
        } else if isCheckInDatePickerShown {
            isCheckInDatePickerShown = false
            isCheckOutDatePickerShown = true
        } else {
            isCheckOutDatePickerShown = true
        }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationVC = segue.destination as? SelectRoomTypeTableViewController
            destinationVC?.delegate = self
            destinationVC?.roomType = roomType
        }
    }
    
}
 //MARK: - Change Focus on the textField

extension AddRegistrationTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        firstNameTextField.endEditing(true)
        lastNameTextField.endEditing(true)
        emailTextField.endEditing(true)
        
        if textField == firstNameTextField {
               textField.resignFirstResponder()
               lastNameTextField.becomeFirstResponder()
            } else if textField == lastNameTextField {
               textField.resignFirstResponder()
               emailTextField.becomeFirstResponder()
            } else if textField == emailTextField {
               textField.resignFirstResponder()
            }
        return true
    }
    
    
}
