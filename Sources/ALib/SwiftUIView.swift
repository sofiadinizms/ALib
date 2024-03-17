//
//  SwiftUIView.swift
//  
//
//  Created by sofiadinizms on 17/03/24.
//

import SwiftUI

@available(macOS 14.0, *)

struct SwiftUIView: View {
    @State var password: String = ""
    
    var body: some View {
        
        
        AHStack{
            AText(text: "Hello!", accessibilityText: "Hello!", isDecorative: false)
            AText(text: "Goodbye!", accessibilityText: "Goodbye!", isDecorative: false)
        }
        
        
        
    }
    
    func example(){
        
    }
}

//#Preview {
//    if #available(macOS 12.0, *) {
//        SwiftUIView()
//    } else {
//        // Fallback on earlier versions
//    }
//}
