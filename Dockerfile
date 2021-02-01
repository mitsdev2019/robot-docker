FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
#COPY run_tests.sh ./

COPY webui.robot .
#RUN wget -q "https://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip" -O /tmp/chromedriver.zip \
   # && unzip /tmp/chromedriver.zip -d /usr/bin/ \
    #&& rm /tmp/chromedriver.zip

#RUN CHROMEDRIVER_VERSION=`wget --no-verbose --output-document - https://chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    ###chmod +x /opt/chromedriver/chromedriver && \
    #ln -fs /opt/chromedriver/chromedriver /usr/local/bin/chromedriver
#ENTRYPOINT [ "bash","run_tests.sh"] 

#CMD [ "robot", "--variable", "BROWSER:chrome", "--outputdir", "results", "webui.robot" ]
CMD [ "robot", "--outputdir", "results", "webui.robot" ]
