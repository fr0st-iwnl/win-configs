<div align="center">
  <h1>⚙️ \\ WinConfigs</h1>
<br>
  <table>
    <tr>
      <td>
        <img src="https://raw.githubusercontent.com/fr0st-iwnl/WinConfigs/refs/heads/master/Assets/preview2.png"/>
      </td>
    </tr>
  </table>
  <p><strong>A simple batch script to manage Windows utilities, system info, repositories, and performance tweaks.</strong></p>
</div>

<p align="center">
  <a href="#-installation">Installation</a> •
	<a href="#-features">Features</a> •
	<a href="#-configuration">Configuration</a> •
	<a href="#-credits">Credits</a>
</p>


## 📦 Installation 

### 1. Download the repository using PowerShell
- Run the following PowerShell command to download the repository and extract it on **Desktop**:
```powershell
iwr "https://fr0st.xyz/winconfigs" | iex
```

### 2. Download the repository
- Clone this repository or download the ZIP. **If you downloaded the ZIP, make sure to extract it before running the script.**
```bash
git clone https://github.com/fr0st-iwnl/WinConfigs.git
```

## ✨ Features

<details>
<summary>📦 Package Management</summary>

- **Scoop Package Manager**
  - Install, update, and manage software using **Scoop**.
  - **Customize the packages** you want to install by editing the `.txt` file located in the `Configuration/scoop-packages/packages-list.txt`.
  <br>
  <img src="https://raw.githubusercontent.com/fr0st-iwnl/WinConfigs/refs/heads/master/Assets/packagemanager.png" width="30%">

</details>

<details>
<summary>🔧 Custom Repositories</summary>

- **Personal Repository Setup**
  - The script allows you to manage your own custom repositories.
  - Simply add repository URLs to a `.txt` file located in the `Configuration/custom-repos/repos-list.txt`, and the script will automatically download and manage them using **Git**.
  <br>
  <img src="https://raw.githubusercontent.com/fr0st-iwnl/WinConfigs/refs/heads/master/Assets/customrepos.png" width="60%">

</details>

<details>
<summary>🖥️ System Utilities</summary>

- **Ntop and Fastfetch Integration**
  - The script comes with useful system utilities like **Ntop** for network monitoring and **Fastfetch** for displaying system information.
  - These tools provide real-time network stats and quick system info at your fingertips, enhancing your system management experience.

</details>


<details>
<summary>⚙️ System Tweaks</summary>

- **Performance Tweaks**
  - Optimizes system performance by adjusting settings with **WinUtil**.
  - Includes tweaks for system responsiveness and efficiency.

</details>



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



## 🔄 Credits

<table>
<tr>
<td align="center">
<img src="https://github.com/ChrisTitusTech/winutil/blob/main/docs/assets/favicon.png?raw=true" width="60px" alt="WinUtil"><br/>
<b><a href="https://github.com/ChrisTitusTech/winutil">WinUtil</a></b><br/>
<sub>Best Windows Utility</sub>
</td>
<td align="center">
<img src="https://avatars.githubusercontent.com/u/16618068?s=200&v=4" width="60px" alt="Scoop"><br/>
<b><a href="https://scoop.sh/">Scoop</a></b><br/>
<sub>Package Manager</sub>
</td>
</table>

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
