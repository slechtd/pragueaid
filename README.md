# PragueAid

<img src="https://github.com/slechtd/pragueaid/blob/master/Pics/ReadMePic.png" width="100%" align="center"/>

**PragueAid** (<a href="https://apps.apple.com/cz/app/pragueaid/id1554479378">AppStore</a>) allows you to explore Prague's pharmacies and medical institutions near you.

Built around **Prague Open Data API**, it gets publicly available GeoJSON featuring pharmacies and medical institutions using a native implementation of **networking**. The fetched GeoJSON is parsed into custom objects. Relying on **MapKit**, these objects are then plotted as MKAnnotaions onto an MKMapView trough conformance to relevant protocols.

Clicking an annotation presents a separate modal view controller that displays detailed information about the location though the use of a sectioned UITableView. The UITableView is constructed dynamically - when certain information (such as opening hours) is unavailable the corresponding section or rows are not displayed. Clicking relevant rows triggers actions such as opening the presented web/phone/mail as URLs or allowing users to navigate to the location's address trough Maps.

Fetched locations can be filtered. Persistence of filter settings is managed trough **UserDefaults**. When disconnected from the interned, locations fetched during the last session are displayed (that are likewise stored in UserDefaults). **Permissions** management with regards to **LocationServices** had been implemented.

The UI is created programmatically using **UIKit**. The app is dark-mode enabled and has been **localized** into both English and Czech. No third-party dependencies are used.
