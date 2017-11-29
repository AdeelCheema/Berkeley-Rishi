var markerGroups = {
    "water": [],
    "women": []
};
var customIcons = {
    women: {
        icon: 'https://www.fuzu.com/assets/fa-map-marker-grey-91117e2bdee2c15f30c08301128072c050af41ddb139b61a813702043e305ca9.png'
    },
    water: {
        icon: 'https://www.fuzu.com/assets/fa-map-marker-grey-91117e2bdee2c15f30c08301128072c050af41ddb139b61a813702043e305ca9.png'
    }
};


function load() {
    map = new google.maps.Map(document.getElementById("map"), {
        center: new google.maps.LatLng(30.560554149332777, 77.52290278673172),
        zoom: 100
    });
    
    var regionCoords = [[]];
    var polygons = []
    
    for (i = 0; i < gon.regions.length; i++) {
        regionCoords[i] = []
        for (var j = 0; j < gon.regions[i].length; j++) {
            regionCoords[i].push({
                lat: gon.regions[i][j][0],
                lng: gon.regions[i][j][1]
            });
        }
        polygons.push(new google.maps.Polygon({
            paths: regionCoords[i],
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: '#FF0000',
            fillOpacity: 0.35
        }));
        polygons[polygons.length-1].setMap(map);
    }

    var infoWindow = new google.maps.InfoWindow();
    var xml = parseXml(xmlStr); // data.responseXML;
    var markers = xml.documentElement.getElementsByTagName("marker");
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0; i < markers.length; i++) {
        var name = markers[i].getAttribute("name");
        var address = markers[i].getAttribute("address");
        var point = new google.maps.LatLng(
        parseFloat(markers[i].getAttribute("lat")),
        parseFloat(markers[i].getAttribute("lng")));
        bounds.extend(point);
        var type = markers[i].getAttribute("type");
        var html = "<b>" + name + "</b> <br/>" + address;
        var icon = customIcons[type] || {};
        var marker = new google.maps.Marker({
            map: map,
            position: point,
            icon: icon.icon
        });
        markerGroups[type].push(marker);
        bindInfoWindow(marker, map, infoWindow, html);
    }
    map.fitBounds(bounds);
}

function bindInfoWindow(marker, map, infoWindow, html) {
    google.maps.event.addListener(marker, 'click', function () {
        infoWindow.setContent(html);
        infoWindow.open(map, marker);
    });
}

function downloadUrl(url, callback) {
    var request = window.ActiveXObject ? new ActiveXObject('Microsoft.XMLHTTP') : new XMLHttpRequest;
    request.onreadystatechange = function () {
        if (request.readyState == 4) {
            request.onreadystatechange = doNothing;
            callback(request, request.status);
        }
    };
    request.open('GET', url, true);
    request.send(null);
}

function toggleGroup(type) {
    for (var i = 0; i < markerGroups[type].length; i++) {
        // alert(markerGroups[type][i]);
        var marker = markerGroups[type][i];
        if (!marker.getVisible()) {
            marker.setVisible(true);
        } else {
            marker.setVisible(false);
        }
    }
}
google.maps.event.addDomListener(window, 'load', load);

function parseXml(str) {
    if (window.ActiveXObject) {
        var doc = new ActiveXObject('MicrosoftXMLDOM');
        doc.loadXML(str);
        return doc;
    } else if (window.DOMParser) {
        return (new DOMParser).parseFromString(str, 'text/xml');
    }
}

var xmlStr = '<markers><marker name="water1" address="" lat="30.560554149332777" lng="77.52290278673172" type="water"/><marker name="women1" address="" lat="30.57" lng="77.524" type="women"/></markers>';