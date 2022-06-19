# Description
## Part 1:
This is a a CNN that is trained using PyTorch framework on [CIFAR10 dataset](https://www.cs.toronto.edu/~kriz/cifar.html) - images are of size 3x32x32. The result will be a deep net architecture that can be used to classify images into 100 different categories. In particular, the CNN is basically a **BaseNet** that has a baseline accuracy of approximately 23%, which is then further improved by adding more convolutional layers (conv layers), normalization layers after conv layers, linear layers and normalization layers after those linear layers.  
The initial provided **BaseNet** consists of the following neural network layers:
- Convolutional
- Pooling
- Fully Connected (linear)
- Non-linear activations (ReLU)
- Normalization
 
The Loss function used in the first part of the project is *Cross-Entropy* with *SGD* being the chosen optimizer. 

## Part2:
Similar to part 1, this is a model trained on [Caltech-USCD Birds dataset](vision..caltech.eduvsipedia/CUB-200.html) - a dataset consisting of 3000 images in train-dataset and 3033 images in test-dataset of 200 different types of birds. The initial provided **ResNet** acts as a fixed feature extractor and with centercropping being a the only hyperparameter
 used in the testing process, we achieve a baseline accuracy of 15.5% for our model. 
<br/>
In general, we aim to improve this number by performing hyperparameter tuning and data augmentation while trying to avoid overffiting the model. Particularly, these are the hyperparameter adjustments used in part 2:
- train:
	- *RandomResizedCrop*
	- *Normalize*
- test:
	- *CenterCrop*
	- *Normalize*
