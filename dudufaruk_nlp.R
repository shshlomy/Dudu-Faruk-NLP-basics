library(tidytext)
library(magrittr)
library(dplyr)
library(ggplot2)
library(janeaustenr)
library(tidyr)
library(igraph)
library(ggraph)
library(topicmodels)
library(tm)

# Loading Dudu Faruk's songs:
text <- c("���� �� ���� ��� �� ���� ���� �� ����� ���� �� ������� �� ��� �� ���� ��� ���� ��� ���� ���� �� ���� �� �� ����� �� ��� ���� ���� �� �� �� �� ��� ���� ������� �� ���� ������ ���� ��� ��� ��� �� ���� �� ���� ��� ���� ���� ��� ��� ��� ��� ��� �� �� ��� ��� ����� ����� ���� ����� �� ��� �� ��� ������ ���� ������ ��� �� ��� ����� ���� �������� ��� ���� ���� ��� ����� ��� ����� ���� �� ����� ����� ����� ���� ��� ��� ���� ����� ����� ���� ��� ��� ���� ����� �� �� ��� ��� �� ������� ���� ��� ��� ��� ����� ������� ��� ��� ��� ��� �� �� ��� ��� ����� ����� ���� ����� �� ��� ��� ��� ��� ��� ��� ����� �� ��� ����� ����� ��� ��� ��� ��� �� �� ��� ��� ����� ����� ���� ����� �� ��� ��� ��� ���� ���� ������ ��� ��� ��� ��� �� �� ����",
          "���� ��� �� ����� ����� �� ����������� ��� ���� ���� ���� �� �� ��� ������ ���� ����� ������ ��� ���� ������ ���� ����� ����� ��� �� ��� �� ��� �� ��� �� ��� �� ��� �� ��� ��� �� ������ ��� ����� ���� ������ �� ���� ����� ��� ������ ������� �� ���� ����� ���� �� ������ ��� ���� ��� ������ �� ���� ���� ������� ����� �� ����� ����� ����� ������� �� ���� ���� ����� ���� ���� ����� ���� �� ��� ����� �� ��� ���� ���� ���� ������� ��� ���� ������� ������ �� ���� ��� ��� �������� ����������� �� ������� ���� ��� ��� �� ����� ���� ���� �� �� ������� ��� ���� ����� �� ��� ����� ����� ���� �� �� ������� ��� ���� ����� �� ���� �� �� ���� ��� ������ ��� �� ���� ������ �� ����� �� ���� �� �� ��� ���� �� ���� �� ��� ������ ��� ������� �� ����� ��� ��� ���� ������ �� ��� ��� ��� ���� �� ��� ����� ��� ���� �� ��� �� ����� ���� �� ����� �� ����� ���� ���� ����� ���� ��� �� ����� �� ���� �� �� �� ���� ��� ���� ���� ������� �� �� ����� ���� ��� ������ ���� ���� ���� ��� ���� ����� ���� ������ ��������� ���� ����� ����� ���� ������ ���� �� �� ������� ��� ���� ����� �� ��� ����� ����� ���� �� �� ������� ��� ���� ����� �� ���� �� �� ���� ��� ������ ��� ��� ��� ������ ��� ��� ����� ���� ��� ��� ����� �� ���� ��� ���� ����� �� ���� �� ��� ��� �� ������ ��� �� ��� ���� ������ ����� ��� ����� ���� ��������� ���� �� ���� ���� ���� �� ���� ����� �� �� �� ���� ������ ��� �� ����� �� ��� ���� �� ��� �� ������ �� ������ �� ���� ��� ���� ����� ���� ���� �� �� ������� ��� ���� ����� �� ��� ����� ����� ���� �� �� ������� ��� ���� ����� �� ���� �� �� ����",
          "��� �� ��� ���� ��� ����� ��� ���� ���� !��! �� �� ����� ��� �� �� �� ��� ���� ������� �� ����� ����� �� ���� ����� ��� ��� ��� ��� ��� ��� ��� �� ���� ��� ��� �� ����� ���� ����� ��� ��� ����� ��� ����� !����� ��� ����� �� ���� �����! �����  ��� �� ����� �� ���� �� ��� ����� �� ���� ��� ��� �� ���� ������ �� �� ������ �� �� ����� ����� ��� ����� ���� ���� ��� ���� ������� ����� ������� ������� ��� ����� �� ��� ����� ��� ���� �������� ���� ����� ���� ���� ���� ���� ���� ����� �� �� ������ ���� ��� ��� ����� ���� ��� ����� ����� ���� �� ������ ��� ����� ��� ��� ����� ���� ���� ���� �� �� ����� ���� �� ��� ���� ��� ���� ���� �� ����� ���� ����� ��� ��� ��� ��� ��� ��� ��� �� ���� ��� ��� �� ����� ���� ����� ��� ��� ����� ��� ����� ����� ��� ����� �� ���� �����! �����! ��� ����� �� ���� �� ���� ����� ������� �� ���� ��� ��� ���� ���� ����� ����� ���� ����� �� �� �� ������ ������ ���� ��� �� ���� ����� �� ���� �� ���� ���� ����� ���� �����! ����� ����� �� ���� ���� ��� ����� ������ ����� ��� �� ���� ADHD ���� ����� �� ���� ���� ������ �� �� ����� ���� ��� ����� ����� ��� �� ��� �� ����� ���� ���� ��� ���� ���� �� ���� ��� ���� ��� ���� ������ ����������� �� ����� ������ ������ ��� �� �� ���� ��� ���� ����� ���� �� ���� ����� ���� �� ��� ����� ���� ���� ��� �� ���� �� ���� �� ���� ���� �� ���� ��� ��� �� ���� ���� ��� ���� �����! ��� �� ������ ��� ��� ���� �� ���� ��� ��� �� �� ���� �� ���� �� ������ �� �� �� ����� �� ����� ����� ���� ����� �� ��� �� ���� ����� �� ��� �� ���� ����� ���� �� ����� ����� ��� ����� ��� ������ ��� ���� ���� ��� ���� ���� ��� ���� ������ ��� ������� ��� �� ����� �� ������ ���� ����� �� ��� ��� ���� ����� ����� ���� ��� �� ��� ����� ��� ��� ��� ��� ��� ��� ��� �� ���� ��� ��� �� ����� ���� ����� ��� ��� ����� ��� ����� ����� ��� ����� �� ���� �����! �����! ��� ����� �� ���� �� ���� ����� ������� �� ���� ��� ��� ���� ���� ����� ����� ���� ����� �� �� �� ������ ������ ���� ��� �� ���� ����� �� ���� �� ���� ���� ����� ���� �����!",
          "������ ������������� ���� ����� ����� ���� ���� ����� ���� ���� ������ ����� �� ��� ��� ��� �� ����� �� ���� ���� ���� �� ���� ���� ���� �� ���� ����� �� �� �� �� �� ����� �� ���� ���� �� ����� �� �� ����� �� ���� ���� ������ ���� ���� ��� ��� ����� �� ������� ����� ���� ����� ���� ��� ��� ��� �� ����� �� ����� �� ���� �� �������� ���� ���� ����� ��� �� ���� �� ���� ����� ���� ����� �� ���� �� ������ ���� �� ����� ���� ������� ����� ��� ��� ����� ������ ��� ���� ��� �� �� ���� ������ ��� �� ���� �� ����� �� ����� ����� �� ���� ��� �� ���� ���� ���� ���� �� �� ����� ����� ���� �� �� ����� ���� ���� �� �� ����� ���� ���� ��� ����� ���� ��� ������ ����� ��� ������ ����� ��� �� ��� ������ ����� ���� ��� ��� ��� ���� ���� ���� ��� ����� ��� ��� ����� ���� ���� ����� ���� ������ ����� ���� �� ��� ��� ����� ���� �� ����� ��� ��� ���� ��� ����� ����� �� ����� ����� ������ ��� ����� �� ����� �� ����� ����� ���� ��� �� ����� ���� ���� ����� ���� ���� ���� �� �� ���� �� ���� �� ��� ����� �� ���� ��� �� ���� ���� �� ������ ��� ���� ���� ���� ���� �� �� ����� ���� ���� �� �� ����� ���� ���� �� �� ����� ��  ���� ��� ���� ��� ����� ��� ������ ����� ��� �� ��� ������ ����� ���� ��� ������ ����� ���",
          "��� ������ ���� ��� ���� �� ����� ������� �� �� �� ���� ���� ����� ����� ����� ������ �� ������� ��� ���� ����� ����� ���� ����� �� ������ ��� ���� ������ ��� ����� ��� ����� ��� �� ��� ���� ��� ���� ���� ����� ����� ��� ����� ��� ����� ��� ��������� ��� ����� ���� ����� ����� ��� ���� ����� ��� ���� ����� ��� �� �� �� ���� ����� ��� ���� ����� ��� ��� ���� ��� ���� ��� ���� ��� ���� ���� ����� �� ��� ������� ��� ����� ������ ���� ������ ��� ��� ����� ��� ���� ����� �� ������ ���� �� ���� ����� ���� ����� ����� ����� ������ �� ������� ��� ���� ����� ����� ���� ����� �� ������ ��� ���� ������ ��� ����� �������� ���",
          "�� �� ����� ������ ��� ������� ������� �� �� ������� �� ���� ����� ����� ���� ����� ���� ��� ��� �� ������ ����� ��� �� ������ ��� �� �� ����� ��� �� ���� ��� ���� ���� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ������� ����� ����� ����� ����� ����� ����� ����� ����� ��� ���� ����� ��� ��� ��� ���� ����� ��� ����� ��� ���� ����� ��� ������� ����� ����� ����� ����� ����� ����� ����� ����� ����� ������� ����� ��� ��� �� �� ����� ��� ��� ��� �� �� ������� ��� ���� ���� ����� ����� ���� ���� ��� �� ������ ��� ���� ����� �� �� ��� �� ����� ��� �� ��� ����� ���� ��� ������ ��� ���� ����� ����� ����� ����� ����� ����� ������� ����� ����� ����� ����� ����� ����� ����� ����� ��� ���� ����� ��� ��� ��� ���� ����� ��� ����� ��� ���� ����� ��� ������� ����� ����� ����� ����� ����� ����� ����� ����� ����� ������� ����� ���� ������ ����� ���� ������ ���� ���� ���� ���� ��� ���� �� ���� ������ ��� ��� ��� �� ��� ������ ��� ������� ����� ������ ���� ��� ����� ����� ����� ����� ����� ����� ����� ������� ����� ����� ����� ����� ����� ����� ����� ����� ��� ���� ����� ��� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ����� ������� ����� ����� ����� ����� ����� ����� ����� ����� ��� ���� ����� ��� ��� ��� ���� ����� ��� ����� ��� ���� ����� ��� ������� ����� ����� ����� ����� ����� ����� ����� ����� ����� ������� �����",
          "�� �� ������ ���� ����� ��� ����� ���� �� ��� �� ����� �� �� ������ ���� ����� ���� �� �� ��� ��� ��� ������� �� ������ ������ �� �� ����� ��� ���� ��� ���� �� ��� ������ ���� ���� ����� ��� ����� ��� �� ������� ���� ��� ����� ��� ����� ��������� ��� ����� �� ��� ����� �� ��� ��� ���� ��� ���� ������ ���� �� ���� ����� ��� ������ ��� ����� �� ���� �� ���� ��� �� ���� ��� ����� ��� ����� �� ������ �� �� ����� ������� ������ ������ ����� ���� �� ��� �� ����� �� �� ������ �� ���� ����� �� ����� �� �� ����� �� ����� ��� ��� ���� ������ ��� ����� ��� �� �� ������ ���� ��� ������� ���� �� ������ �� ����� ��� ���� �� ����� ��� ����� ����� ��� �� ������ ��� �� �� ������ ���� ���� �� �� �� ����� ��� ����� ��� �� ���� ����� �� ���� ��� �� �� ������ ��� �� �� ������ ����� �����: ���� ��� ��� ����� �� �� ������ ���� ����� ��� ����� ���� �� ��� �� ����� �� �� ������ ���� ����� ���� �� �� ��� ��� ��� ������� ��� ����� ��������� ���� ��� ������� ���� ������ ���������� ������ ��� �� ����� ��� �� ���� ������� ��� �� ��� ������ ���� ����� ���� ��� ������ ����� ���� ��� ���� ��� �� ����� �� ��� ��� �� ������� ��� �� ������� ���� ����� ��� �� ��� ����� �� ���� ���� ���� ������ �� ���� �� ��� �� ��� ���� �� �� �� �� �� ���� ����� ���� ���� �� ��� �� ���� ���� �� ���� ���� ��� ��� ��� �� ���� ��� ��� ����� ��� ��� ����� ��� ��� ����� ��� ���� ��� ������ ���� ����� �� ����� ��� ��� ����� ��� ���� ��� ����� ��� ����� ���� ����� ����� ���� �� �� ������ ���� ����� ��� ����� ���� �� ��� �� ����� �� �� ������ ���� ����� ���� �� �� ��� ��� ��� ����� �� �� ������ ���� ����� ��� ����� ���� �� ��� �� ����� �� �� ������ ���� ����� ���� �� �� ��� ��� ��� �����",
          "���� �� �� ��� �� ��� ��� ��� ��� ������� ���� ���� ��� ������ �� �� ������ ������� �� ����� ��� ������ ��� ��� ��� ���� ����� ���� ������ ����� ������ ��� �� ������ ����� ����� ��� ���� ��� ���� ����� �� ����� ����� ��� ���� �� ������� ��� ���� ��� ��� ��� ���� ����� ��� ���� �� ��� ���� �� ��� ���� ����� �� ��� ��� ��� ���� ��� �� �� ���� ��� ���� �� �� ��� �� ��� ��� ��� ��� ������� ���� ���� �� �� ��� �� ���� �� �� ����� �� ������ ��� ������� �� ��� ���� ����� ��� ��� �� �� �� ��� ����� ����� ����� �� ������ ���� �� ������� ��� �������� ��� ������ �� ������� ���� �� �� ��� �� ��� ��� ��� ��� ������� ���� ���� �� �� ��� �� ���� �� �� ����� �� ������ ��� �� ����� �� �� ������ ���� ��������� ���� �� ������� ���� �� ���� �� �� ��� �� ��� ��� ��� ��� ������� ���� ���� �� �� ��� �� ���� �� �� ����� �� ������ ���",
          "���� ���� ����� �� ���� ���� �� ��� ���� �� �� ���� �� ����� ���� �� ���� �� �� ���� �� ����� ���� �� ���� �� �� ���� �� ����� ���� �� ��� �� ��� �� ���� �� ����� �� ������ ��� ���� ���� �� ������ ����� �� ������ ���� �� ������ ����� �� ������ ���� �� ������ �� ����� ����� ����� ���� ���� �� ���� �� ���� ���� �� ���� ��� ��� ����� ��� ��� ����� ����� �� �� ���� ��� ���� ���� �� ����� ��� ��� �� ����� ��� �� ���� ��� ��� ��� �� ���� ����� ����� ����� ���� ��� ����� �� ����� ����� �� ����� ��� ����� ��� ����� �� ����� ��� ����� �� ����� ���� ��� ������ ���� ��� ������ ���� �� ��� �� ���� ���� ������ ����� ���� ��� ���� ����� ���� ��� ���� ����� ���� ���� ��� ����� ���� ���� ��� ����� ���� ��� ����� ���� ��� ���� ���� �� ���� ���� �� ���� ���� �� ���� ��� ����� ���� ����� ����� ���� ����� 2000 ����� ����� �� ���� ��� ���� ����� ������� ����� ���� ����� ����� ���� ����� 2000 ����� ����� �� ���� ��� ���� ����� ������� ���� �� ������ ���� ����� ����� ����� ���� ��� ���� ���� ���� �� ������ ��� ������� ���� �� ���� ��� ������� ���� ���� ��� ���� ���� ���� ���� �� ����� ��� �� ����� ����� �� ���� �� �� ����� ����� ��� ���� ����� ������ ����� ����� ��� ���� ����� ����� ������ ��� ����� ������ �� ����� ���� �� ��� ���� ���� ��� ���� ����� �� ���� ���� ����� ��� ����� �� ���� ���� ��� �� ����� �� �� ���� ��� ������ ���� ����� ����� �� ��� �� ��� ����� �� ��� �� ��� ����� ���� ���� �� ������ �� �� ���� ������� ����� ��� �� ���� ������ �� ���� ��� �� ��� ���� ���� �� ���� ���� �� ���� ���� �� ���� ��� ����� ���� ����� ����� ���� ����� 2000 ����� ����� �� ���� ��� ���� ����� ������� ����� ���� ����� ����� ���� ����� 2000 ����� ����� �� ���� ��� ���� ����� ������� ���� �� ������ ���� �� ���� ���� �� ���� ���� �� ���� ���")

# Creating stop words list:
stop_words <- c("���",
                "��",
                "��",
                "��",
                "��",
                "���",
                "��",
                "��",
                "��",
                "��",
                "���",
                "��",
                "��",
                "��",
                "���",
                "���",
                "��",
                "��",
                "��",
                "��",
                "���",
                "��",
                "���",
                "��",
                "����",
                "����",
                "���",
                "��",
                "���",
                "���",
                "����",
                "��",
                "���",
                "��",
                "���",
                "���",
                "��",
                "���",
                "��",
                "��",
                "���",
                "��"
)


text_df <- tibble(line = 1:9, text = text)

# Turning words in songs (documents) into tokens:
tidy_dudu <- text_df %>%
  unnest_tokens(word, text)

# Deleting stop words:
stop_words <- as.data.frame(cbind(stop_words, c("SMART")))
colnames(stop_words) <- c("word", "lexicone")
tidy_dudu <- tidy_dudu %>%
  anti_join(stop_words)

# Counting words:
tidy_dudu_count <- tidy_dudu %>%
  count(word)

# Word count bar graph:
tidy_dudu_count %>%
  filter(n > 9) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

# Creating bigrams:
dudu_bigrams <- text_df %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 3)

# Top bigrams:
dudu_bigrams_sorted <- dudu_bigrams %>%
  count(bigram, sort = TRUE)

bigrams_separated <- dudu_bigrams %>%
  separate(bigram, c("word1", "word2"), sep = " ")

bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

# new bigram counts:
bigram_counts <- bigrams_filtered %>% 
  count(word1, word2, sort = TRUE)


# Creating bigram graph:
bigram_graph <- bigram_counts %>%
  filter(n > 4) %>%
  graph_from_data_frame()

set.seed(2016)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "lightblue", size = 3) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  theme_void()

# Converting tokeneized words into doctype for LDA:
tidy_dudu_lda <- tidy_dudu %>% count(word, line)
tidy_dudu_lda <- tidy_dudu_lda[c(2, 1, 3)]
colnames(tidy_dudu_lda) <- c("document", "term", "count")
doctype <- tidy_dudu_lda %>%
  cast_dtm(document, term, count)

# LDA analysis and topic detection (k=2):
ap_lda <- LDA(doctype, k = 2, control = list(seed = 1234))
ap_topics <- tidy(ap_lda, matrix = "beta")
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

# Topics graph:
ap_top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()

