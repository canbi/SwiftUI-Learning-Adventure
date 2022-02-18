//
//  ContentView.swift
//  SomeoneNew
//
//  Created by Can Bi on 15.02.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var fileManager: LocalFileManager
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: true)])
    var personList: FetchedResults<Person>
    
    @State private var inputImage: UIImage?
    
    @State private var showingImagePicker = false
    @State private var showingAddPerson = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(personList, id: \.self.id) { person in
                    NavigationLink {
                        DetailView(person: person)
                    } label: {
                        HStack{
                            if let uiImage = fileManager.getImage(name: person.wrappedPhotoName) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:60, height: 60)
                            }
                            else {
                                Image(systemName: "square.slash.fill")
                                    .frame(width:60, height: 60)
                            }
                            
                            
                            VStack(alignment: .leading){
                                Text(person.wrappedName)
                                Text(person.wrappedDesc).foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: removeItems)
                
                
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .sheet(isPresented: $showingAddPerson) {
                AddPerson(uiImage: inputImage)
            }
            .navigationTitle("Someone New")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {self.showingImagePicker = true},
                           label: {
                        HStack {
                            Image(systemName: "plus.square.fill")
                            Text("Add Photo")
                        }
                    })
                }
            }
            .onChange(of: inputImage) { _ in
                showingAddPerson = true
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            // find this person in our fetch request
            let person = personList[offset]
            
            //delete from documents
            let deleteResult = fileManager.deleteImage(name: person.wrappedPhotoName)
            print(deleteResult)
            
            // delete it from the context
            moc.delete(person)
        }
        
        // save the context
        if moc.hasChanges{
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
