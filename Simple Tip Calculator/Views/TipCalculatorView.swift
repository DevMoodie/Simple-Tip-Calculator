//
//  TipCalculatorView.swift
//  Simple Tip Calculator
//
//
//

import SwiftUI

struct TipCalculatorView: View {
    @ObservedObject var viewModel: TipCalculatorViewModel
    @State var savedCalculations: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Bill Total
                Text("Bill Total")
                    .font(.callout.smallCaps().bold())
                TextField("0.00", text: $viewModel.billAmount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                // Tip
                Text("Tip")
                    .font(.callout.smallCaps().bold())
                Picker("Tip Percentage", selection: $viewModel.tipPercentage) {
                    ForEach(viewModel.tipPercentages, id: \.self) { percentage in
                        Text("\(percentage)%").tag(percentage)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    // Split of People
                    VStack {
                        Text("Split")
                            .font(.callout.smallCaps().bold())
                        HStack {
                            Image(systemName: "minus.circle.fill")
                                .font(.title)
                                .onTapGesture {
                                    if viewModel.numberOfPeople > 1 {
                                        viewModel.numberOfPeople -= 1
                                    }
                                }
                            Text("\(viewModel.numberOfPeople)")
                                .font(.largeTitle)
                                .padding()
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .onTapGesture {
                                    if viewModel.numberOfPeople <= 50 {
                                        viewModel.numberOfPeople += 1
                                    }
                                }
                        }
                    }
                    
                    Spacer()
                    
                    // Split Total
                    VStack {
                        Text("Split Total")
                            .font(.callout.smallCaps().bold())
                        Text(viewModel.amountPerPersonFormatted)
                            .font(.largeTitle)
                            .padding()
                    }
                    .padding()
                }
                .padding()
                
                // Save the Calculations
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.saveCalculation()
                    }) {
                        Text("Save Calculation")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Tip Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchSavedCalculations()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        savedCalculations.toggle()
                    } label: {
                        Label("Saved Calculations", systemImage: "square.and.arrow.down")
                            .foregroundStyle(.black)
                    }
                }
            }
            .sheet(isPresented: $savedCalculations) {
                NavigationView {
                    List {
                        ForEach(viewModel.savedCalculations, id: \.self) { calculation in
                            VStack(alignment: .leading) {
                                Text("Bill: \(String(format: "$%.2f", calculation.billAmount))")
                                Text("Tip: \(calculation.tipPercentage)%")
                                Text("Tip Amount: \(String(format: "$%.2f", calculation.tipAmount))")
                                Text("Total: \(String(format: "$%.2f", calculation.totalAmount))")
                                if let date = calculation.date {
                                    Text("Date: \(date, formatter: dateFormatter)")
                                } else {
                                    Text("Date: Unknown")
                                }
                            }
                        }
                        .onDelete(perform: viewModel.deleteCalculation)
                    }
                    .navigationTitle("Saved Calculations")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

struct TipCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        TipCalculatorView(viewModel: TipCalculatorViewModel())
    }
}
