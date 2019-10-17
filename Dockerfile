FROM rocker/geospatial:3.6.0

LABEL maintainer="Cole Brokamp <cole.brokamp@gmail.com>"

RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), prompt='R > ', download.file.method = 'libcurl')" > /.Rprofile

RUN R -e "devtools::install_version(package = 'argparser', version = '0.4', upgrade = FALSE, quiet = TRUE)"

RUN mkdir /app
COPY . /app

WORKDIR /tmp

ENTRYPOINT ["/app/_roadway_distance_and_length.R"]
