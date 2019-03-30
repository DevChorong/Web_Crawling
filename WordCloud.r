
# wordcloud를 위한 패키지들 import
install.packages("stringr")
install.packages("ggplot2")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("plyr")


# 가장 중요한 한글 체킹 패키지
install.packages("KoNLP")
install.packages("rJava")
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_201')
library("KoNLP")
useSejongDic()

# 사용자이름 에 해당하는 data.frame의 사전을 하나 생성한다.
mergeUserDic(data.frame("사전이름", "ncn"))

# import 한 패키지들 사용
library("stringr")
library("ggplot2")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("plyr")


setwd("C:\\Users\\ChoRong\\Desktop\\Base\\04. 개인 연구\\[4]Web_Crawling")
# Textfile 가져오기
text <- readLines("review.txt")

# 명사 단위로 쪼개기
text <- sapply(text, extractNoun, USE.NAMES = F)

# 리스트 해제 하고 2개의 길이만 허용하는 필터 = [1차원 형태로 만듦]
text <- unlist(text)
text <- Filter(function(x) {nchar(x) >= 2}, text) 

# 필요없는 단어 삭제하기
text <- str_replace_all(text,"[^[:alpha:]]","") # 특수문자
text <- str_replace_all(text,"[A-Za-z0-9]","")  # 숫자
text <- gsub("을", "", text)
text <- gsub("를", "", text)
text <- gsub("ㅋ", "", text)
text <- gsub("ㅠ", "", text)
text <- gsub("ㅇ", "", text)
text <- gsub("영화", "", text)

# 임시적인 파일을 만들어서 테이블 형태로 불러오기.
write(unlist(text) , "kr_text.txt")
text_table <- read.table("kr_text.txt")

# 테이블 형태로 데이터 만들기
word_count <- table(text_table)

# dataFrame 만들기
terms <- data.frame(word_count)

# 열 이름 바꿔주기
names(terms) <- c("word", "freq")

# 정렬 해주기
terms <- arrange(terms, desc(freq))

terms

wordcloud(words=terms$word, freq=terms$freq, random.order = F, colors=brewer.pal(12,"Paired"))











