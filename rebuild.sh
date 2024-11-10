#!/run/current-system/sw/bin/bash

# Rebuild the NixOS system
sudo nixos-rebuild switch

# Check if the rebuild was successful
if [ $? -eq 0 ]; then
    echo "Rebuild successful. Pushing changes to Git repository."

    ssh-add ~/.ssh/github

    # Add all changes to Git
    git add /etc/nixos/*

    # Commit the changes with a message
    git commit -m "Update NixOS configuration after successful rebuild"

    # Push the changes to the remote repository
    git push origin master

    echo "Changes pushed to Git repository."
else
    echo "Rebuild failed. Not pushing changes to Git repository."
fi

