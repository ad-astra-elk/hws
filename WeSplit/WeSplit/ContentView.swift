//
//  ContentView.swift
//  WeSplit
//
//  Created by Miguel Rodriguez on 3/9/25.
//

import SwiftUI

struct ContentView: View {
    
    // Swift view are a function of their state...
    // That is to say... when the state changes, the views are recreated with the appropriate state data
    
    
    // In SwiftUI, "views are a function of their state", it means
    // The UI is derived from the current state, and any change in state triggers a view update
    
    
    @State private var checkAmount = 0.0 // Default value
    @State private var numberOfPeople = 2 // Deault value
    @State private var tipPercentage = 20  // Default value
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount:", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)// Get the users current Locale.. determine their currency, if there's none, default to USD
                    
                    //"Amount is the placeholder text - we might not see it because of the placeholder value
                    
                    // Because we've defined 'checkAmount' as a @State, our app is watching for its value and when it changes, we recreate the view
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                    
                }
                
                Section ("How much do you want to tip?") {
                    Picker ("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)   // Gives the narrow selection
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code:
                                                            Locale.current.currency?.identifier ?? "USD"))
                }
            }.navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

// This is used by XCode so it can show a preview of our design
#Preview {
    ContentView()
}
