import SwiftUI
import MapKit

struct EventMapView: View {
    
    @State private var viewModel = EventViewModel()
    @StateObject private var locationManager = LocationManager()
    
    @State private var selectedEvent: Event?
    @State private var sheetEvent: Event?
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 36.8841, longitude: 30.7056),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    )
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                UserAnnotation()
                
                ForEach(eventsWithLocation) { event in
                    if let coordinate = event.coordinate {
                        Annotation(event.name, coordinate: coordinate) {
                            EventAnnotationView(
                                icon: event.iconName,
                                color: event.color
                            )
                            .onTapGesture {
                                selectEvent(event)
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            VStack {
                header
                
                Spacer()
                
                if let selectedEvent {
                    EventPreviewView(
                        event: selectedEvent,
                        onDetailsTap: {
                            sheetEvent = selectedEvent
                        },
                        onNextTap: {
                            nextEvent()
                        }
                    )
                    .padding()
                }
            }
            .padding(.top, 12)
        }
        .sheet(item: $sheetEvent) { event in
            EventDetailView(event: event)
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .onChange(of: locationManager.location) { _, newLocation in
            guard let loc = newLocation else { return }
            
            moveCamera(to: loc, zoom: 0.3)
            viewModel.fetchEvents(lat: loc.latitude, lon: loc.longitude)
        }
    }
    
    private var eventsWithLocation: [Event] {
        viewModel.events.filter { $0.coordinate != nil }
    }
    
    private var header: some View {
        HStack {
            Text(selectedEvent?.name ?? "Select an event")
                .font(.title2.bold())
                .lineLimit(1)
            
            Spacer()
            
            Image(systemName: "mappin.and.ellipse")
                .font(.headline)
        }
        .padding()
        .frame(height: 70)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .padding(.horizontal)
    }
    
    private func selectEvent(_ event: Event) {
        selectedEvent = event
        
        guard let coordinate = event.coordinate else { return }
        moveCamera(to: coordinate, zoom: 0.01)
    }
    
    private func nextEvent() {
        guard !eventsWithLocation.isEmpty else { return }
        
        guard let selectedEvent,
              let currentIndex = eventsWithLocation.firstIndex(where: { $0.id == selectedEvent.id }) else {
            selectEvent(eventsWithLocation[0])
            return
        }
        
        let nextIndex = (currentIndex + 1) % eventsWithLocation.count
        let nextEvent = eventsWithLocation[nextIndex]
        
        selectEvent(nextEvent)
    }
    
    private func moveCamera(to coordinate: CLLocationCoordinate2D, zoom: Double) {
        withAnimation(.easeInOut) {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: zoom,
                        longitudeDelta: zoom
                    )
                )
            )
        }
    }
}
