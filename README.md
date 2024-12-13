# ⚙️ \\\ WinConfigs
A simple batch script to manage Windows utilities, system info, repositories, and performance tweaks.

## 📦 Installation 

### 1. Download the repository
- Clone this repository or download the ZIP. **If you downloaded the ZIP, make sure to extract it before running the script.**
```
git clone https://github.com/fr0st-iwnl/WinConfigs.git
```

## 🔧 Configuration

### Customizing Packages List (Scoop)
To configure the packages that will be installed by Scoop, you can modify the `packages-list.txt` file located in the `Configuration\scoop-packages\` directory. Simply open the file and add or remove package names as needed. Each line should contain one package name that you wish to install. Here’s an example of how the file might look:

```yml
git
nodejs
```

When you run the script, it will automatically read from this list and install the packages you’ve added.

### Custom Repositories List
To configure the custom repositories that the script will manage, open the `repos-list.txt` file located in the `Configuration\custom-repos\` directory. Similar to the packages list, each line should contain the repository URL, the directory you want to install it into, and the description (separated by `#`). Here’s an example:

```yml
https://github.com/fr0st-iwnl/wallz#Wallz#Pictures#A collection of curated wallpapers.
https://github.com/fr0st-iwnl/WinMacros#WinMacros#Documents#Macros for productivity on Windows.
https://github.com/fr0st-iwnl/XPicker#XPicker#Documents#A slim and efficient color picker made in AutoHotkey.
```

Each repository will be listed with a prompt when you run the script, asking if you want to install it to your chosen directory. You can customize the repositories and directories as needed.



## 🔍 Preview

<div align="left">
  <table>
    <tr>
      <td>
        <img src="https://raw.githubusercontent.com/fr0st-iwnl/WinConfigs/refs/heads/master/Assets/preview.png"/>
      </td>
    </tr>
  </table>
</div>

## 📝 TODO's

- [x] Create categories for **System Monitor**, **System Info**, and others.
- [x] Enhance UI with colors for a better user experience.
- [x] Make paths for ASCII folder; if the user doesn't extract it, it should not appear.
- [x] Add more improvements and features.
- [x] Create a `CONTRIBUTING.md` file to guide users on how to contribute to the project.
- [x] Update the script to install packages from a `.txt` file using **Scoop** for easier customization.
- [x] Update the script to install custom repositories from a `.txt` file or redesign the installation process for them.
- [x] Improve version handling in the script for better version tracking and updates.
- [x] Improve the script and fix minor bugs for smoother user experience.
