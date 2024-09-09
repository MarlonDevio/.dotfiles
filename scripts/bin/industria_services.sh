#!/bin/bash

# Define the services you want to manage
services=("mysql" "nginx" "php")

# Function to start services
start_services() {
    for service in "${services[@]}"; do
        echo "Starting $service..."
        brew services start "$service"
    done
    echo "All services started."
}

# Function to stop services
stop_services() {
    for service in "${services[@]}"; do
        echo "Stopping $service..."
        brew services stop "$service"
    done
    echo "All services stopped."
}

# Function to restart services
restart_services() {
    for service in "${services[@]}"; do
        echo "Restarting $service..."
        brew services restart "$service"
    done
    echo "All services restarted."
}

# Check the command-line argument and call the appropriate function
case "$1" in
    start)
        start_services
        ;;
    stop)
        stop_services
        ;;
    restart)
        restart_services
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
