//
//  BreakpointView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/20/24.
//

import SwiftUI

struct BreakpointView: View {
    @StateObject private var vm = BreakpointVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Breakpoint",
                           subtitle: "Introduction",
                           desc: "The tryCatch operator will work just like catch but also allow you to throw an error within the closure.")
                
                List(vm.dataToView, id: \.self) { value in
                    Text(value)
                }
                .listStyle(.plain)
                .padding(.horizontal)
            }
            .font(.title)
            .onAppear() {
                vm.fetch()
            }
        }
    }
}

#Preview {
    BreakpointView()
}
