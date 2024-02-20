//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var vm = YourFirstPipeline()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("First Pipeline",                       
                       subtitle: "With Sink",
                       desc: "The validation is now being assigned using the sink subscriber.                               This allows you to cancel the subscription any time you would                               like.")
            HStack {
                TextField("name", text: $vm.firstName)                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(vm.firstValidationName)
            }
            .padding()
            
            HStack {
                TextField("last name", text: $vm.secondName)        .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(vm.secondValidationName)
            }
            .padding()
            
            Button("Cancel Subscription") {
                vm.status = ""
                vm.cancelAllValidations()
            }
        }
        .font(.title)
        
    }
}

#Preview {
    ContentView()
}
