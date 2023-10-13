mapboxgl.accessToken = 'pk.eyJ1IjoicHJhdmVlbjI4IiwiYSI6ImNsbWs0YngwOTA5YjAyc280eWJzdWptOWgifQ.cVTUe_NY8GChWktCpxL_DA';

// Create a Mapbox map
const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v12',
    center: [-85.5872, 42.2917],
    zoom: 10,
    minZoom: 10
});

// Array of predefined amenities
const amenities = [
    // Add more amenities with their coordinates
    // { name: 'Amenity Name', coordinates: [longitude, latitude] },
];

// Add markers for each amenity
amenities.forEach(amenity => {
    const marker = new mapboxgl.Marker()
        .setLngLat(amenity.coordinates)
        .setPopup(new mapboxgl.Popup().setText(amenity.name))
        .addTo(map);
});

// Disable map interaction
map.keyboard.disable();
map.addControl(new mapboxgl.NavigationControl());

const layerList = document.getElementById('menu');
const inputs = layerList.getElementsByTagName('input');

for (const input of inputs) {
    input.onclick = (layer) => {
        const layerId = layer.target.id;
        map.setStyle('mapbox://styles/mapbox/' + layerId);
    };
}

map.addControl(
    new MapboxDirections({
    accessToken: mapboxgl.accessToken
    }),
    'top-right'
    );


map.addControl(
    new mapboxgl.GeolocateControl({
    positionOptions: {
    enableHighAccuracy: true
    },
    // When active the map will receive updates to the device's location as it changes.
    trackUserLocation: true,
    // Draw an arrow next to the location dot to indicate which direction the device is heading.
    showUserHeading: true
    })
    );