//
//  SinkReciveValue.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/10/24.
//

import SwiftUI

struct SinkReciveValue: View {
    @StateObject private var vm = SinkReceiveVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Sink",
                           subtitle: "Introduction",
                           desc: "«The sink subscriber allows you to access every value that comes down the pipeline and do something with it.")
                Button("Add name") {
                    vm.fetch()
                }
                .padding(.horizontal)
                
                Button("Clear names") {
                    vm.clear()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("A to M")
                        .frame(maxWidth: .infinity)
                    Text("N to Z")
                        .frame(maxWidth: .infinity)
                }
                
                HStack {
                    List(vm.aToM, id: \.self) { value in
                        Text(value)
                    }
                    List(vm.nToz, id: \.self) { value in
                        Text(value)
                    }
                }
                Spacer(minLength: 0)
            }
            .font(.title)
        }
    }
}

#Preview {
    SinkReciveValue()
}
