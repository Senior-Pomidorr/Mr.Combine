//
//  MaxView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 17.11.2024.
//

import SwiftUI

struct MaxView: View {
    @StateObject private var vm = MaxVM()
    @State private var textValue  = ""
    @State private var numberValue  = ""
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("Max",
                       subtitle: "Introduction",
                       desc: "The max operator will publish the maximum value once the upstream publisher is finished.")
            .layoutPriority(1)
            List {
                Section(footer: Text("Max: \(vm.maxString)").bold()) {
                    ForEach(vm.dataString, id: \.self) { datum in
                        Text(datum)
                    }
                }
                
                Divider()
                    .background(.black)
                
                Section(footer: Text("Max: \(vm.maxNumber)").bold()) {
                    ForEach(vm.dataNumberes, id: \.self) { number in
                        Text("\(number)")
                    }
                }
            }
            .listStyle(.plain)
        }
        .font(.title)
        .onAppear {
            vm.fetch()
        }
    }
}

#Preview {
    MaxView()
}
