import logging
from time import sleep

# Configure logging
logging.basicConfig(
    filename='/var/log/your_app.log',  # Log file path
    level=logging.INFO,                # Log level
    format='%(asctime)s %(levelname)s %(message)s',  # Log message format
    datefmt='%Y-%m-%d %H:%M:%S'        # Date format
)

def main():
    while True:
        logging.info("Application is running...")  # Log an info message
        sleep(10)  # Sleep for 10 seconds

if __name__ == "__main__":
    main()
