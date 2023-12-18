//
//  Registration.swift
//  HotelManzana
//
//  Created by Thilagawathy Duraisamy on 19/12/2023.
//

import Foundation


struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkIn: Date
    var checkOut: Date
    
    var adult: Int
    var chiildren: Int
    
    var wifi: Bool
    var roomType: Room//Roomtype
}

enum Roomtype: String {
    case TwoQueenBed = "Two QueenBed"
    case OneKingBed = "One KingBed"
    case Suite = "Suite"
    
}

struct Room: Equatable {
    var id: Int
    var name: Roomtype
    var shortName: String
    var price: Int
    
    static func == (lhs: Room, rhs: Room) -> Bool {
        return (lhs.id == rhs.id)
        
    }
}


