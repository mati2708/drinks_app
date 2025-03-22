 Drinks App

## Opis aplikacji

Drinks App to aplikacja mobilna stworzona w Flutterze, która umożliwia użytkownikom przeglądanie, wyszukiwanie i oznaczanie drinków jako ulubione. Aplikacja korzysta z zewnętrznego API (Solvro Cocktails API) do pobierania przepisów koktajli i składników.

## Funkcjonalności

- **Lista Drinków**: Użytkownicy mogą przeglądać pełną listę dostępnych drinków z ich zdjęciem i nazwą.

- **Wyszukiwanie**: Umożliwia wyszukiwanie drinków po nazwie, co pozwala na szybkie znajdowanie ulubionych pozycji.

- **Ulubione Drinki**: Użytkownicy mogą oznaczać drinki jako ulubione, co pozwala na łatwiejszy dostęp do często wybieranych koktajli. Status ulubionych jest zapisywany w lokalnej pamięci urządzenia.

- **Szczegóły Drinków**: Po kliknięciu w drink, użytkownik zostaje przekierowany do ekranu z szczegółowymi informacjami, takimi jak kategoria, rodzaj szkła, lista składników oraz instrukcja przygotowania.

- **Responsywność**: Aplikacja jest responsywna i dostosowuje się do różnych rozmiarów ekranów, w tym telefonów i tabletów.

- **Obsługa Ciemnego Motywu**: Aplikacja obsługuje ciemny i jasny motyw, które można przełączać w AppBarze na ekranie głównym aplikacji.

## Technologie

- Flutter
- Dart
- API 

## Instalacja

1. Sklonuj repozytorium.
2. Uruchom `flutter pub get`, aby zainstalować wymagane pakiety.
3. Uruchom aplikację używając `flutter run`.

## Zrzuty ekranu

### Ekran główny aplikacji(motyw jasny)
![Screenshot 1](assets/screenshots/bright_theme.png)

### Ekran główny aplikacji(motyw ciemny)
![Screenshot 2](assets/screenshots/dark_theme.png)

### Filtrowanie polubionych drinków
![Screenshot 3](assets/screenshots/favorites_drinks_list.png)

### Szukanie drinka po nazwie
![Screenshot 4](assets/screenshots/search_drinks_by_name.png)

### Ekran szczegółów drinka
![Screenshot 5](assets/screenshots/drink_detail_screen.png)

