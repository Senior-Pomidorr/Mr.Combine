//
//  SwitchToLatestView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/12/24.
//

import SwiftUI

struct SwitchToLatestView: View {
    @StateObject private var vm = SwitchToLatest()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("SwitchToLatest",
                           subtitle: "Introduction",
                           desc: "The switchToLatest operator will use only the latest publisher that comes through the pipeline.")

                Button("Clear") {
                        vm.removAll()
                    }
                
                List(vm.names, id: \.self) { value in
                    Button(value) {
                        vm.fetchNameDetails.send(value)
                    }
                }
                .listStyle(.plain)
                
                List(vm.nameResult, id: \.name) { value in
                    HStack {
                        Text(value.name)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        Text("\(value.gender): ")
                        Text(getPercent(value.probability))
                    }
                }
                .listStyle(.plain)
            }
            .font(.title)
        }
    }
    func getPercent(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}

#Preview {
    SwitchToLatestView()
}
