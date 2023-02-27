FROM hxzqwe/ygopro-server:1.035.2

RUN rm -rf /ygopro-server/config
COPY config /ygopro-server/config

RUN rm -rf /ygopro-server/ygopro/script
COPY 903/script /ygopro-server/ygopro/script
COPY 903/cards.cdb /ygopro-server/ygopro/cards.cdb
COPY 903/lflist.conf /ygopro-server/ygopro/lflist.conf

RUN rm -rf /ygopro-server/ygopro/expansions
COPY expansions /ygopro-server/ygopro/expansions

RUN rm -rf /ygopro-server/windbot
COPY windbot /ygopro-server/windbot
