//
//  User.swift
//  Always-Chatting
//
//  Created by Fernando Tello on 16/04/22.
//

import Foundation

struct User:Codable {
//    @DocumentID var id:String? = UUID().uuidString
    let description: String
    let followers: Int
    let followings:Int
    let name:String
    let path:String
    let quantityPhotos:Int
    let ubic:String
}
