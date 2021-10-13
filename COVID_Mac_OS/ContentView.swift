//
//  ContentView.swift
//  COVID_Mac_OS
//
//  Created by Nikolay Nikolayenko on 16/01/2021.
/// https://developer.apple.com/forums/thread/125183
/// https://troz.net/post/2021/swiftui_mac_menus/?utm_campaign=%20SwiftUI%20Weekly&utm_medium=email&utm_source=Revue%20newsletter

import SwiftUI
import SwiftSoup

struct ContentView: View {
   
    @State var a = getStat()
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(Color.white, lineWidth: 3)
                .frame(width: 350, height: 200, alignment: .center)
                .shadow(radius: 6 )
                
            Text("\(a)")
                .font(.title)
                .bold()
                .padding(50)
                .shadow(radius: 4 )
        }
        .background(VisualEffectBackground(material: .fullScreenUI, blendingMode: .behindWindow, emphasized: false))
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 400, height: 300)
    }
}

func getStat() -> String {
    let url = "https://www.worldometers.info/coronavirus/country/israel/"
    guard let myURL = URL(string: url) else {return "no data"}
    
    do {
        let myHTMLString = try? String(contentsOf: myURL, encoding: .utf8)
        let htmlContent = myHTMLString
        
        //print(htmlContent)
        
        do {
            let doc = try? SwiftSoup.parse(htmlContent!)
            let element = try? doc?.select("title").text()
            print(element)
            
            return element!
        }
    }
}


struct VisualEffectBackground: NSViewRepresentable {
    private let material: NSVisualEffectView.Material
    private let blendingMode: NSVisualEffectView.BlendingMode
    private let isEmphasized: Bool
    
     init(
        material: NSVisualEffectView.Material,
        blendingMode: NSVisualEffectView.BlendingMode,
        emphasized: Bool) {
        self.material = material
        self.blendingMode = blendingMode
        self.isEmphasized = emphasized
    }
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        
        // Not certain how necessary this is
        view.autoresizingMask = [.width, .height]
        view.state = .followsWindowActiveState
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
        nsView.isEmphasized = isEmphasized
    }
}

extension View {
    func visualEffect(
        material: NSVisualEffectView.Material,
        blendingMode: NSVisualEffectView.BlendingMode = .behindWindow,
        emphasized: Bool = false
    ) -> some View {
        background(
            VisualEffectBackground(
                material: material,
                blendingMode: blendingMode,
                emphasized: emphasized
            )
        )
    }
}
