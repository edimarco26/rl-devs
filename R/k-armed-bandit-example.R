library(rlsims)

# Define a temporal-difference conditioning agent using the built in algorithm
k_armed_agent <- rl_define_new_agent(
  model_type = "K-Armed Bandit",
  # Use built in model specification "k_armed_bandit", setting read = FALSE to
  # simply specify the path
  simulation_code_file = use_agent_template("k_armed_bandit", read = FALSE),
  # What values must be set for the agent/simulation to work?
  required_args = c(
    "num_arms", "num_trials", "num_episodes",
    "action_episode", "reinforcement_episode",
    "gamma", "alpha"
  ),
  required_methods = c("arms", "policy"), # must specify the arms and policy structure
  return_agent = TRUE # return the actual RL Agent object
)

# Initialize a k-Armed Bandit agent as 'twoArms'
twoArms <- k_armed_agent$new(
  model_id = "Two Armed Bandit Example",
  num_trials = 100,
  num_episodes = 4,
  num_arms = 2,
  action_episode = 2,
  reinforcement_episode = 3,
  gamma = 1,
  alpha = 0.3
)

# Set the arm structure, action-selection policy, and simulate
twoArms$
  set_arms(
    list(
      left = data.frame(
        probability = 0.1,
        magnitude = 1,
        alternative = 0,
        trial = 1:100
      ),
      right = data.frame(
        probability = 0.8,
        magnitude = 1,
        alternative = 0,
        trial = 1:100
      )
    )
  )$
  set_policy(
    policy = "softmax",
    tau = 0.5
  )$
  simulate_agent()
