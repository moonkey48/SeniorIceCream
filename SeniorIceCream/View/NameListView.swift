//
//  NameList.swift
//  SeniorIceCream
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

struct NameListView: View {
    @ObservedObject private var seniorObservable = SeniorListObservable()
    @State private var newMememberName = ""
    @State private var selectedSenior = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if selectedSenior.isEmpty {
                    Spacer()
                        .frame(height: 30)
                } else {
                    Text(selectedSenior)
                }
                
                ForEach(seniorObservable.userList, id: \.self) { memerName in
                    
                    Text(memerName)
                }
                HStack {
                    TextField(text: $newMememberName) {
                        Text("Type your name 🍨")
                    }
                    Button {
                        seniorObservable.addNewMemeber(newMememberName)
                        newMememberName = ""
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                Button {
                    seniorObservable.findSenior()
                } label: {
                    Text("Who is Senior?")
                }

            }
            .padding()
        }
    }
}


struct NameListView_Previews: PreviewProvider {
    static var previews: some View {
        NameListView()
    }
}
