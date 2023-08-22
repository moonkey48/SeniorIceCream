//
//  SeniorListObservable.swift
//  SeniorIceCream
//
//  Created by Seungui Moon on 2023/08/21.
//

import Foundation

struct Person: Codable {
    var count: Int
    var name: String
    var age: Int
}
typealias People = [Person]

class SeniorListObservable: ObservableObject {
    @Published var userList: [String] = []
    @Published var selectedSenior: Person?
    
    func addNewMemeber(_ newMember: String) {
        userList.append(newMember)
    }
    
    func findSenior(){
        var baseURL = "https://api.agify.io?"
        for user in userList {
            baseURL += "name[]=\(user)&"
        }
        baseURL.removeLast()
        guard let url = URL(string: baseURL) else {
          return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error on data check")
                return
            }
            guard let peopleResponse = try? JSONDecoder().decode(People.self, from: data) else {
                print("decoding error")
                return
            }
            var senior: Person?
            var maxAge = 0
            peopleResponse.forEach{ person in
                if person.age > maxAge {
                    maxAge = person.age
                    senior = person
                }
            }
            guard let senior = senior else {
                return
            }
            
            DispatchQueue.main.async {
                self.selectedSenior = senior
            }
            
           }.resume()
    }
}
