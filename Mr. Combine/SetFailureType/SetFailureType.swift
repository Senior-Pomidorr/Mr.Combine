//
//  SetFailureType.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 21.11.2024.
//

import SwiftUI

struct SetFailureType: View {
    @StateObject private var vm = SetFailureTypeVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("SetFailureType",
                       subtitle: "Introduction",
                       desc: "The setFailureType operator can change a type of a publisher by changing its failure type from Never to something else.")
            HStack(spacing: 50) {
                Button("Western") { vm.fetch(condition: true) }
                Button("Eastern") { vm.fetch(condition: false) }
            }
            Text("States")
                .bold()
            List(vm.states, id: \.self) { state in
                Text(state)
            }
        }
        .font(.title)
        .alert(item: $vm.error) { error in
            Alert(title: Text("Error"), message: Text(error.description))
        }
    }
}

#Preview {
    SetFailureType()
}
