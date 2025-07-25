# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Projects/dotagiftx-web"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "dotagiftx"; then
  tmux set-option -g default-size "$(tput cols)x$(tput lines)"

  # Create a new window inline within session layout definition.
  new_window "dotagiftx"

  split_h 20
  run_cmd "lazygit"
  split_v 50
  run_cmd "npm run dev"
  select_pane 1
  run_cmd "nvim"

  # Load a defined window layout.
  # Select the default active window on session creation.
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
