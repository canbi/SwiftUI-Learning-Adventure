//
//  Prospect.swift
//  HotProspects
//
//  Created by Can Bi on 19.02.2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var addedDate = Date.now
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published  private(set) var people: [Prospect]
    let fileManager = LocalFileManagerJSON(folderName: "Prospects_Folder", appFolder: .documentDirectory)
    let saveKey = "SavedData"

    init() {
        //Load from UserDefaults
        /*
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }*/
        
        //Load from Documents folder
        if let data =  fileManager.getJSON(name: saveKey, dataType: [Prospect()]) {
            people = data
            return
        }
        
        people = []
    }
    
    private func save() {
        //Save to UserDefaults
        /*
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }*/
        
        //Save to Documents folder
        fileManager.saveJSON(name: saveKey, data: people)
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func sortName(isAsc: Bool){
        if isAsc{
            people.sort { $0.name < $1.name }
        }
        else {
            people.sort { $0.name > $1.name }
        }
    }
    
    func sortDate(isAsc: Bool){
        if isAsc{
            people.sort { $0.addedDate < $1.addedDate }
        }
        else {
            people.sort { $0.addedDate > $1.addedDate }
        }
    }
    
    func sortEmail(isAsc: Bool){
        if isAsc{
            people.sort { $0.emailAddress < $1.emailAddress }
        }
        else {
            people.sort { $0.emailAddress > $1.emailAddress }
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
