FROM ocelotuproar/alpine-java:8 AS build-env

ENV PLANTUML_SERVICE_VERSION 1.1.0

WORKDIR /app
EXPOSE 3000

RUN apk add --update git && \
  git clone --depth=1 -b v$PLANTUML_SERVICE_VERSION https://github.com/bitjourney/plantuml-service /app && \
  ./gradlew build

FROM ocelotuproar/alpine-java:8

WORKDIR /app
RUN apk add --update graphviz
COPY --from=build-env /app/build/libs/plantuml-service.jar /app

CMD java -jar plantuml-service.jar 3000
