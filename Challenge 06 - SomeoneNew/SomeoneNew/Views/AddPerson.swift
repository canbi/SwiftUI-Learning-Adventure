//
//  AddPerson.swift
//  SomeoneNew
//
//  Created by Can Bi on 15.02.2022.
//

import Foundation
import SwiftUI

struct AddPerson: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var fileManager: LocalFileManager
    
    let locationFetcher = LocationFetcher()
    
    var uiImage: UIImage?
    private var image: Image?
    @State private var name = ""
    @State private var description = ""
    @State private var longitude = 28.979530
    @State private var latitude = 41.015137
    @State private var currentLocation = false
    
    @State private var showingMissingError = false
    
    init( uiImage: UIImage?){
        self.uiImage = uiImage
        
        guard let inputImage = uiImage else {
            self.image = nil
            return
        }
        self.image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            
            Form{
                Section{
                    TextField("Name*", text: $name)
                    TextField("Description", text: $description)
                }
                Section(header: Text("Where you meet?")){
                    if currentLocation == false {
                        Button("Add current location") {
                           if let location = self.locationFetcher.lastKnownLocation {
                               longitude = location.longitude
                               latitude = location.latitude
                               currentLocation = true
                               print("Your location is \(location)")
                           } else {
                               print("Your location is unknown")
                           }
                       }
                    }
                    else {
                        Text("Location saved")
                    }
                }
                
                Button("Save", action: savePerson)
            }
        }
        .alert("Missing Part!", isPresented: $showingMissingError) {
            Button("OK") { }
        } message: {
            Text("Name should be given")
        }
        .onAppear {
            self.locationFetcher.start()
        }
    }
    
    func savePerson(){
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showingMissingError = true
            return
        }
        
        let randomPhotoName: String = UUID().uuidString
        
        if let uiImage = uiImage {
            let saveResult = fileManager.saveImage(image: uiImage, name: randomPhotoName)
            print(saveResult)
        }
        
        let tempPerson = Person(context: self.moc)
        tempPerson.id = UUID()
        tempPerson.name = name
        tempPerson.desc = description == "" ? nil : description
        tempPerson.latitude = latitude
        tempPerson.longitude = longitude
        tempPerson.photoName = randomPhotoName
        
        if moc.hasChanges {
            try? self.moc.save()
        }
        
        dismiss()
    }
}
