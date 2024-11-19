//
//  TryContainsView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 14.11.2024.


/* You have the option to look for items in your pipeline and publish a true for the criteria you specify or publish an error for the condition you set.
   When an item matching your condition is found, a true will then be published and the pipeline will be finished/closed.
   Alternatively, you can throw an error that will pass the error downstream and complete the pipeline with a failure. The subscriber will ultimately receive a true, false, or error and finish. */

import SwiftUI

struct TryContainsView: View {
    @StateObject private var vm = TryContainsVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("TryContains",
                       subtitle: "Introduction",
                       desc: "The tryContains(where: ) operator works like contains(where: ) except now the subscriber can also receive an error in addition to a true or false.")
            Text("Look for Salt Water in:")
            
            Picker("Place", selection: $vm.place) {
                Text("Nevada").tag("Nevada")
                Text("Utah").tag("Utah")
                Text("Mars").tag("Mars")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("Search") {
                vm.search()
            }
            
            Text("Result: \(vm.result)")
        }
        .font(.title)
        .alert(item: $vm.error) { alertData in
            Alert(title: Text("Invalid Selection"))
        }
    }
}

#Preview {
    TryContainsView()
}
