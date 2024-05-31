# include images

#library(reticulate)
library(keras3)
library(tensorflow)
library(MLmetrics)
library(ramify)

tensorflow::tf_config()

# Load MNIST dataset
mnist <- dataset_mnist()
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

dim(x_train)
dim(y_train)

# Preprocess data - scale (dimension 784 = 28x28x1)
x_train <- array_reshape(x_train, c(nrow(x_train), 784))
x_train <- x_train / 255
x_test <- array_reshape(x_test, c(nrow(x_test), 784))
x_test <- x_test / 255

# define classes
y_train <- to_categorical(y_train, num_classes = 10)
y_test <- to_categorical(y_test, num_classes = 10)

# labels
class_names = c('0','1','2','3','4','5','6','7','8','9')

# Define CNN model (same as previous)
model <- keras_model_sequential() %>%
  layer_dense(units = 256, activation = "relu", input_shape = c(784)) %>%
  layer_dropout(rate = 0.25) %>% 
  layer_dense(units = 128, activation = "relu") %>%
  layer_dropout(rate = 0.25) %>% 
  layer_dense(units = 64, activation = "relu") %>%
  layer_dropout(rate = 0.25) %>%
  layer_dense(units = 10, activation = "softmax")
summary(model)

model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_adam(),
  metrics = c("accuracy")
)

history <- model %>% 
  fit(x_train, y_train, epochs = 50, batch_size = 128, validation_split = 0.15)

plot(history)

score_train <- model %>% evaluate(x_train, y_train, verbose = 2)

#cat('Train loss:', score_train["loss"], "\n")
#cat('Train accuracy:', score_train["accuracy"], "\n")

# Model Evaluation

predictions <- model %>%
  predict(x_test) %>%
  max.col() - 1L

predictions

# Evaluate

eval_df <- data.frame(
  actual = max.col(y_test),
  predicted = predictions
)

eval_df$actual <- lapply(eval_df$actual, function(x) x - 1)
head(eval_df)

eval_df$is_correct <- ifelse(eval_df$actual == eval_df$predicted, 1, 0)
head(eval_df)

# Confusion Matrix
eval_df <- as.data.frame(lapply(eval_df, unlist))
table(ACTUAL = eval_df$actual, PREDICTED = eval_df$predicted)

# Metrics
MLmetrics::Accuracy(y_pred = eval_df$predicted, y_true = eval_df$actual)
MLmetrics::Precision(y_pred = eval_df$predicted, y_true = eval_df$actual)
MLmetrics::Recall(y_pred = eval_df$predicted, y_true = eval_df$actual)
MLmetrics::F1_Score(y_pred = eval_df$predicted, y_true = eval_df$actual)
