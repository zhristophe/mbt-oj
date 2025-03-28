///| 滚动数字，记忆化搜索
/// 其中，0一定是被移位消去
fn tmp(n : String) -> Int {
  let q = @queue.new()
  let n = try {
    @strconv.parse_uint64!(n)
  } catch {
    _ => 0
  }
  let n = BigInt::new(n)
  let visited = @hashset.new()
  q.push((n, 0))
  visited.add(n)
  while true {
    guard q.pop() is Some((n, steps)) else { break }
    if n.is_1() {
      return steps
    }
    for n in [n.copy().shift(), n.copy().add_i()] {
      guard visited.contains(n) == false else { continue }
      visited.add(n)
      q.push((n, steps + 1))
    }
    println(q)
    println("")
  }
  0
}

///|
struct BigInt {
  data : Array[UInt64]
} derive(Show, Eq)

///|
pub impl Hash for BigInt with hash_combine(self, hasher) {
  hasher.combine_uint64(self.data[0])
}

///|
let cell_max_val : UInt64 = {
  let mut tmp : UInt64 = 1
  for _ in 0..<18 {
    tmp *= 10
  }
  tmp
}

///|
fn BigInt::new(n : UInt64) -> BigInt {
  { data: [n] }
}

///| 有bug
fn BigInt::from_str(s : String) -> BigInt {
  let n = s.length()
  let s = if n % 18 != 0 { "0".repeat(18 - n % 18) + s } else { s }
  let n = s.length()
  let s = s[:]
  let data = []
  for i in 0..<(n / 18) {
    let i = n / 18 - i - 1
    let seg = s[i * 18:(i + 1) * 18]
    data.push(
      try {
        @strconv.parse_uint64!(seg.to_string())
      } catch {
        _ => 0
      },
    )
  }
  { data, }
}

///|
fn BigInt::add_i(self : BigInt, i~ : UInt64 = 1) -> BigInt {
  let data = self.data
  data[0] += i
  loop 0 {
    idx => {
      if idx >= data.length() {
        break
      }
      let mut f = false
      while data[idx] >= cell_max_val {
        f = true
        data[idx] -= cell_max_val
        if idx == data.length() - 1 {
          data.push(0)
        }
        data[idx + 1] += 1
      }
      if f {
        continue idx + 1
      }
      break
    }
  }
  self
}

///|
fn BigInt::shift(self : BigInt) -> BigInt {
  let data = self.data
  let high = loop 1U.to_uint64() {
    n => {
      if n > data.last().unwrap() / 10 {
        break n
      }
      continue n * 10
    }
  }
  let n = loop 0U.to_uint64() {
    n => {
      if high * (n + 1) > data.last().unwrap() {
        break n
      }
      continue n + 1
    }
  }
  data[data.length() - 1] -= n * high
  while data.length() > 1 && data.last().unwrap() == 0 {
    data.pop() |> ignore
  }
  data[0] *= 10
  self.add_i(i=n)
}

///|
fn BigInt::is_1(self : BigInt) -> Bool {
  self.data.length() == 1 && self.data[0] == 1
}

///|
fn BigInt::copy(self : BigInt) -> BigInt {
  { data: self.data.copy() }
}

///|
test {
  inspect!(solution("1000_000"), content="1")
  inspect!(solution("99999908999"), content="10")
}
