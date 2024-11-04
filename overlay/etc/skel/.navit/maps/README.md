# Adding Maps to Navit (Option 1)

Note: Use this approach if you only need offline maps for Navit.

1. Visit [Navit - Planet Extractor](http://maps3.navit-project.org/)

2. Zoom into you desired region.

3. Under "Map Controls," click _select_.

3. With your mouse, define the bounding box for your offline map.

4. Click the _Get map!_ button.

5. Copy the map to user's home directory under: `~/.navit/map/`.

Note: The current Navit configuration specifies the map directory using
      a wildcard (i.e. ~/.navit/map/*.bin). As such, any valid Navit map
      with a `*.bin` extension will automatically be supported.


## Building Maps from Source OSM Data (Option 2)

Note: Use this approach if need offline maps for Navit and YAAC. It will
      can also be used if you plan to run your own OSM tile server in the
      future.

This approach requires that you download the desired `.pbf` OSM files and
generate the binary maps for each application. The process can take a 
considerable amount of time and storage depending on the size of the map.

It is recommended that you limit the source OSM download to your state or
region. As an example, the state of Arizona will be used.

1. Visit [North America](http://download.geofabrik.de/north-america.html).

2. Click _United States of America_ under _Sub Regions_.

3. Download the desired state `.osm.pbf` file (i.e. arizona-latest.osm.pbf)

### Generate Navit Map

1. Generate a `.bin` using `maptool`. This will generate `arizona-lastest.osm.bin`. 
   This can take 5-10 minutes depending on your machine.

```
maptool --protobuf -i arizona-latest.osm.pbf arizona-lastest.osm.bin
```

2. Move the generated `.bin` file to your user's navit map directory.

```
mv arizona-latest.osm.pbf ~/.navit/maps/
```

3. Keep the source `.osm.pbf` as you will need it for the YAAC map import.


### Generate YAAC Map

1. Start YAAC with `et-yaac`.

2. Navigate to _File_ > _OpenStreetMap_ > _Import RAW OSM Map File_.

3. Select the `.osm.pbf` that you downloaded earlier.

4. This will take 5-10 minutes for state-level map files.
