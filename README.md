
# 2048 Game Deployment Script

This repository contains an automated deployment script for the popular 2048 game, leveraging Docker for containerization.

## Description

The script provided automates the following processes:
1. Installation and setup of Docker.
2. Creation of a Docker image that contains the 2048 game served using Nginx.
3. Deployment of the game, making it accessible on port 80 of the host machine.

## Prerequisites

- A machine running Ubuntu.
- A user with `sudo` privileges.


## Creating an AWS EC2 Instance

If you don't have a machine running Ubuntu, you can quickly set up an AWS EC2 instance. Follow the steps below:

1. **Login to AWS Management Console**:
    - Navigate to the [AWS Management Console](https://aws.amazon.com/console/).
    - Sign in with your credentials.

2. **Navigate to EC2 Dashboard**:
    - Once logged in, search for EC2 in the AWS services list.
    - Launch an instance
3. **Creating Ubuntu VM**: 
    - Choose Ubuntu as an OS
    ![Ubuntu as OS](https://github.com/hungvietlai/2048-game-deployment/blob/main/images/Screenshot%202023-10-02%20224224.png)
    - To stay in free tier choose t2.micro or t3.micro depends on your region
    ![t2.micro instance](https://github.com/hungvietlai/2048-game-deployment/blob/main/images/t2.micro.png)
    - Create a new key pair
    ![Create key pair](https://github.com/hungvietlai/2048-game-deployment/blob/main/images/keypair.png)
    - For Network settings, allow SSh and HTTP traffic
    ![Network settings](https://github.com/hungvietlai/2048-game-deployment/blob/main/images/network.png)
    - Finally "Launch intance" 
    Note: you may have to change the inbound rule to allow tcp port 80 under security after the instance is launched
    ![port80 settings](https://github.com/hungvietlai/2048-game-deployment/blob/main/images/port80.png)
4 **SSh from VS code**: 
    - Ensure you have installed remote - SSH extension
    ```bash
    ssh -i /path/to/private/key.pem ec2-user@your-ec2-ip-address


## Setup & Installation

1. **Clone the Repository**:
   ```bash
   sudo apt update -y
   sudo apt install git -y
   git clone https://github.com/hungvietlai/2048-game-deployment.git
   cd 2048-game-deployment
2. **Provide Execution Permissions**:
    ```bash
    chmod +x scripts/2048_game_script.sh
3. **Execute the Deployment Script**:
    ```bash
    ./scripts/your_script_name.sh

## Usage

After successful execution of the script, open a browser and navigate to http://localhost:80 to play the 2048 game.
![2048 game screenshot](https://github.com/hungvietlai/2048-game-deployment/blob/main/images/2048_game.png)

## Credit 
The 2048 game used in this deployment is originally developed by [Gabriele Cirulli](https://github.com/gabrielecirulli/2048). The game's source code can be found at [gabrielecirulli/2048](https://github.com/gabrielecirulli/2048).

