//
//  TimerView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 12.11.2024.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var vm = TimerVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("Timer",
                       subtitle: "Introduction",
                       desc: "The Timer continually publishes the updated date and time at an interval you specify.")
            Text("Adjust Interval")
            
            Slider(value: $vm.interval, in: 0.1...3,
                   minimumValueLabel: Image(systemName: "hare"),
                   maximumValueLabel: Image(systemName: "tortoise"),
                   label: { Text("Interval")})
            .padding(.horizontal)
            
            HStack {
                Button("Stop") {
                    vm.stop()
                }
                .frame(maxWidth: .infinity)
                
                Button("Start") {
                    vm.start()
                }
                .frame(maxWidth: .infinity)
            }
            
            List(vm.data, id: \.self) { datum in
                Text(datum)
                    .font(.system(.title, design: .monospaced))
            }
        }
        
        .font(.title)
        .onAppear {
            vm.start()
        }
    }
}


#Preview {
    TimerView()
}

