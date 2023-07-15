//
//  HomeView.swift
//  SwiftUIDemo
//
//  Created by Administrator on 05/07/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text("HOME SCREEN").fontWeight(.bold).foregroundColor(.blue)
                    Spacer()
                }
                Spacer()
            
           
                    .navigationTitle(Text("Home"))
    }
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
