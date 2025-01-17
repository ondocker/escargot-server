FROM alpine/git AS clone

RUN git clone --depth 1 https://gitlab.com/escargot-chat/server.git /escargot

FROM python:3

COPY --from=clone /escargot /escargot-server

COPY requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

ENV PYTHONPATH="/escargot-server:.:$PYTHONPATH"

ENV PATH="/escargot-server:/escargot-server/script:$PATH"

# MSN Messenger
EXPOSE 1863 1864

# Yahoo Messenger
EXPOSE 20 23 25 119 5050 5100 8001 8002 

# IRC
EXPOSE 6667

WORKDIR /data

CMD ["python", "/escargot-server/run_all.py"]