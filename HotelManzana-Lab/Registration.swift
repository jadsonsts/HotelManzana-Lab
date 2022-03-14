//
//  Registration.swift
//  HotelManzana-Lab
//
//  Created by Jadson on 14/03/22.
//

import Foundation

struct Registration {
    
    var firstName: String
    var lastName: String
    var emailAdress: String

    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}
