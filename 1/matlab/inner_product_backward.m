function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.
% param_grad.b = zeros(size(param.b));
% param_grad.w = zeros(size(param.w));

param_grad.w = input.data*(output.diff');
param_grad.b = sum(output.diff, 2)';

input_od = (output.diff' * param.w')';

end
