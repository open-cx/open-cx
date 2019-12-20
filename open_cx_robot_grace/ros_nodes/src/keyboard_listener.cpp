#include "ros/ros.h"
#include <geometry_msgs/Twist.h>

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <unistd.h>
#include <termios.h>
#include <signal.h>
#include <arpa/inet.h>
#include <stdarg.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <netdb.h>
#include <map>

#define MAXLINE 4096
#define PORT 8080
#define SA struct sockaddr

bool check_flag(char c);

// Map for movement keys
std::map<char, std::vector<float>> moveBindings{
    {'i', {1, 0, 0, 0}},
    {'o', {1, 0, 0, -1}},
    {'j', {0, 0, 0, 1}},
    {'l', {0, 0, 0, -1}},
    {'u', {1, 0, 0, 1}},
    {',', {-1, 0, 0, 0}},
    {'.', {-1, 0, 0, 1}},
    {'m', {-1, 0, 0, -1}},
    {'O', {1, -1, 0, 0}},
    {'I', {1, 0, 0, 0}},
    {'J', {0, 1, 0, 0}},
    {'L', {0, -1, 0, 0}},
    {'U', {1, 1, 0, 0}},
    {'<', {-1, 0, 0, 0}},
    {'>', {-1, -1, 0, 0}},
    {'M', {-1, 1, 0, 0}},
    {'t', {0, 0, 1, 0}},
    {'b', {0, 0, -1, 0}},
    {'k', {0, 0, 0, 0}},
    {'K', {0, 0, 0, 0}}};

std::map<char, std::vector<float>> speedBindings{
    {'q', {1.1, 1.1}},
    {'z', {0.9, 0.9}},
    {'w', {1.1, 1}},
    {'x', {0.9, 1}},
    {'e', {1, 1.1}},
    {'c', {1, 0.9}}};

// Init variables
float speed(0.5);              // Linear velocity (m/s)
float turn(1.0);               // Angular velocity (rad/s)
float x(0), y(0), z(0), th(0); // Forward/backward/neutral direction vars
char key(' ');
int alarm_flag = 0, the_socket;
struct sockaddr_in address;
bool connected = false;

ros::Publisher pub;
geometry_msgs::Twist twist;

void publish_vel()
{
  // If the key corresponds to a key in moveBindings
  if (moveBindings.count(key) == 1)
  {
    // Grab the direction data
    x = moveBindings[key][0];
    y = moveBindings[key][1];
    z = moveBindings[key][2];
    th = moveBindings[key][3];

    // printf("\rCurrent: speed %f\tturn %f | Last command: %c   ", speed, turn, key);
  }
  // Otherwise if it corresponds to a key in speedBindings
  else if (speedBindings.count(key) == 1)
  {
    //printf("\rCurrent: speed %f\tturn %f | Last command: %c   ", speed, turn, key);
  }
  // Otherwise, set the robot to stop
  else
  {
    x = 0;
    y = 0;
    z = 0;
    th = 0;

    // If ctrl-C (^C) was pressed, terminate the program
    if (key == '\x03')
    {
      exit(0);
    }

    //printf("\rCurrent: speed %f\tturn %f | Invalid command! %c", speed, turn, key);
  }

  // Update the Twist message
  twist.linear.x = x * speed;
  twist.linear.y = y * speed;
  twist.linear.z = z * speed;

  twist.angular.x = 0;
  twist.angular.y = 0;
  twist.angular.z = th * turn;

  // Publish it and resolve any remaining callbacks
  pub.publish(twist);
  ros::spinOnce();
}

void get_connection(int server_fd)
{
  int addrlen = sizeof(address);
  printf("*Getting connection*\n");
  fflush(stdout);

  while ((the_socket = accept(server_fd, (struct sockaddr *)&address,
                              (socklen_t *)&addrlen)) < 0)
  {
    printf("\n*Trying to connect*\n");
  }

  printf("\n*I'm connected*\n");
  fflush(stdout);

  connected = true;
  //ualarm(500000,0);
  alarm(1);
}

void read_socket()
{
  int valread;
  char buffer[255];
  turn = 0;
  speed = 0;
  printf("*Reading from socket*\n");
  fflush(stdout);

  while (connected)
  {
    fflush(stdout);
    memset(buffer, 0, 255);
    valread = read(the_socket, buffer, 255);
    printf("\nV is %d\n", valread);
    printf("\n*%s*\n", buffer);

    if (valread != 0)
    {
      for (int i = 0; i < valread; i++)
      {
        if (check_flag(buffer[i]))
        {
          //ualarm(500000,0);
          alarm(1);
          key = buffer[i]; //vang.at(0);

          if (key != 'k')
          {
            turn = (buffer[i + 1] - '0');
            turn += (buffer[i + 3] - '0') * 0.1;
            turn += (buffer[i + 4] - '0') * 0.01;
            turn += (buffer[i + 5] - '0') * 0.001;

            speed = (buffer[i + 7] - '0');
            speed += (buffer[i + 9] - '0') * 0.1;
            speed += (buffer[i + 10] - '0') * 0.01;
            speed += (buffer[i + 11] - '0') * 0.001;
          }
          else //k0.000s0.000
          {
            turn = 0;
          }
          printf("\n*%s*\n", buffer);
          publish_vel();
          i+=11;
        }
      }
    }
    else
    {
      key = 'k';
      printf("*Stopping*\n");
      publish_vel();
    }
  }
}

void try_to_reconnect(int c)
{
  printf("\nI'm disconnected\n");
  fflush(stdout);
  connected = false;
  key = 'k';
  turn = 0;
  speed = 0;
  publish_vel();
  printf("\nI'm still disconnected\n");
  fflush(stdout);
}

bool check_flag(char c)
{
  switch (c)
  {
  case 'u':
    return true;
  case 'i':
    return true;
  case 'o':
    return true;
  case 'j':
    return true;
  case 'k':
    return true;
  case 'l':
    return true;
  case 'm':
    return true;
  case ',':
    return true;
  case '.':
    return true;
  default:
    return false;
  }
}

int main(int argc, char **argv)
{
  (void)signal(SIGALRM, try_to_reconnect);

  ros::init(argc, argv, "keyboard_listener");
  ros::NodeHandle n;

  pub = n.advertise<geometry_msgs::Twist>("cmd_vel", 1);
  //printf("%s", msg);
  //printf("\rCurrent: speed %f\tturn %f | Awaiting command...\r", speed, turn);

  int server_fd;
  int opt = 1;

  // Creating socket file descriptor
  if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0)
  {
    perror("socket failed");
    exit(EXIT_FAILURE);
  }

  // Forcefully attaching socket to the port 8080
  if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
                 &opt, sizeof(opt)))
  {
    perror("setsockopt");
    exit(EXIT_FAILURE);
  }

  address.sin_family = AF_INET;
  address.sin_addr.s_addr = INADDR_ANY;
  address.sin_port = htons(PORT);

  // Forcefully attaching socket to the port 8080
  if (bind(server_fd, (struct sockaddr *)&address,
           sizeof(address)) < 0)
  {
    perror("bind failed");
    exit(EXIT_FAILURE);
  }

  if (listen(server_fd, 3) < 0)
  {
    perror("listen");
    exit(EXIT_FAILURE);
  }

  while (true)
  {
    get_connection(server_fd);
    read_socket();
  }

  return 0;
}