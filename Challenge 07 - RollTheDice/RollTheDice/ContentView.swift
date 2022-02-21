//
//  ContentView.swift
//  RollTheDice
//
//  Created by Can Bi on 21.02.2022.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var engine: CHHapticEngine?
    @State private var diceType: DiceKind = DiceKind.side6
    @State private var result: Int?
    @State private var resultHistory: [RollResult] = [RollResult]()
    @State private var filteredHistory: [RollResult] = [RollResult]()
    @State private var colorOfResult: Color = .primary
    @State private var showingStats: Bool = false
    @State private var showingHistory: Bool = false
    
    @State private var timeRemaining = 0.0
    static let timerGap = 0.1
    @State private var isActive = true
    let timer = Timer.publish(every: timerGap, on: .main, in: .common).autoconnect()
    
    let fileManager = LocalFileManagerJSON(folderName: "Dice_Result_Folder", appFolder: .documentDirectory)
    private let saveKey: String = "DiceResult"
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("Select your dice type", selection: $diceType) {
                        ForEach(DiceKind.allCases) { dice in
                            Text("\(dice.rawValue)")
                        }
                    }
                    .onChange(of: diceType) { _ in filterHistory() }
                }
                
                Section(header: Text("Result")) {
                    HStack{
                        Group{
                            if let result = result {
                                Text("\(result)")
                                    .foregroundColor(colorOfResult)
                                    .font(.title)
                            } else {
                                Text("You have not roll the dice yet")
                                    .font(.body)
                            }
                        }
                        .accessibilityHidden(isActive)
                        
                        Spacer()
                        
                        Button("Roll"){
                            roll()
                            complexSuccess()
                        }
                    }
                }
                
                Section(header: Text("Statistics of \(diceType.rawValue)")) {
                    Toggle("Show Statistics", isOn: $showingStats.animation())
                    
                    if showingStats {
                        Text("Total:").bold()
                        + Text("  \(filteredHistory.count)")
                        
                        ForEach((1...diceType.rawValue), id: \.self) { number in
                            Text("Occurrence of \(number):").bold()
                            + Text("  \(filteredHistory.filter{ $0.result == number}.count)")
                        }
                    }
                }
                
                
                Section(header:Text("History of \(diceType.rawValue)")) {
                    Toggle("Show History", isOn: $showingHistory.animation())
                    
                    if showingHistory {
                        ForEach(filteredHistory) { history in
                            Text("\(history.result)")
                        }
                    }
                }
            }
            .navigationTitle("Roll the Dice")
            .onAppear{
                load()
                filterHistory()
                prepareHaptics()
            }
            .onReceive(timer) { time in
                guard isActive else { return }
                
                if timeRemaining > 0 {
                    timeRemaining -= ContentView.timerGap
                    result = Int.random(in: 1...diceType.rawValue)
                    colorOfResult = .secondary
                }
                else {
                    isActive = false
                    colorOfResult = .primary
                    addHistory()
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    prepareHaptics()
                }
            }
        }
    }
    
    func filterHistory(){
        filteredHistory = resultHistory.sorted(by: { $0.date > $1.date }).filter{$0.dice == diceType }
    }
    
    
    func addHistory(){
        guard let result = result else { return }
        
        let diceResult = RollResult(id: UUID(),
                                    date: Date.now,
                                    dice: diceType,
                                    result: result)
        resultHistory.append(diceResult)
        filterHistory()
        save()
    }
    
    func roll(){
        timeRemaining = 2
        isActive = true
    }
    
    func save(){
        fileManager.saveJSON(name: saveKey, data: resultHistory)
    }
    
    func load(){
        if let data =  fileManager.getJSON(name: saveKey, dataType: [RollResult.example]) {
            resultHistory = data
            return
        }
        
        resultHistory = []
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
