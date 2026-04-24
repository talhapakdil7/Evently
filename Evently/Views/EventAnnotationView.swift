import SwiftUI

struct EventAnnotationView: View {
    
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(color)
                    .clipShape(Circle())
                    
            }
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundStyle(color)
                .rotationEffect(.degrees(180))
                .offset(y: -4)
                .padding(.bottom, 35)
        }
    }
}
