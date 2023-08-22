//
//  NameList.swift
//  SeniorIceCream
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

struct IceCreamView: View {
    @ObservedObject private var seniorObservable = SeniorListObservable()
    @State private var newMememberName = ""
    @State private var alertText = "ICE CREAM 내기를 할 사람을 추가해주세요"
    
    var body: some View {
        
        VStack {
            HeaderTitleView
            
            switch seniorObservable.selectState {
            case .notStated:
                MemberListView
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                    Spacer()
                }
            case .done:
                SeniorResultView
                Button {
                    seniorObservable.selectState = .notStated
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "gobackward")
                            .foregroundColor(.white)
                        Text("Retry")
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
            Spacer()
            AddMemberView
            FindSeniorButtonView
        }
        .padding()
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}
extension IceCreamView {
    var HeaderTitleView: some View {
        Group {
            HStack {
                Text("🧓")
                    .font(.system(size: 70))
                Text("🍦")
                    .font(.system(size: 70))
                Text("💓")
                    .font(.system(size: 70))
                Text("👫")
                    .font(.system(size: 70))
            }
            Text("Senior Buys an Ice Cream")
                .font(.system(size: 25, weight: .black))
                .foregroundColor(.yellow)
        }
    }
    
    var MemberListView: some View {
        Group {
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
                List {
                    ForEach(seniorObservable.userList, id: \.self) { memberName in
                        Text(memberName)
                            .foregroundColor(.gray.opacity(0.8))
                            .font(.system(size: 18, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .padding(.vertical,10)
                    }
                    .onDelete(perform: delete)
                }
                .scrollContentBackground(.hidden)
                .padding(.trailing, 20)

            }
        }
    }
    
    var AddMemberView: some View {
        HStack {
            TextField(text: $newMememberName) {
                Text("영어 이름을 입력해주세요")
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
                if !newMememberName.isEmpty {
                    seniorObservable.addNewMemeber(newMememberName)
                    newMememberName = ""
                }
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
            }
        }
        .padding(.bottom, 10)
    }
    
    var FindSeniorButtonView: some View {
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
    
    var SeniorResultView: some View {
        Group {
            if let senior = seniorObservable.selectedSenior {
                VStack {
                    Spacer()
                    VStack {
                        HStack {
                            Spacer()
                            Text("Senior: \(senior.name)")
                                .foregroundColor(.white)
                                .font(.system(size: 30, weight: .black))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        HStack {
                            Spacer()
                            Text("🍨 Buys an ICE CREAM! 🍧")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .black))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(.yellow)
                    .cornerRadius(10)
                    Spacer()
                }
            } else {
                Text("영어 이름을 입력하지 않으신 분이 계셔서 결과가 나오지 않았어요 😭")
                Spacer()
                    .frame(height: 30)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            seniorObservable.userList.remove(at: first)
        }
    }
}


struct IceCreamView_Previews: PreviewProvider {
    static var previews: some View {
        IceCreamView()
    }
}
