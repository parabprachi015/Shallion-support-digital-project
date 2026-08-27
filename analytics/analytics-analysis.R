# Analytics Analysis Script
# Shallion Support - Assessment 4
# Purpose: summarise website analytics and create simple visualisations

library(readr)
library(dplyr)
library(ggplot2)

# Load the analytics summary dataset
analytics <- read_csv("analytics/analytics-summary.csv", show_col_types = FALSE)

# Display the dataset
print(analytics)

# Calculate percentages for traffic/source measures where applicable
# and create basic descriptive summaries.
summary(analytics)

# ---------------------------------------------------------
# Page performance
# ---------------------------------------------------------

page_data <- data.frame(
  page = c("Homepage", "About Us", "Volunteering", "Contact Us"),
  visits = c(152, 52, 37, 30)
)

page_plot <- ggplot(page_data, aes(x = reorder(page, visits), y = visits)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Page Performance",
    x = "Page",
    y = "Visits"
  ) +
  theme_minimal()

print(page_plot)

# ---------------------------------------------------------
# Traffic sources
# ---------------------------------------------------------

traffic_data <- data.frame(
  source = c(
    "Direct",
    "Google Organic Search",
    "Bing Organic Search",
    "Referral",
    "Organic Social",
    "AI Platforms"
  ),
  sessions = c(55, 48, 18, 5, 1, 1)
)

traffic_plot <- ggplot(traffic_data, aes(x = reorder(source, sessions), y = sessions)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Website Traffic Sources",
    x = "Traffic source",
    y = "Sessions"
  ) +
  theme_minimal()

print(traffic_plot)

# ---------------------------------------------------------
# Google search performance
# ---------------------------------------------------------

search_data <- data.frame(
  query = c("shallion support", "shallion"),
  impressions = c(25, 103),
  clicks = c(14, 7),
  ctr = c(56.0, 6.8),
  average_position = c(1.0, 1.9)
)

search_long <- search_data %>%
  select(query, impressions, clicks) %>%
  tidyr::pivot_longer(
    cols = c(impressions, clicks),
    names_to = "measure",
    values_to = "count"
  )

search_plot <- ggplot(search_long, aes(x = query, y = count, fill = measure)) +
  geom_col(position = "dodge") +
  labs(
    title = "Google Search Performance",
    x = "Search query",
    y = "Count"
  ) +
  theme_minimal()

print(search_plot)

# ---------------------------------------------------------
# Key results
# ---------------------------------------------------------

cat("\nKey findings:\n")
cat("- Homepage was the most visited page.\n")
cat("- Direct traffic was the largest individual traffic source.\n")
cat("- Google organic search was an important acquisition channel.\n")
cat("- Branded search terms showed strong search performance.\n")
cat("- Future work should focus on non-branded search visibility and user pathways.\n")
