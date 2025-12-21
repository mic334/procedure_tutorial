import numpy as np
import matplotlib.pyplot as plt


class DataSet:
    def __init__(self, n_points=100):
        self.n_points = n_points
        self.x = None
        self.y = None

    def generate_data(self):
        """Generate x and y data using NumPy"""
        self.x = np.linspace(0, 10, self.n_points)
        self.y = np.sin(self.x)

    def plot(self):
        """Plot the data using Matplotlib"""
        plt.plot(self.x, self.y, label="sin(x)")
        plt.xlabel("x")
        plt.ylabel("y")
        plt.title("Example OOP with NumPy and Matplotlib")
        plt.legend()
        plt.show()

