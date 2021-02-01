FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
#COPY run_tests.sh ./

COPY webui.robot .

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get -y update && \
    apt-get install -y google-chrome-stable

RUN wget -q "https://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip" -O /tmp/chromedriver.zip \
   && unzip /tmp/chromedriver.zip -d /usr/bin/ \
   && rm /tmp/chromedriver.zip

ENV DISPLAY=:99

#CMD [ "robot", "--variable", "BROWSER:chrome", "--outputdir", "results", "webui.robot" ]
CMD [ "robot", "--outputdir", "results", "webui.robot" ]
