import SwiftUI

struct EventPreviewView: View {
    let event: Event
    let onDetailsTap: () -> Void
    let onNextTap: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            AsyncImage(url: event.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .overlay {
                        ProgressView()
                    }
            }
            .frame(width: 90, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.name)
                    .font(.headline)
                    .lineLimit(2)
                
                if let date = event.dates?.start?.localDate {
                    Label(date, systemImage: "calendar")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 8) {
                    Button(action: onDetailsTap) {
                        Text("View Details")
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .background(event.color)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Button(action: onNextTap) {
                        Text("Next")
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .background(event.color)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 8)
    }
}
