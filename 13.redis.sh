# 싱글스레드. 동시성 이슈 X. 인메모리 기반으로 성능이 좋음
sudo apt-get install redis-server
redis-server --version

#레디스 접속
#cli : commandline interface
redis-cli

#redis는 0~15번까지의 database구성
#데이터베이스 선택
select 번호 # 0번이 디폴트

#데이터베이스 내에 모든 키 조회
keys *

#일반 String 자료구조
SET key(키) value(값)
set test_key1 test_value1
set user:email:1 hongildong@naver.com
# 이미 존재하는 key > 덮어쓰기가 됨
# 맵 저장소에서 key 값은 유일하게 관리가 되므로
# nx: not exist(key가 없을때만 set하겠다)
set user:email:1 hongildon2@naver.com nx
# ex (만료시간-초단위) -ttl(time to live) ex) 세션
set user:email:2 hongildong2@naver.com ex 20 # 20초 뒤에 사라짐
# 특정 key 삭제
del user:email:1
# key 다 지우기
flushdb

# 좋아요
set likes:posting:1 0
incr likes:posting:1 #특정 key값의 val 1만큼 증가
decr likes:posting:1
get likes:posting:1

# 값 얻기
get test_key1

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1stock

# bash 쉘을 활용하여 재고감소 프로그램 작성