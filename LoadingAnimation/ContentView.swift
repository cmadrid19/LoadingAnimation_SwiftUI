//
//  ContentView.swift
//  LoadingAnimation
//
//  Created by Maxim Macari on 29/12/20.
//

import SwiftUI

struct ContentView: View {
    
    let gradient1 = LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .bottomLeading)
    
    let gradient2 = LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.28), Color.blue.opacity(0.28)]), startPoint: .topLeading, endPoint: .trailing)
    
    let rotation: Double = 2
    let animationDuration: Double = 0.75
    
    @State var isAnimation: Bool = false
    @State var circleStart: CGFloat = 0.17
    @State var circleEnd: CGFloat = 0.325
    
    @State var rotationDegree: Angle = Angle.degrees(0)
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(.all, edges: .all)
            
            
            ZStack{
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 20))
                    .fill(gradient2)
                Circle()
                    .trim(from: circleStart, to: circleEnd)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .fill(gradient1)
                    .rotationEffect(self.rotationDegree)
            }
            .frame(width: 200, height: 200)
            .onAppear() {
                self.animateLoader()
                Timer.scheduledTimer(withTimeInterval: self.rotation * self.animationDuration + self.animationDuration, repeats: true) { (mainTimer) in
                    self.animateLoader()
                }
            }
        }
    }
    
    func animateLoader(){
        
        withAnimation(Animation.spring(response: animationDuration * 2)) {
            self.rotationDegree = .degrees(-57.5)
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.rotation * self.animationDuration)) {
                self.rotationDegree += self.getRotationAngle()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.25, repeats: false) { _ in
            withAnimation(Animation.easeOut(duration: (self.rotation * self.animationDuration) / 2.25)) {
                self.circleEnd = 0.925
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: rotation * animationDuration, repeats: false) { _ in
            self.rotationDegree = .degrees(47.5)
            withAnimation(Animation.easeOut(duration: self.animationDuration)) {
                self.circleEnd = 0.325
            }
        }
        
    }
    
    func getRotationAngle() -> Angle {
        return .degrees(360 * self.rotation) + .degrees(120)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

