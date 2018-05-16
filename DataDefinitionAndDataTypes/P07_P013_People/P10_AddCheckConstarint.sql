ALTER TABLE Users
ADD CONSTRAINT pass_len_4 CHECK (LEN([Password])>4)
