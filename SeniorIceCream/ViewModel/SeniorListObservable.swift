//
//  SeniorListObservable.swift
//  SeniorIceCream
//
//  Created by Seungui Moon on 2023/08/21.
//

import Foundation

class SeniorListObservable: ObservableObject {
    @Published var userList: [String] = ["austin", "anne", "joyce", "yong"]
    
    func addNewMemeber(_ newMember: String) {
        userList.append(newMember)
    }
    
    func findSenior(){
        
    }
}
