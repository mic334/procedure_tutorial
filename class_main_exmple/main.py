from data_model import DataSet


def main():
    dataset = DataSet(n_points=200)
    dataset.generate_data()
    dataset.plot()


if __name__ == "__main__":
    main()

