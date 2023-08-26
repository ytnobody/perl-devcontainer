# perl-devcontainer

ytnobody's devcontainer for perl

## Usage

1. Install Docker

    https://docs.docker.com/install/

2. Install VSCode

    https://code.visualstudio.com/

3. Install VSCode Remote Development Extension

    https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack

4. Clone this repository

    ```bash
    git clone
    ```

5. Open this repository with VSCode

    ```bash
    code perl-devcontainer
    ```

6. Reopen this repository with Remote Container

    - Click the green icon on the bottom left of VSCode
    - Select `Remote-Containers: Reopen in Container`

7. Enjoy!

## Sample application in this repository (Mojolicious)

### How to run

```bash
cd /workspaces/perl-devcontainer/sample-app
cpanm --installdeps .
morbo ./myapp.pl
```