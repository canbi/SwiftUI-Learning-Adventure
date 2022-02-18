//
//  PageView.swift
//  ConversionApp
//
//  Created by Can Bi on 2.07.2021.
//  Updated by Can Bi on 27.01.2022.

import SwiftUI

struct ConversionPageView: View {
    @State private var amountFrom = 0.0
    @State private var typeFrom = 0
    @State private var typeTo = 1
    @FocusState private var amountIsFocused: Bool
    
    var selectionList:[String] = [String]()
    var units:[Dimension] = [Dimension]()
    var typeName: String
    
    var result: Double {
        let input =  Double(amountFrom)
        let fromUnit = Measurement(value: input, unit: units[typeFrom])
        let toConversion = fromUnit.converted(to: units[typeTo])
        return toConversion.value
    }

    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Conversion Type and Value")) {
                    TextField("Value", value: $amountFrom, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section(header: Text("Conversion")) {
                    VStack(alignment: .leading){
                        
                        //Conversion From
                        HStack{
                            Text("From").frame(maxWidth: 50)
                            Picker("\(typeName) Type", selection: $typeFrom) {
                                ForEach(0 ..< selectionList.count) {
                                    Text("\(self.selectionList[$0])")
                                }
                            }
                            .pickerStyle(.menu)
                            
                            Spacer()
                            
                            //Reverse options button
                            Button(action: {
                                swap(&typeFrom,&typeTo)
                            }, label: {
                                Image(systemName: "arrow.up.arrow.down.square")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.gray)
                            })
                        }
                        
                        //Conversion To
                        HStack{
                            Text("To").frame(maxWidth: 50)
                            Picker("\(typeName) Type", selection: $typeTo) {
                                ForEach(0 ..< selectionList.count) {
                                    Text("\(self.selectionList[$0])")
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                }
                //Result
                Section(header: Text("Result")) {
                    Text("\(result.formatted())")
                }
            }
            .navigationTitle("\(typeName) Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionPageView(typeName: "")
    }
}
