function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.

output.data = ((param.w)'*input.data) + param.b';

output.height = input.height;
output.width = input.width;
output.batch_size = k;
output.channel = input.channel;

end
