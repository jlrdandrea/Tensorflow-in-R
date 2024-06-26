# Install packages
install.packages(c(tensorflow,
                   keras,
                   reticulate))

#Install environemnt with conda
library(reticulate)
library(tensorflow)
library(keras)

# Install Miniconda
# reticulate::install_miniconda()

# Install Python
reticulate::conda_create(
  envname = "r-conda-env", 
  packages = "python==3.12.3"
)

# Install Tensorflow
tensorflow::install_tensorflow(
  method = "conda", 
  conda = reticulate::conda_binary("auto"), 
  envname = "r-conda-env", 
  version = "nightly-cpu"
)

keras::install_keras(
  method = "conda",
  conda = reticulate::conda_binary("auto"),
  tensorflow = "nightly-cpu"
)

# Select the rnvironment for tensorflow
tensorflow::use_condaenv("r-conda-env")

# Check the instalation
tensorflow::tf_config()
reticulate::py_config()

reticulate::conda_list()
#conda_remove("r-conda-env")

