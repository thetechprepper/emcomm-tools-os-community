# Adding a Map to Navit

1. Visit [Navit - Planet Extractor](http://maps3.navit-project.org/)

2. Zoom into you desired region.

3. Under "Map Controls," click _select_.

3. With your mouse, define the bounding box for your offline map.

4. Click the _Get map!_ button.

5. Copy the map to user's home directory under: `~/.navit/map/`.

Note: The current Navit configuration specifies the map directory using
      a wildcard (i.e. ~/.navit/map/*.bin). As such, any valid Navit map
      with a `*.bin` extension will automatically be supported.


## Loading Larger Maps (OSM)

If you have the storage and want larger maps, it is suggested that you 
use the OpenStreetMap (OSM) extracts from http://download.geofabrik.de/.

Here's the approach used for loading a map for the Southwest region in
the US.

1. Visit [North America](http://download.geofabrik.de/north-america.html).

2. Download the "US West" [.osm.bz2](http://download.geofabrik.de/north-america/us-west-latest.osm.bz2)
   file.

3. Upload `us-west-latest.osm.bz2` to your `~/.navit/maps` directory.

4. Convert the map to a format that Navit can understand. This will take several hours.

```
$ cd ~/.navit/maps
$ time bzcat us-west-latest.osm.bz2 | maptool -6 us-west-latest-osm.bin
```


