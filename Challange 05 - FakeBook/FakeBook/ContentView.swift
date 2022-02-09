//
//  ContentView.swift
//  FakeBook
//
//  Created by Can Bi on 9.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [User]()
    
    var body: some View {
        NavigationView{
            List(results, id: \.id) { user in
                NavigationLink {
                    DetailView(user:user, results: results)
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
        } catch {
            print("Invalid data")
        }
    }
}
