//
//  DetailsRegistrationViewController.swift
//  HotelManzana-Lab
//
//  Created by Jadson on 16/03/22.
//

import UIKit

class DetailsRegistrationViewController: UIViewController {

    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var checkInDate: UILabel!
    @IBOutlet weak var checkOutDate: UILabel!
    @IBOutlet weak var numberOfAdults: UILabel!
    @IBOutlet weak var numberOfChildren: UILabel!
    @IBOutlet weak var hasWifi: UILabel!
    @IBOutlet weak var chosenBed: UILabel!
    
    
    var registration: Registration!
    
    
//    var firstName = ""
//    var lastName = ""
//    var email1 = ""
//    var checkInDate1 = ""
//    var checkOutDate1 = ""
//    var numberOfAdults1 = ""
//    var numberOfChildren1 = ""
//    var wifi = ""
//    var roomChoice1 =  ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


//
//        fullName.text = firstName + " " + lastName
//        email.text = email1
//        checkInDate.text = checkInDate1
//        checkOutDate.text = checkOutDate1
//        numberOfAdults.text = numberOfAdults1
//        numberOfChildren.text = numberOfChildren1
//        hasWifi.text = wifi
//        chosenBed.text = roomChoice1
        
        
        fullName.text = registration.firstName + " " + registration.lastName
        email.text = registration.emailAdress
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        checkInDate.text = dateFormatter.string(from: registration.checkInDate)
        checkOutDate.text = dateFormatter.string(from: registration.checkOutDate)
        numberOfAdults.text = String(registration.numberOfAdults)
        numberOfChildren.text = String(registration.numberOfChildren)
        hasWifi.text = String(registration.wifi)
        chosenBed.text = registration.roomType.name + " $" + String(registration.roomType.price)
        
    }
    
}
