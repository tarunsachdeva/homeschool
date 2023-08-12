//
//  SplashScreenView.swift
//  HomeSchool
//
//  Created by Tarun Sachdeva on 2023-08-12.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        Image("SplashImage") // The name you gave in the Assets
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
