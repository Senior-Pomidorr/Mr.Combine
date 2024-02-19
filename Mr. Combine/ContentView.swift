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
                TextField("name", text: $vm.name)                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(vm.validation)
            }
            .padding()
            Button("Cancel Subscription") {                
                vm.validation = ""
                vm.cancellable?.cancel()
            }
        }
        .font(.title)
        
    }
}

#Preview {
    ContentView()
}
