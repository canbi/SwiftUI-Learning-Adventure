//
//  DetailView.swift
//  SomeoneNew
//
//  Created by Can Bi on 18.02.2022.
//

import MapKit
import SwiftUI

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct DetailView: View {
    @EnvironmentObject var fileManager: LocalFileManager
    var person: Person
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
                                       span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
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
            
            Map(coordinateRegion: $mapRegion,
                annotationItems: [CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)]) { location in
                MapAnnotation(coordinate: location) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text("You met here")
                            .fixedSize()
                    }
                }
            }
            .ignoresSafeArea()
        }
        .onAppear{
            self.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude),
                                           span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        }
        
    }
}
