//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var vm = FailIntroViewMode()
    @State private var age = ""
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("Fail",
                       subtitle: "Introduction",
                       desc: "The Fail publisher will simply publish a failure with your error and close the pipeline.")
            
            TextField("Enter Age", text: $age)
                .keyboardType(UIKeyboardType.numberPad)                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                vm.save(age: Int(age) ?? -1)
            }
            Text("\(vm.age)")}
        .font(.title)
        .alert(item: $vm.error) { error in
            Alert(title: Text("Invalid Age"), message: Text(error.rawValue))
        }
    }
}

#Preview {
    ContentView()
}
