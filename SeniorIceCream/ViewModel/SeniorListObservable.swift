//
//  SeniorListObservable.swift
//  SeniorIceCream
//
//  Created by Seungui Moon on 2023/08/21.
//

import Combine
import Foundation

struct Person: Codable {
    var count: Int
    var name: String
    var age: Int?
}
typealias People = [Person]

enum SelectState {
    case notStated
    case loading
    case done
}

class SeniorListObservable: ObservableObject {
    @Published var userList: [String] = []
    @Published var selectedSenior: Person?
    @Published var selectState: SelectState = .notStated
    @Published var nilNameList: [String] = []
    
    func addNewMemeber(_ newMember: String) {
        userList.append(newMember)
    }
    
    func findSenior(){
        self.nilNameList = []
        self.selectedSenior = nil
        selectState = .loading
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
                if let age = person.age {
                    if age > maxAge {
                        maxAge = age
                        senior = person
                    }
                } else {
                    DispatchQueue.main.async {
                        self.nilNameList.append(person.name)
                        print("\(person.name) is nil")
                    }
                }
            }
            print(senior)
            if !self.nilNameList.isEmpty {
                DispatchQueue.main.async {
                    self.selectState = .done
                }
            } else {
                DispatchQueue.main.async {
                    self.selectedSenior = senior
                    self.selectState = .done
                }
            }
            
           }.resume()
    }
    
    func findSeniorWithCombine(){
        selectState = .loading
        var baseURL = "https://api.agify.io?"
        for user in userList {
            baseURL += "name[]=\(user)&"
        }
        baseURL.removeLast()
        guard let url = URL(string: baseURL) else {
          return
        }
        
        let _ = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: People.self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink { data in
                print(data)
                }
    }
}
