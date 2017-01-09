#!/usr/bin/env bats


@test "pure kahlan command should work" {
  run docker run --rm $IMAGE --help
  [ "$status" -eq 0 ]
  has_usage_line=`echo "$output" | grep "Usage: kahlan" | wc -l`
  [ "$has_usage_line" -eq 1 ]
}

@test "pure kahlan should run tests" {
  run docker run --rm -v $(pwd)/test/app:/app $IMAGE --no-colors=true
  [ "$status" -eq 0 ]
  num=3
  if [[ "$IMAGE" == *"2.5"* ]]; then
    num=1
  fi
  has_passed_line=`echo "$output" | grep "$num of $num PASS" | wc -l`
  [ "$has_passed_line" -eq 1 ]
}


@test "kahlan should work under Xdebug" {
  run docker run --rm --entrypoint /kahlan-xdebug $IMAGE --help
  [ "$status" -eq 0 ]
  has_usage_line=`echo "$output" | grep "Usage: kahlan" | wc -l`
  [ "$has_usage_line" -eq 1 ]
}

@test "kahlan should run tests with coverage under Xdebug" {
  run docker run --rm --entrypoint /kahlan-xdebug -v $(pwd)/test/app:/app \
                 $IMAGE --coverage=4 --no-colors=true
  [ "$status" -eq 0 ]
  num=3
  if [[ "$IMAGE" == *"2.5"* ]]; then
    num=1
  fi
  has_passed_line=`echo "$output" | grep "$num of $num PASS" | wc -l`
  has_coverage_summary=`echo "$output" | grep "Coverage Summary" | wc -l`
  [ "$has_passed_line" -eq 1 ]
  [ "$has_coverage_summary" -eq 1 ]
}


@test "kahlan should work under phpdbg" {
  if [[ "$IMAGE" == *"php5"* ]]; then
    skip "no phpdbg on php5"
  fi
  run docker run --rm --entrypoint /kahlan-phpdbg $IMAGE --help
  [ "$status" -eq 0 ]
  has_usage_line=`echo "$output" | grep "Usage: kahlan" | wc -l`
  [ "$has_usage_line" -eq 1 ]
}

@test "kahlan should run tests with coverage under phpdbg" {
  if [[ "$IMAGE" == *"php5"* ]]; then
    skip "no phpdbg on php5"
  fi
  run docker run --rm --entrypoint /kahlan-phpdbg -v $(pwd)/test/app:/app \
                 $IMAGE --coverage=4 --no-colors=true
  [ "$status" -eq 0 ]
  num=3
  if [[ "$IMAGE" == *"2.5"* ]]; then
    num=1
  fi
  has_passed_line=`echo "$output" | grep "$num of $num PASS" | wc -l`
  has_coverage_summary=`echo "$output" | grep "Coverage Summary" | wc -l`
  [ "$has_passed_line" -eq 1 ]
  [ "$has_coverage_summary" -eq 1 ]
}
