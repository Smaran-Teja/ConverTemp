//
//  ContentView.swift
//  ConverTemp
//
//  Created by Smaran Teja on 15/05/24.
//

import SwiftUI

struct ContentView: View {
    let tempScales = ["f", "c", "k"]
    
    @State private var selectedFrom = "c"
    @State private var selectedTo = "c"
    @State private var amt = 0.0
    
    @FocusState private var  fromUnitFocus: Bool
    
    var body: some View {
        NavigationStack{
            Form{
                Section ("From") {
                    Picker("Select unit", selection: $selectedFrom) {
                        ForEach(tempScales, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Amount") {
                    TextField("Enter amount", value: $amt, format: .number).keyboardType(.decimalPad)
                        .focused($fromUnitFocus)
                }
                Section ("To") {
                    Picker("Select unit", selection: $selectedTo) {
                        ForEach(tempScales, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
