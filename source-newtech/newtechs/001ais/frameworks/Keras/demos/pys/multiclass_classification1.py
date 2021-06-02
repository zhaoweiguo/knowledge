
# 1. 导入数据
from keras.datasets import reuters
(train_data, train_labels), (test_data, test_labels) = reuters.load_data(num_words=10000)

# 2. 查看数据概况
word_index = reuters.get_word_index()
reverse_word_index = dict([(value, key) for (key, value) in word_index.items()]) 
decoded_newswire = ' '.join([reverse_word_index.get(i - 3, '?') for i in train_data[0]])


# 3. 把数据转vector类型
import numpy as np
def vectorize_sequences(sequences, dimension=10000):
    results = np.zeros((len(sequences), dimension))
    for i, sequence in enumerate(sequences):
        results[i, sequence] = 1.
    return results

x_train = vectorize_sequences(train_data)
x_test = vectorize_sequences(test_data)

# 4. label数据转为vector类型
def to_one_hot(labels, dimension=46):
    results = np.zeros((len(labels), dimension))
    for i, label in enumerate(labels):
        results[i, label] = 1.
    return results
one_hot_train_labels = to_one_hot(train_labels)
one_hot_test_labels = to_one_hot(test_labels)

# 4. 使用keras自带的转化方法
from keras.utils.np_utils import to_categorical
one_hot_train_labels2 = to_categorical(train_labels)
one_hot_test_labels2 = to_categorical(test_labels)

# 4. 处理标签的另一种方法——将其转换为整数张量
y_train = np.array(train_labels) 
y_test = np.array(test_labels)

# 5. 构建网络
from keras import models
from keras import layers
model = models.Sequential()
model.add(layers.Dense(64, activation='relu', input_shape=(10000,)))
model.add(layers.Dense(64, activation='relu'))
model.add(layers.Dense(46, activation='softmax'))

# 5. 权重系数
model.add(layers.Dense(16, 
          kernel_regularizer=regularizers.l2(0.001),
          activation='relu', input_shape=(10000,))) 
model.add(layers.Dense(16, 
          kernel_regularizer=regularizers.l2(0.001),
          activation='relu'))

# 5. 3种权重系数
from keras import regularizers 
regularizers.l1(0.001)                  # L1 regularization 
regularizers.l2(0.001)                  # L2 regularization 
regularizers.l1_l2(l1=0.001, l2=0.001)  # Simultaneous L1 and L2 regularization

# 5. Adding dropout
model.add(layers.Dense(16, activation='relu', input_shape=(10000,)))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(16, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(1, activation='sigmoid'))


# 6. 留出验证集
x_val = x_train[:1000]
partial_x_train = x_train[1000:]
y_val = one_hot_train_labels[:1000]
partial_y_train = one_hot_train_labels[1000:]

# 7. 解决jupyter运行keras不可用问题
import os
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"

# 8. 训练模型
model.compile(optimizer='rmsprop',
              loss='categorical_crossentropy',
              metrics=['accuracy'])
history = model.fit(partial_x_train,
                    partial_y_train,
                    epochs=20,
                    batch_size=512,
                    validation_data=(x_val, y_val))

# 8. 处理损失的另一种方法(如果把lable转化为整数张量)
model.compile(optimizer='rmsprop',
              loss='sparse_categorical_crossentropy',
              metrics=['acc'])

# 9. 绘制训练损失和验证损失
import matplotlib.pyplot as plt
loss = history.history['loss']
val_loss = history.history['val_loss']
epochs = range(1, len(loss) + 1)

plt.plot(epochs, loss, 'bo', label='Training loss')
plt.plot(epochs, val_loss, 'b', label='Validation loss')
plt.title('Training and validation loss')
plt.xlabel('Epochs')
plt.ylabel('Loss')
plt.legend()
plt.show()

# 10. 绘制训练精度和验证精度
plt.clf()
acc = history.history['accuracy']
val_acc = history.history['val_accuracy']
plt.plot(epochs, acc, 'bo', label='Training acc')
plt.plot(epochs, val_acc, 'b', label='Validation acc')
plt.title('Training and validation accuracy')
plt.xlabel('Epochs')
plt.ylabel('Loss')
plt.legend()
plt.show()

# 11. 从头开始重新训练一个模型(不需要验证集了)
model = models.Sequential()
model.add(layers.Dense(64, activation='relu', input_shape=(10000,)))
model.add(layers.Dense(64, activation='relu'))
model.add(layers.Dense(46, activation='softmax'))
model.compile(optimizer='rmsprop',
              loss='categorical_crossentropy',
              metrics=['accuracy'])
model.fit(partial_x_train,
          partial_y_train,
          epochs=9,
          batch_size=512,
          validation_data=(x_val, y_val))

# 12. 在测试数据上评估模型
results = model.evaluate(x_test, one_hot_test_labels)

# 13. 使用训练好的网络在新数据上生成预测结果
predictions = model.predict(x_test)
print(predictions.shape)  # (46, )
np.sum(predictions[0])    # 这个向量的所有元素总和为 1
np.argmax(predictions[0]) # 最大的元素就是预测类别，即概率最大的类别


# 14. 进一步的实验
  # a. 隐藏层
  # b. 隐藏单元

# 15. 小结
  # a. 最后一层应是大小为N的Dense层
  # b. 最后一层应使用softmax激活
  # c. 「多分类问题」应该使用「分类交叉熵」
  # d. 「多分类问题」的标签(label)有两种方法
    # d1. 通过分类编码(也叫one-hot编码)对标签进行编码
    # d1. 使用categorical_ crossentropy 作为损失函数
    # d2. 将标签编码为整数
    # d2. 使用 sparse_categorical_crossentropy 损失函数
  # e. 避免使用太小的中间层，以免在网络中造成信息瓶颈







