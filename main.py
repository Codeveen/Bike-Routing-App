class Typology:

    def get_typology(self):
        pass

class Search:

    def get_addr(self):
        pass

    def verify_addr(self):
        pass

class LookupAddress:

    def __init__(self):
        self.Starting_point = None
        self.Destination = Search()
        self.Typology = None


    def get_curr_location(self):
        pass

    def shortest_route(self):
        pass

    def calc_danger_level(self):
        pass

class Amenities:

    def get_amenities(self):
        pass

    def get_amenity_addr(self):
        pass

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