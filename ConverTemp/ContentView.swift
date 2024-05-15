//
//  ContentView.swift
//  ConverTemp
//
//  Created by Smaran Teja on 15/05/24.
//

import SwiftUI


enum ConverTempError: Error {
    case TypeNotDefined
}
struct ContentView: View {
    let tempScales = ["f", "c", "k"]
    
    @State private var selectedFrom = "c"
    @State private var selectedTo = "c"
    @State private var value = 0.0
    
    @FocusState private var  fromUnitFocus: Bool
    
    private var kelvinTemp: Double {
        get throws {
            if selectedFrom == "c" {
                return value + 273.15
            }
            if selectedFrom == "f" {
                return (value - 32.0) * (5.0 / 9.0) + 273.15
            }
            if selectedFrom == "k" {
                return value
            }
            throw ConverTempError.TypeNotDefined
        }
    }
    
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
                Section("Value in \(selectedFrom)") {
                    TextField("Enter amount", value: $value, format: .number).keyboardType(.decimalPad)
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
