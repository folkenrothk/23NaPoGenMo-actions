# Run on latest Ubuntu build
FROM ubuntu:latest

# Install helpful binaries
RUN apt-get update && apt-get install -y \
  jq \
  curl \
  wget 

# Get archive binary from latest release
RUN wget $(curl -s https://api.github.com/repos/folkenrothk/23NaPoGenMo-builder/releases/latest | jq -r ".assets[] .browser_download_url") -O /main

# Set main as executable
RUN chmod +x main

# Copy the runner script to the root fs
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Make the runner script the first stop
ENTRYPOINT ["/entrypoint.sh"]
