# Evently — Harita Tabanlı Etkinlik Keşif Uygulaması

<p align="center">
  <img src="screenshots/icon.png" width="500" height="200" alt="Evently Icon" style="border-radius: 22px;"/>
</p>

<p align="center">
  <strong>Yakındaki etkinlikleri keşfet. Haritada anında gör.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%2017+-black?logo=apple" alt="Platform"/>
  <img src="https://img.shields.io/badge/Swift-6.0-F05138?logo=swift" alt="Swift"/>
  <img src="https://img.shields.io/badge/UI-SwiftUI-0070C9?logo=swift" alt="SwiftUI"/>
  <img src="https://img.shields.io/badge/Map-MapKit-34C759" alt="MapKit"/>
  <img src="https://img.shields.io/badge/API-Ticketmaster-1E90FF" alt="API"/>
</p>

---

## Hakkında

**Evently**, SwiftUI ile geliştirilmiş modern bir iOS harita uygulamasıdır. Kullanıcının konumunu alır ve çevresindeki etkinlikleri harita üzerinde gerçek zamanlı olarak gösterir.

Uygulama, etkinlik verilerini Ticketmaster API üzerinden çeker ve kullanıcıya konum bazlı keşif deneyimi sunar.
Scre

- **Konum bazlı keşif** — Kullanıcının bulunduğu konuma göre etkinlikler
- **Gerçek zamanlı veri** — API üzerinden canlı etkinlik akışı
- **Harita deneyimi** — Etkinlikleri doğrudan map üzerinde görüntüleme
- **Minimal ve hızlı** — Sade arayüz + performans odaklı yapı
- **Modern iOS mimarisi** — SwiftUI + MVVM

---

## Ekran Görüntüleri

<p align="center">
  <img src="screenshots/map.png" width="180" alt="Map"/>
  <img src="screenshots/event.png" width="180" alt="Event Preview"/>
  <img src="screenshots/detail.png" width="180" alt="Event Detail"/>
</p>

---

## Özellikler

### Harita — Ana Ekran
- Kullanıcının anlık konumu haritada gösterilir
- Yakındaki etkinlikler pin (annotation) olarak işaretlenir
- Harita hareket ettikçe yeni etkinlikler yüklenir
- Custom annotation view ile görsel iyileştirme

### Etkinlik Önizleme
- Harita üzerinde seçilen etkinlik alt kartta gösterilir
- Etkinlik adı, tarih ve kısa bilgi
- Detay sayfasına geçiş

### Etkinlik Detayı
- Etkinlik görseli ve detaylı açıklama
- Lokasyon bilgisi (venue + city)
- Etkinlik linki ile dış kaynağa yönlendirme

---

## Mimari

Proje, **MVVM + Service Layer** mimarisi kullanılarak geliştirilmiştir.

