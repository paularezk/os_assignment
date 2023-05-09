# Banker Algorithm in Flutter

This is a Flutter project that implements the Banker Algorithm. The Banker Algorithm is an algorithm used in Operating Systems to avoid deadlocks. The algorithm works by checking if granting a request for resources will leave the system in a safe state, i.e., a state where no deadlocks will occur.

## Screenshots

Here are some screenshots of the app:

![Screenshot 1](/assets/Screenshot%202023-05-10%20015657.png)

![Screenshot 2](/assets/Screenshot%202023-05-10%20015810.png)

## Usage

To use this app, you will need to enter the following information:

- Max resources: The maximum amount of each resource that the system can allocate.
- Allocation: The amount of each resource that is currently allocated to each process.
- Available resources: The amount of each resource that is currently available to the system.

Once you have entered this information, the app will tell you if there is a deadlock or not. If there is no deadlock, the app will animate the output using a loading bar that is split to the number of processes.

## Contributing

Contributions to this project are welcome. To contribute, please follow these steps:

1. Fork this repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them.
4. Push your changes to your forked repository.
5. Open a pull request to the original repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
