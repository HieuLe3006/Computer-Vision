# Description
This is a numeric character recognition system that is implemented based on convolutional neural network (CNN) and trained on MNIST dataset. 
<br>
The neural network consists of these layers:
- Inner Product layer
- Pooling layer
- Convolution layer
- ReLU
There are 2 main steps: **Forward Pass** - the variables are forward propagated through the network and **Back Propagation** - performs a backward pass while adjusting the parameters whenever a forward pass through a network. 

It is possible to visualized the layers using using the script in `vis_data.m`

To test the fully trained network, user needs a *grey-scaled image* - which can be obtained from real life image by:
- Classifying pixesl as foreground or background by thresholding.
- Find connected components and place a bounding box around each individual character. 
- Take each bounding box, resize it to 28x28 (use paddings if needed), and then pass through network. 