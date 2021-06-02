

# 1. 导入数据
from keras.datasets import boston_housing
(train_data, train_targets), (test_data, test_targets) =boston_housing.load_data()

# 2. 准备数据
# 原因: 输入数据的 每个特征(比如犯罪率)都有不同的取值范围。
#     a. 有些特性是比例，取值范围为 0~1
#     b. 有的取值范围为 1~12
#     c. 有的取值范围为 0~100
#     将取值范围差异很大的数据输入到神经网络中，这是有问题的。
# 解决:
#     数据标准化: 特征平均值为 0，标准差为 1
mean = train_data.mean(axis=0)
train_data -= mean

std = train_data.std(axis=0)
train_data /= std

test_data -= mean
test_data /= std

# 3. 构建网络
from keras import models
from keras import layers
def build_model():
    model = models.Sequential()
    model.add(layers.Dense(64, activation='relu',
                           input_shape=(train_data.shape[1],)))
    model.add(layers.Dense(64, activation='relu'))
    model.add(layers.Dense(1))
    # 损失函数: mse
    # 指标: mae
    model.compile(optimizer='rmsprop', loss='mse', metrics=['mae'])
    return model

# 4. 解决jupyter运行keras不可用问题
import os
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"

# 5. K 折线交叉验证
import numpy as np
k=4
num_val_samples = len(train_data) // k 
num_epochs = 100   # 训练100次
all_scores = []

for i in range(k):
    print('processing fold #', i)
    # 1/4作为验证集
    val_data = train_data[i * num_val_samples: (i + 1) * num_val_samples] 
    val_targets = train_targets[i * num_val_samples: (i + 1) * num_val_samples]

    # 剩下的作为训练集
    partial_train_data = np.concatenate( 
        [train_data[:i * num_val_samples],
         train_data[(i + 1) * num_val_samples:]], 
        axis=0)
    partial_train_targets = np.concatenate( 
        [train_targets[:i * num_val_samples],
         train_targets[(i + 1) * num_val_samples:]], 
        axis=0)
    
    model = build_model()

    model.fit(partial_train_data, partial_train_targets,
              epochs=num_epochs, batch_size=1, verbose=0)
    
    val_mse, val_mae = model.evaluate(val_data, val_targets, verbose=0)
    all_scores.append(val_mae)
    print('End fold #', i)

# 5. 交叉验证结果
print(all_scores)
# [2.096412181854248, 2.505697727203369, 2.7529520988464355, 2.5774314403533936]
print(np.mean(all_scores))
# 2.4831233620643616

# 结论:
# 每次运行模型得到的验证分数有很大差异，从 2.09 到 2.75 不等
# 平均分数(2.48)是比单一 分数更可靠的指标——这就是 K 折交叉验证的关键
# 预测的房价与实际价格平均相差 2480 美元



# 6. 保存每折的验证结果，并让训练时间更长一点，达到 500 个轮次
num_epochs = 500 
all_mae_histories = []
for i in range(k):
    print('processing fold #', i)
    val_data = train_data[i * num_val_samples: (i + 1) * num_val_samples] 
    val_targets = train_targets[i * num_val_samples: (i + 1) * num_val_samples]

    partial_train_data = np.concatenate( 
        [train_data[:i * num_val_samples],
         train_data[(i + 1) * num_val_samples:]], 
        axis=0)
    partial_train_targets = np.concatenate( 
        [train_targets[:i * num_val_samples],
         train_targets[(i + 1) * num_val_samples:]], 
        axis=0)
    
    model = build_model()

    history = model.fit(partial_train_data, partial_train_targets,
                    validation_data=(val_data, val_targets),
                    epochs=num_epochs, batch_size=1, verbose=0)
    mae_history = history.history['val_mae']
    all_mae_histories.append(mae_history)
    print('End fold #', i)

# 6. 计算所有轮次中的 K 折验证分数平均值
average_mae_history = [
    np.mean([x[i] for x in all_mae_histories]) for i in range(num_epochs)]

# 7. 绘制验证分数
import matplotlib.pyplot as plt
plt.plot(range(1, len(average_mae_history) + 1), average_mae_history)
plt.xlabel('Epochs')
plt.ylabel('Validation MAE')
plt.show()


# 8. 绘制验证分数(删除前 10 个数据点&EMA)
def smooth_curve(points, factor=0.9):
  smoothed_points = []
  for point in points:
    if smoothed_points:
      previous = smoothed_points[-1]
      smoothed_points.append(previous * factor + point * (1 - factor))
    else:
      smoothed_points.append(point)
  return smoothed_points

smooth_mae_history = smooth_curve(average_mae_history[10:])

plt.plot(range(1, len(smooth_mae_history) + 1), smooth_mae_history)
plt.xlabel('Epochs')
plt.ylabel('Validation MAE')
plt.show()

# 结论:
# 验证 MAE 在 80 轮后不再显著降低，之后就开始过拟合


# 9. 从头开始重新训练一个模型(不需要验证集了)
model = build_model()   # 一个全新的编译好的模型
# 在所有训练数据上训练模型
model.fit(train_data, train_targets, epochs=80, batch_size=16, verbose=0)
# 在测试集上测试模型
test_mse_score, test_mae_score = model.evaluate(test_data, test_targets)



# 10. 小结
  # a. 回归问题使用的损失函数与分类问题不同。回归常用的损失函数是均方误差(MSE)
  # b. 与分类问题不同，精度的概念不适用于回归问题。常见的回归指标是平均绝对误差(MAE)。
  # c. 如果输入数据的特征具有不同的取值范围，应先预处理，对每个特征单独进行缩放。
  # d. 如果可用的数据很少，使用 K 折验证可以可靠地评估模型。
  # e. 如果可用的训练数据很少，最好使用隐藏层较少(通常只有一到两个)的小型网络，以避免严重的过拟合。










