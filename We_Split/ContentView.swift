//
//  ContentView.swift
//  We_Split
//
//  Created by Bogdan Patynski on 2022-04-19.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10,15,20,25,0]

    var tipIsZero: Bool {
        if tipPercentage == 0 {
            return true
        } else {
            return false
        }
    }

    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalWithTip: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var dollarFormat: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currencyCode ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code:currencyCode )
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: dollarFormat)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)

                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2 ..< 100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("How much tip do you want to leave?")
                    }
                    Section {
                        Text(totalPerPerson, format: dollarFormat)
  
                    } header: {
                        Text("Amount per person")
                    }
                    Section {
                        Text(totalWithTip, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(tipIsZero ? .red : .blue)
                    } header: {
                        Text("Total With Tip").foregroundColor(tipIsZero ? .red : .blue)
                    }
                    
                }
                    
                }.navigationTitle("WeSplit")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

