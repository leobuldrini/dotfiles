# Dot files - Buldrini
## Note
There are all my dotfiles, optimized for Mac, and the only changes so far *03/03/24* are in nvim
## NVIM Config
- In the branch `main` is a depreciated version of my nvim config, but it is working with Packer
- In the branch `safeWtDart` is the new version of my nvim config, using lazy.nvim and does not provide custom support for dart extension
- In the branch `wDart` is the new version of my nvim config, using lazy.nvim and provides custom support for dart extension. **This branch needs testing!!**

## 'flutter-watch' and 'flutter-start' commands
`flutter-watch` and `flutter-start` are bash scripts that should be put inside the .zshrc file. It also depends on `tmux`.
### 'flutter-watch'
This command is a simple bash script that watches for changes in the lib folder and runs the flutter test command. It is useful for TDD.
### 'flutter-start'
This command is a simple bash script that runs the flutter-watch command with less steps for *Matchmaking*. If used outside matchmaking, it will run the flutter-watch command with the parameters passed.

### Script
```bash
function flutter-watch() {
    tmux send-keys "flutter run $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 --pid-file=/tmp/tf1.pid" C-m \; \
    split-window -v \; \
    select-pane -t 1 \; \
    send-keys 'npx -y nodemon -e dart -x "cat /tmp/tf1.pid | xargs kill -s USR1"' C-m \; \
    resize-pane -y 5 -t 1 \; \
    select-pane -t 0 \;
}

function flutter-start() {
    case $1 in
        "matchmaking")
            case $2 in
                "dev")
                    flutter-watch -d chrome --web-hostname localhost --web-port 8000 --dart-define=API_URL=https://matchmaking-api-hml.fastdezine.com ;;
                "prd")
                    flutter-watch -d chrome --web-hostname localhost --web-port 8000 --dart-define=API_URL=https://matchmaking-api.fastdezine.com ;;
                *)
                    flutter-watch -d chrome --web-hostname localhost --web-port 8000 --dart-define=API_URL=http://localhost:8080 ;;
            esac
            ;;
        *)
            flutter-watch $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 ;;
    esac
}
```