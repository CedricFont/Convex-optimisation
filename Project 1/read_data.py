import pandas as pd
import numpy as np
"""
MGT - 418 
Convex Optimization - Project 2
2021-2022 Fall
Kernel Learning
"""
np.random.seed(0)

def prepare_ionosphere_dataset():
    df = pd.read_csv('ionosphere.data', sep=",", header=None)
    data_array = np.array(df)
    data_array = np.delete(data_array, 1, 1)
    labels = data_array[:, -1]
    labels[labels == 'g'] = -1
    labels[labels == 'b'] = 1
    data_array = data_array[:, :-1]
    data_normalized = data_array / data_array.max(axis=0)

    return data_normalized, labels
