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
    @State private var selectedTo = "k"
    @State private var fromValue = 0.0
    
    @FocusState private var  keyboardFocus: Bool
    
    private var kelvinTemp: Double {
        get throws {
            if selectedFrom == "c" {
                return fromValue + 273.15
            }
            if selectedFrom == "f" {
                return (fromValue - 32.0) * (5.0 / 9.0) + 273.15
            }
            if selectedFrom == "k" {
                return fromValue
            }
            throw ConverTempError.TypeNotDefined
        }
    }
    
    private var toValue: Double {
        get throws {
            let kTemp = (try? kelvinTemp) ?? 0.0
            if selectedTo == "c" {
                return kTemp - 273.15
            }
            if selectedTo == "f" {
                return (kTemp - 273.15) * (9.0 / 5.0) + 32
            }
            if selectedTo == "k" {
                return kTemp
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
                    TextField("Enter amount", value: $fromValue, format: .number).keyboardType(.decimalPad)
                        .focused($keyboardFocus)
                }
                Section ("To") {
                    Picker("Select unit", selection: $selectedTo) {
                        ForEach(tempScales, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Temp in \(selectedTo)") {
                    let value = (try? toValue) ?? 0.0
                    Text("\(value, format: .number)")
                }
            }.navigationTitle("ConverTemp")
                .toolbar {
                    if keyboardFocus {
                        Button("Done") {
                            keyboardFocus.toggle()
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
