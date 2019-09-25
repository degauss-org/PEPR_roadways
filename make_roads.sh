# download
wget -r ftp://ftp2.census.gov/geo/tiger/TIGER2018/ROADS/*

# unzip files
mkdir ./all_2018_roads
find . -type f -name "*.zip" -print0 | xargs -0 -I{} unzip {} -d ./all_2018_lines

# delete zipped files
rm -r ftp2.census.gov

mkdir ./TIGER2018_roads
mkdir ./S1200_subset

# merge for each state
for state in $( ls all_2018_lines/ | grep .shp$ | cut -d_ -f3 | cut -b 1,2 | uniq ); do
   find shps/ -type f -name "*_78*" | grep .shp$ | xargs -I{} shapemerger -o ./TIGER2018_lines/TIGER2010_lines_${state}.shp {}
done

# subset all of the shapefiles to each of the road classes
for f in `ls all_2010_lines/ | grep .shp$`; do
    ogr2ogr -where "MTFCC = 'S1200'" S1200_subset/$f all_2018_lines/$f
done

# merge all of these together
shapemerger -o TIGER2018_roads/S1200_roads.shp S1200_subset/*.shp

# delete shp files
rm -r all_2018_lines
rm -r S1200_subset

