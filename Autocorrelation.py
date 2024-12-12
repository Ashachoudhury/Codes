import numpy as np

# Load data from file
data = np.loadtxt('filename.txt', dtype=float)

# Calculate autocorrelation function
autocorr = np.correlate(data, data, mode='full')

# Write result to file
np.savetxt('autocorr.txt', autocorr, fmt='%.4f')
