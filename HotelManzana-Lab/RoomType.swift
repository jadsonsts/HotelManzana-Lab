//
//  RoomType.swift
//  HotelManzana-Lab
//
//  Created by Jadson on 14/03/22.
//

import Foundation

class RoomType: Equatable {
    
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    init(id: Int, name: String, shortName: String, price: Int) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.price = price
    }
    
   static var all: [RoomType] {
         return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
               RoomType(id: 1, name: "One King", shortName: "K", price: 209),
               RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)]
    }
}

//Equatable Protocol Implementation for RoomType

func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}


