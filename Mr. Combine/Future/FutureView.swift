//
//  FutureView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 11.11.2024.
//

import SwiftUI

struct FutureView: View {
    @StateObject private var vm = FutureVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("Future",
                       subtitle: "Introduction",
                       desc: "The future publisher will publish one value, either immediately or at some future time, from the closure provided to you.")
                       Button("Say Hello") {
                vm.sayHello()
            }
                       Text(vm.hello)
                .padding(.bottom)
                       Button("Say Goodbye") {
                vm.sayGoodbye()
            }
                       Text(vm.goodbye)
                       Spacer()
                       }
                .font(.title)
                       }
                       }
                       
                       #Preview {
                FutureView()
            }
