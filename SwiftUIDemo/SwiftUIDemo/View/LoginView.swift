//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Administrator on 05/07/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel(networkmanager: NetworkManagerFactory.create())
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("username", text: $viewModel.user.username)
                        .accessibilityIdentifier("usernameTxtFd")
                        
                    TextField("password", text: $viewModel.user.password)
                        .accessibilityIdentifier("passwordTxtFd")
                    
                    Button {
                        viewModel.login()
                    } label: {
                        HStack{
                            Spacer()
                            Text("Login").accessibilityIdentifier("loginBtn")
                            Spacer()
                        }
                    }

                    Text(viewModel.errorMessage).accessibilityIdentifier("messageTxt")
                }
                
                NavigationLink(isActive: .constant(viewModel.loginStatus == .authenticated)) {
                    HomeView()
                } label: {
                    EmptyView()
                }

            }
            .navigationBarTitle(Text("Login"))
            
        }
        .onAppear {
            viewModel.reset()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
