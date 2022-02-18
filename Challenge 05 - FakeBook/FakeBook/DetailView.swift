//
//  DetailView.swift
//  FakeBook
//
//  Created by Can Bi on 9.02.2022.
//

import SwiftUI

struct DetailView: View {
    var user: User
    var results: [User]
    @State private var friends: [User] = [User]()
    
    var body: some View {
        Form{
            Section(header: Text("Personal Information")){
                HStack{
                    Text("Name\t").bold()
                    Text(user.name)
                }
                HStack{
                    Text("Age\t").bold()
                    Text("\(user.age)")
                }
                HStack{
                    Text("Company\t").bold()
                    Text(user.company)
                }
                HStack{
                    Text("Email\t").bold()
                    Text(user.email)
                }
                VStack(alignment:.leading){
                    Text("Address").bold()
                    Text(user.address)
                }
                VStack(alignment:.leading){
                    Text("About").bold()
                    Text(user.about)
                }
                VStack(alignment:.leading){
                    Text("Tags").bold()
                    Text(ListFormatter.localizedString(byJoining: user.tags.sorted()))
                }.padding(.bottom)
            }
            Section(header: Text("Friends")){
                List(friends.sorted(by: {$0.name < $1.name}), id: \.id){ friend in
                    VStack(alignment: .leading) {
                        Text(friend.name)
                            .font(.headline)
                        Text(friend.company)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .onAppear{
            getFriends()
        }
        .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func getFriends(){
        for friend in user.friends {
            if let foundFriend = results.first(where:{ friend.id == $0.id}){
                friends.append(foundFriend)
            }
        }
    }
}
