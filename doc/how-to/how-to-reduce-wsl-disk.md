# HOW TO REDUCE YOUR WSL VIRTUAL DISK USAGE

## Freeing Up Space in Ubuntu (WSL)

### Find What’s Taking Up Space

#### In Your Home Directory
This command gives you an overview of which folders in your home directory are using the most space:
```shell
du -h --max-depth=1 ~ | sort -rh | head -n 50
```

If you keep all your cloned projects in a `workspace` folder in your home directory:
```shell
du -h --max-depth=3 ~/workspace | sort -rh | head -n 50
```

Common suspects (frequently large folders):
```shell
du -h --max-depth=3 ~/.gradle | sort -rh | head -n 50
du -h --max-depth=3 ~/.m2 | sort -rh | head -n 50
du -h --max-depth=3 ~/.local | sort -rh | head -n 50
du -h --max-depth=3 ~/.cache | sort -rh | head -n 50
du -h --max-depth=3 ~/.npm | sort -rh | head -n 50
du -h --max-depth=3 ~/.nvm | sort -rh | head -n 50
```

#### In the Rest of Ubuntu
```shell
sudo du -h --max-depth=3 --exclude=/mnt/c --exclude=/home/{YOUR_USER} / | sort -rh | head -n 50
```

### Delete Unnecessary Files
Decide what you can remove and start deleting. Here are some common cleanup examples:

To completely remove the Gradle folder (usually in your home directory):
```shell
rm -r ~/.gradle
```

To delete a specific Gradle version:
```shell
rm -rf ~/.gradle/caches/8*
rm -rf ~/.gradle/daemon/8*
rm -rf ~/.gradle/wrapper/dists/gradle-8*
```

To remove all Docker containers, images, networks, and volumes:
```shell
docker system prune -a && docker volume prune
```

## Shrink the Ubuntu Virtual Disk

In a Windows PowerShell console with administrator privileges, follow these steps:

- Navigate to the folder containing your Ubuntu virtual disk (the `CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc` part may vary)
- Run `dir` to check the disk size before cleaning
- Shutdown the wsl
- Run the disk optimization command
- Run `dir` again to check the disk size after cleaning

```powershell
cd C:\Users\{YOUR_USER}\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState
dir
wsl --shutdown
optimize-vhd -Path .\ext4.vhdx -Mode full
dir
````