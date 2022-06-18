# Description
## Part 1:
This is a a CNN that is trained using PyTorch framework on [CIFAR10 dataset](https://www.cs.toronto.edu/~kriz/cifar.html) - images are of size 3x32x32. The result will be a deep net architecture that can be used to classify images into 100 different categories. In particular, the CNN is basically a **BaseNet** that has a baseline accuracy of approximately 23%, which is then further improved by adding more convolutional layers (conv layers), normalization layers after conv layers, linear layers and normalization layers after those linear layers.  
The initial provided **BaseNet** consists of the following neural network layers:
- Convolutional
- Pooling
- Fully Connected (linear)
- Non-linear activations (ReLU)
- Normalization
 
The Loss function used in the first part of the project is *Cross-Entropy* with SGD being the chosen optimizer. 

## Part2: 
