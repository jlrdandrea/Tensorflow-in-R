# Install packages
install.packages(c(tensorflow,
                   keras,
                   reticulate))

#Install environemnt with conda
library(reticulate)
library(tensorflow)
library(keras)

# Install Miniconda
reticulate::virtualenv_install()

# Install Python
reticulate::virtualenv_create(
  envname = "r-env", 
  packages = "python==3.12.3"
)

# Install Tensorflow
tensorflow::install_tensorflow(
  method = "env", 
  envname = "r-env", 
  version = "2.16"
)

keras::install_keras(
  method = "env",
  tensorflow = "2.16"
)

# Select the rnvironment for tensorflow
tensorflow::use_virtualenv("r-env")

# Check the instalation
tensorflow::tf_config()
reticulate::py_config()

virtualenv_list()
# virtualenv_remove("r-env")

