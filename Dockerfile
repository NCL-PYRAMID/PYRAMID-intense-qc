###############################################################################
# Base image - Python 3.9
###############################################################################
FROM ubuntu:20.04

###############################################################################
# Installation variables
###############################################################################
ARG APP_HOME=/src

###############################################################################
# Anaconda set up
# See: https://pythonspeed.com/articles/activate-conda-dockerfile/
###############################################################################

# Relevant environment variables. conda needs to be added to the PATH
# environment variable so subsequent conda commands work
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# To stop R installation from asking questions
ENV DEBIAN_FRONTEND=noninteractive

# Update apt installations
RUN apt update --fix-missing
RUN apt install wget -y
RUN apt upgrade -y

# Get and install Anaconda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh -O ~/anaconda.sh
RUN /bin/bash ~/anaconda.sh -b -p /opt/conda
RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
RUN conda update -y -n base -c defaults conda

# Use conda and strict channel priority (setup ~/.condarc for this)
# This is needed for wradlib to install properly
RUN echo -e \
"channel_priority: strict\n\
channels:\n\
  - conda-forge\n\
  - defaults" > ~/.condarc

# Create conda environment and set the shell to make sure all
# commands are run within it
WORKDIR $APP_HOME
COPY environment.yml .
RUN conda env create -f environment.yml
SHELL ["conda", "run", "-n", "intense-qc", "--no-capture-output", "/bin/bash", "-c"]

# Update R (need some R packages to use intense-qc)
RUN apt install r-base -y
RUN Rscript -e 'install.packages("trend", repos="https://cloud.r-project.org")'

#WORKDIR $APP_HOME/static
#RUN wget https://github.com/nclwater/intense-qc/archive/refs/tags/v0.2.0.tar.gz
#RUN gzip -d v0.2.0.tar.gz
#RUN tar v0.2.0.tar

WORKDIR $APP_HOME
COPY intense_qc.ipynb ./
COPY write_output_metadata.py ./
COPY run.sh ./
COPY static ./static

# Produce the Python file from the Notebook. We could run this directly using
# the --execute flag in run.sh
RUN jupyter nbconvert --to python intense_qc.ipynb

#RUN python -m pip install --upgrade pip
#RUN python -m pip install -r requirements.txt

# Entry point
ENV INTENSE_QC_ENV=docker
WORKDIR $APP_HOME
CMD ["conda", "run", "-n", "intense-qc", "--no-capture-output", "/bin/bash", "run.sh"]
