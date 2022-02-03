library(rlsims)
library(tidyverse)
library(cowplot)

td_cond_agent <- rl_define_new_agent(
  model_type = "TD Conditioning",
  # Use built in model specification "td_conditioning", setting read = FALSE to
  # simply specify the path
  simulation_code_file = use_agent_template("td_conditioning", read = FALSE),
  # What values must be set for the agent/simulation to work?
  required_args = c("num_stimuli", "num_trials", "num_episodes", "gamma", "alpha"),
  # Only need to specify reinforcements and stimuli structure
  required_methods = c("reinforcements", "stimuli"),
  return_agent = TRUE # return the actual RL Agent object
)


# Initialize a new conditioning agent as tdCond
tdCond <- td_cond_agent$new(
  model_id = "Classical Conditioning via TDRL",
  num_stimuli = 1,
  num_trials = 100,
  num_episodes = 10,
  gamma = 1,
  alpha = 0.3
)

tdCond$
  set_stimuli(
    list(
      one = data.frame(
        onset = 3,
        offset = 8,
        magnitude = 1,
        trial = 1:100
      )
    )
  )$
  set_reinforcements(
    list(
      data.frame(
        onset = 8,
        offset = 8,
        magnitude = 1,
        trial = 1:100
      )
    )
  )$
  simulate_agent()

tdCond$pe_data %>%
  filter(trial %in% c(1:5)) %>%
  ggplot() +
  geom_line(aes(x = episode, y = value, color = trial)) +
  cowplot::theme_cowplot(
    font_size = 18,
    rel_large = 1
  ) +
  theme(legend.position = "none") +
  facet_wrap(~trial)


