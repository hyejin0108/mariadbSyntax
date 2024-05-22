# local -> linux 마이그레이션
# dump -> 스키마와 데이터 insert문이 쿼리로 나옴

mysqldump -u root -p --default-character-set=utf8 board > dumpfile.sql
mysqldump -u root -p board -r dumpfile.sql