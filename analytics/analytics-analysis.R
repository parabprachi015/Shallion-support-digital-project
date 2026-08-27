# Analytics Analysis Script
# Shallion Support - Assessment 4
# Purpose: analyse aggregate website analytics and create visualisations

library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)

# ---------------------------------------------------------
# 1. Load aggregate analytics data
# ---------------------------------------------------------

analytics <- read_csv(
  "analytics/analytics-summary.csv",
  show_col_types = FALSE
)

page_data <- read_csv(
  "analytics/page-visits.csv",
  show_col_types = FALSE
)

traffic_data <- read_csv(
  "analytics/traffic-sources.csv",
  show_col_types = FALSE
)

search_data <- read_csv(
  "analytics/search-performance.csv",
  show_col_types = FALSE
)

# Display the datasets
print(analytics)
print(page_data)
print(traffic_data)
print(search_data)

# ---------------------------------------------------------
# 2. Page performance
# ---------------------------------------------------------

page_plot <- ggplot(
  page_data,
  aes(x = reorder(page, visits), y = visits)
) +
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
# 3. Traffic sources
# ---------------------------------------------------------

traffic_plot <- ggplot(
  traffic_data,
  aes(x = reorder(source, sessions), y = sessions)
) +
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
# 4. Google search performance
# ---------------------------------------------------------

search_long <- search_data %>%
  select(search_query, impressions, clicks) %>%
  pivot_longer(
    cols = c(impressions, clicks),
    names_to = "measure",
    values_to = "count"
  )

search_plot <- ggplot(
  search_long,
  aes(x = search_query, y = count, fill = measure)
) +
  geom_col(position = "dodge") +
  labs(
    title = "Google Search Performance",
    x = "Search query",
    y = "Count"
  ) +
  theme_minimal()

print(search_plot)

# ---------------------------------------------------------
# 5. Key results
# ---------------------------------------------------------

cat("\nKey findings:\n")

cat(
  "- The Homepage was the most visited page in the analysed data.\n"
)

cat(
  "- Direct traffic was the largest individual traffic source.\n"
)

cat(
  "- Google organic search was an important website acquisition channel.\n"
)

cat(
  "- Branded search queries showed strong search performance.\n"
)

cat(
  "- Future development should focus on non-branded search visibility,\n"
)

cat(
  "  clearer user pathways and continued monitoring of website engagement.\n"
)
