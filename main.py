import geocoder

class Typology:
    def __init__(self):
        self._typology = []

    def get_typology(self):
        return self._typology

    def set_typology(self, type):
        self._typology.append(type)

class Search:
    def __init__(self, address = None):
        self._address = address

    def get_addr(self):
        return self._address

    def set_addr(self, adrs):
        # Verifying the address should done in this function
        self._address = adrs


class RouteFinder:

    def __init__(self, curr = None, route = None):
        self._curr = curr
        self._search = Search()
        self._typology = Typology()
        self._route = route


    def set_curr(self):
        g = geocoder.ip('me')
        self._curr = g.latlng

    def set_shortest_route(self):
        pass

    def get_shortest_route(self):
        return self._route

    def calc_danger_level(self):
        pass

class Amenities:
    def __init__(self):
        self._amenities = []

    def get_amenities(self):
        return self._amenities

    def set_amenities(self, amenity):
        self._amenities.append(amenity)


class Map:
    def __init__(self):
        self.Map = None
        self.Route = None
        self.Amenities = None
        self.Danger_Level = None

    def get_map(self):
        pass

    def get_amenities(self):
        pass

    def plot_route(self):
        pass

    def get_directions(self):
        pass