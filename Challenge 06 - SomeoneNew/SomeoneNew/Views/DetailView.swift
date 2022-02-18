//
//  DetailView.swift
//  SomeoneNew
//
//  Created by Can Bi on 18.02.2022.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var fileManager: LocalFileManager
    var person: Person
    
    var body: some View {
        VStack{
            if let uiImage = fileManager.getImage(name: person.wrappedPhotoName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(maxWidth: 250, maxHeight: 250)
            }
            else {
                Image(systemName: "square.slash.fill")
                    .frame(width:44, height: 44)
            }
            
            Spacer().frame(height: 30)
            
            HStack{
                VStack(alignment: .leading){
                    Text("Name").bold()
                    Text("\(person.wrappedName)")
                    Spacer().frame(height:10)
                    Text("Description:").bold()
                    Text("\(person.wrappedDesc)")
                }
                Spacer()
            }.padding(.horizontal, 40)
            

            Spacer()
        }
        
    }
}
