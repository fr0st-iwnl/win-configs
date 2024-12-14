# ⚙️ [!] WinConfigs Security Policy

## Security Considerations for Users

While WinConfigs is designed to be a safe and easy-to-use tool for system customization, users should always be aware of the following best practices and security considerations when using or customizing scripts:
1. Avoid Modifying the Script Insecurely

    Do not add untrusted sources: If you're adding custom repositories, software, or configuration changes, ensure that the sources you're adding are trustworthy and secure. Avoid using unsigned or unverified repositories.
    Inspect Scripts Before Running: Always inspect any script before running it, especially when it’s downloaded from external repositories. If you don’t understand a part of the script, seek assistance or clarification before proceeding.
    Be Cautious with Elevated Permissions: Some operations in WinConfigs may request elevated permissions (e.g., administrator rights). Only grant these permissions when necessary and if you fully trust the source.

2. Downloading Scripts and Files

    Always use HTTPS: Ensure that all downloaded files (e.g., from GitHub, custom repositories) are retrieved via HTTPS. This ensures that the files aren’t intercepted or altered by malicious parties during transmission.
    Verify the Source: If downloading from external sources or custom repositories, ensure that the links and repositories are secure and verified. Avoid downloading from suspicious URLs.

3. Be Mindful of Custom Repositories

WinConfigs allows users to add custom repositories to install additional software. This flexibility can introduce security risks if users add repositories from untrusted sources. Here's how to protect yourself:

    Limit Custom Repos: Only add repositories that you know and trust. Unverified repositories might contain malicious code or compromised software.
    Review Repository Content: Before adding a new repository, review its contents to make sure it doesn’t contain any harmful scripts or executables.

4. Minimize the Use of `sudo/Administrator` Privileges

Running scripts that require administrator access on your system can potentially expose your system to vulnerabilities. Limit the use of such scripts to those that absolutely need elevated permissions, and always verify their content before executing.

    Use Minimal Privileges: Run the script or commands with the least privilege necessary to accomplish the task. Don't use sudo or administrator rights unless needed for specific operations.

6. Review the Files Being Installed/Modified

Before running any script, especially from a new or custom source, it's important to review which files are being modified or installed. For instance:

    Check for Suspicious Files: When installing packages or software via WinConfigs, review the files being downloaded and installed to ensure they don't contain malicious content.
    Monitor System Changes: If running the script as an administrator, monitor your system for unexpected changes or installations.

## Supported Versions

We currently support WinConfigs on the latest version, as well as on prior releases. However, older versions may no longer receive security patches. It is highly recommended that you update to the latest release to benefit from ongoing improvements and security fixes.
Security Policy Changes

We reserve the right to update this security policy as needed. Please review this document periodically for any changes. You will be notified of major changes through our GitHub repository.
