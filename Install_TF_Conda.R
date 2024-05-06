#Install environemnt with conda
library(reticulate)
library(tensorflow)
library(keras)
# Install Miniconda
reticulate::install_miniconda()
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
  version = "2.16"
)

keras::install_keras(
  method = "conda",
  conda = reticulate::conda_binary("auto"),
  tensorflow = "2.16"
)

# Select the rnvironment for tensorflow
tensorflow::use_condaenv("r-conda-env")

# Check the instalation
tensorflow::tf_config()
reticulate::py_config()
