import SwiftUI

struct EventDetailView: View {
    let event: Event
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                
                AsyncImage(url: event.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray5))
                        .overlay {
                            ProgressView()
                        }
                }
                .frame(height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(event.name)
                        .font(.title2.bold())
                        .lineLimit(3)
                    
                    Text(event.venueName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                VStack(spacing: 10) {
                    if let date = event.dates?.start?.localDate {
                        DetailRow(
                            icon: "calendar",
                            title: "Date",
                            value: date
                        )
                    }
                    
                    if let time = event.dates?.start?.localTime {
                        DetailRow(
                            icon: "clock",
                            title: "Time",
                            value: time
                        )
                    }
                    
                    DetailRow(
                        icon: "mappin.and.ellipse",
                        title: "Venue",
                        value: event.venueName
                    )
                }
                
                if let urlString = event.url,
                   let url = URL(string: urlString) {
                    Link(destination: url) {
                        Text("Open Event Page")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.primary)
                    .controlSize(.large)
                    .padding(.top, 6)
                }
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(.secondary)
                .frame(width: 28)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(value)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
