##### numpy 的一些知识
tile 复制数组，将数组扩大为多维 tile(2,3,1) 从右到左复制
axis 轴，即数组的维度, 0轴表示最外层的一维度，比如3*2*4 0轴表示三维空间里面平面的叠加那一个层面一定要把数组理解为行列式的复合
sum(array, axis=0) 等表示对0轴， 3*2*4 表示3 * 2行*4列  从0开始数，3是位于第0轴，axis=0就是将第0轴确定的元素相加，1轴就是2确定的元素