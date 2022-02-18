//
//  ContentView.swift
//  FakeBook
//
//  Created by Can Bi on 9.02.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CachedUser.name, ascending: true)]) var resultsCached: FetchedResults<CachedUser>
    @State private var results = [User]()
    
    var body: some View {
        NavigationView{
            List(results, id: \.id) { user in
                NavigationLink {
                    DetailView(user: user, results: results)
                } label: {
                    HStack(spacing: 20){
                        Image(systemName: user.isActive ? "circle.fill" : "circle")
                            .foregroundColor(user.isActive ? Color.green : Color.red)
                        
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.company)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("FakeBook")
            .task {
                if results.count == 0{
                    await loadData()
                }
            }
            
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else{
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                results = decodedResponse.self
            }
            
            //Save to CoreData if anything changed
            await MainActor.run {
                for user in results {
                    let cachedUser = CachedUser(context: moc)
                    cachedUser.id = user.id
                    cachedUser.name = user.name
                    cachedUser.isActive = user.isActive
                    cachedUser.email = user.email
                    cachedUser.registered = user.registered
                    cachedUser.tags = user.tags.joined(separator: ",")
                    cachedUser.about = user.about
                    cachedUser.company = user.company
                    cachedUser.address = user.address
                    cachedUser.age = Int16(user.age)
                    
                    for friend in user.friends {
                        let cachedFriend = CachedFriend(context: moc)
                        cachedFriend.id = friend.id
                        cachedFriend.name = friend.name
                        cachedUser.addToFriends(cachedFriend)
                    }
                }
                
                if moc.hasChanges {
                    try? self.moc.save()
                }
            }
        } catch {
            //Load from CoreData
            await MainActor.run {
                print("Loaded from CoreData")
                for user in resultsCached {
                    var tempFriends: [Friend] = [Friend]()
                    
                    //TODO user.friendsArray always empty
                    for friend in user.friendsArray {
                        let tempFriend = Friend(id: friend.wrappedId, name: friend.wrappedName)
                        tempFriends.append(tempFriend)
                    }
                    
                    let tempUser = User(id: user.wrappedId,
                                        isActive: user.isActive,
                                        name: user.wrappedName,
                                        age: Int(user.age),
                                        company: user.wrappedCompany,
                                        email: user.wrappedEmail,
                                        address: user.wrappedAddress,
                                        about: user.wrappedAbout,
                                        registered: user.wrappedRegistered,
                                        tags: user.wrappedTags.components(separatedBy:","),
                                        friends: tempFriends)
                    results.append(tempUser)
                }
            }
        }
    }
}
