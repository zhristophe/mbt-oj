///| 令x -> n为恒等映射
///  然后调整它保证m -> x是满射
fn solution(
  injection~ : Array[Int],
  surjection~ : Array[Int]
) -> (Array[Int], Array[Int]) {
  let (i1, s1) = (injection, surjection)
  let n = i1.length()
  let (s2, i2) = ([], [])
  let mut mid = 0
  let mut y = 0
  let mut sum = 0
  let mut last_y = 0
  for x in 1..=n {
    mid += i1[x - 1]
    while mid > sum {
      sum += s1[y]
      y += 1
    }
    match y - last_y {
      0 => s2[s2.length() - 1] += 1
      d if d > 0 => {
        i2.push(d)
        s2.push(1)
        last_y = y
      }
      _ => panic()
    }
  }
  (s2, i2)
}

///|
test {
  println(solution(injection=[1, 1, 1, 1], surjection=[2, 1, 1]))
  println(solution(injection=[1, 20, 4], surjection=[3, 2, 20]))
  println(solution(injection=[1, 1], surjection=[1, 0, 1]))
}

///|
fn apply_inj(f : Array[Int], x : Int) -> Int {
  loop f[:], x, 0 {
    [], x, sum => {
      guard x == 0
      sum
    }
    _, 0, sum => sum
    [skipped, .. f], x, sum => continue f, x - 1, sum + skipped
  }
}

///|
fn apply_sur(f : Array[Int], x : Int) -> Int {
  loop f[:], 0, 0 {
    [], _, value => value
    [count, .. f], index_in_domain, value =>
      if index_in_domain >= x {
        value
      } else {
        continue f, index_in_domain + count, value + 1
      }
  }
}

///|
fn verify_solution(i1 : Array[Int], s1 : Array[Int]) -> Unit! {
  let (s2, i2) = solution(injection=i1, surjection=s1)
  let n = i1.length()
  for x in 1..=n {
    assert_eq!(apply_sur(s1, apply_inj(i1, x)), apply_inj(i2, apply_sur(s2, x)))
  }
}

///|
test {
  verify_solution!([1, 1, 1], [2, 1])
}

///|
test {
  verify_solution!([1, 2, 1], [2, 2])
}

///|
test {
  verify_solution!([1, 3, 1], [1, 2, 2])
}
