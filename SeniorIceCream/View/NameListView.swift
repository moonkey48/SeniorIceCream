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
    @State private var alertText = "ICE CREAM 내기를 할 사람을 추가해주세요"
    
    var body: some View {
        
        VStack {
            Text("🍦")
                .font(.system(size: 100))
            Text("Senior Buy Ice Cream")
                .font(.system(size: 30, weight: .black))
                .foregroundColor(.yellow)
            if let senior = seniorObservable.selectedSenior {
                Text("\(senior.name) buy ice cream!!")
            } else {
                Spacer()
                    .frame(height: 30)
            }
            
            if seniorObservable.userList.isEmpty {
                HStack {
                    Spacer()
                    Text(alertText)
                        .foregroundColor(.gray.opacity(0.8))
                        .font(.system(size: 16, weight: .semibold))
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .background(.gray.opacity(0.02))
                .cornerRadius(10)
            } else {
                ForEach(seniorObservable.userList, id: \.self) { memerName in
                    HStack {
                        Spacer()
                        Text(memerName)
                            .foregroundColor(.gray.opacity(0.8))
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .background(.gray.opacity(0.02))
                    .cornerRadius(10)
                }
            }
            
            Spacer()
            
            HStack {
                TextField(text: $newMememberName) {
                    Text("이름을 입력해주세요")
                }
                .foregroundColor(.gray)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .background(.gray.opacity(0.02))
                .cornerRadius(10)
                .onSubmit {
                    seniorObservable.addNewMemeber(newMememberName)
                    newMememberName = ""
                }
                
                Button {
                    seniorObservable.addNewMemeber(newMememberName)
                    newMememberName = ""
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.yellow)
                }
            }
            .padding(.bottom, 10)
            Button {
                if seniorObservable.userList.isEmpty {
                    alertText = "아직 인원을 추가하지 않으셨어요"
                } else {
                    seniorObservable.findSenior()
                }
            } label: {
                HStack {
                    Spacer()
                    Text("WHO IS A SENIOR?")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .black))
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .background(.yellow)
                .cornerRadius(10)
            }
        }
        .padding()
        .onTapGesture {
            self.hideKeyboard()
        }
        
    }
}


struct NameListView_Previews: PreviewProvider {
    static var previews: some View {
        NameListView()
    }
}
