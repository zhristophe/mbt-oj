///| 后缀树
fn solution(strings : Array[String]) -> Int {
  let builder = StringBuilder::new()
  for i, s in strings {
    builder.write_string(s)
    builder.write_char(Char::from_int('z'.to_int() + i + 1))
  }
  let str = builder.to_string()
  let sa = build_suffix_array(str)
  let height = get_height(str, sa)
  let owner = strings.map(fn { _ => 0 })
  for i, s in strings {
    owner[i] = s.length() + 1 + (if i == 0 { 0 } else { owner[i - 1] })
  }
  let get_owner = fn(i : Int) {
    loop 0 {
      idx => if i < owner[idx] { return idx } else { continue idx + 1 }
    }
  }
  let k = strings.length()
  let mut res = 0
  // let mut res2 = []
  for i in 0..<sa.length() {
    let set = @hashset.new()
    let j = loop i {
      j => {
        if j >= sa.length() {
          break None
        }
        set.add(get_owner(sa[j]))
        if set.size() == k {
          break Some(j)
        }
        continue j + 1
      }
    }
    if j is None {
      continue
    }
    let min = height[i + 1:j.unwrap() + 1].fold(init=@int.max_value, fn {
      acc, x => @math.minimum(acc, x)
    })
    res = @math.maximum(res, min)
  }
  res
}

///|
pub fn build_suffix_array(s : String) -> Array[Int] {
  let n = s.length()
  let mut k = 1
  let sa = Array::makei(n, fn { i => i })
  let mut ra = s.iter().map(fn { c => c.to_int() - 'a' }).collect()
  while k < n {
    counting_sort(sa, ra, n, k)
    let new_ra = Array::make(n, 0)
    for i in 1..<n {
      let cur = if sa[i] + k < n {
        (ra[sa[i]], ra[sa[i] + k])
      } else {
        (ra[sa[i]], -1)
      }
      let prev = if sa[i - 1] + k < n {
        (ra[sa[i - 1]], ra[sa[i - 1] + k])
      } else {
        (ra[sa[i - 1]], -1)
      }
      new_ra[sa[i]] = new_ra[sa[i - 1]] + (if cur == prev { 0 } else { 1 })
    }
    ra = new_ra
    // 提前终止
    if ra[sa[n - 1]] == n - 1 {
      break
    }
    k *= 2
  }
  sa
}

///|
pub fn counting_sort(
  sa : Array[Int],
  ra : Array[Int],
  n : Int,
  k : Int
) -> Unit {
  let m = ra.iter().maximum().or(0) + 2
  let freq = Array::make(m, 0)
  let new_sa = Array::make(n, 0)
  for x in sa {
    let key = if x + k < n { ra[x + k] + 1 } else { 0 }
    freq[key] += 1
  }
  for i in 1..<m {
    freq[i] += freq[i - 1]
  }
  for x in sa.rev() {
    let key = if x + k < n { ra[x + k] + 1 } else { 0 }
    freq[key] -= 1
    new_sa[freq[key]] = x
  }
  freq.map_inplace(fn { _ => 0 })
  for x in new_sa {
    freq[ra[x]] += 1
  }
  for i in 1..<m {
    freq[i] += freq[i - 1]
  }
  for x in new_sa.rev() {
    let key = ra[x]
    freq[key] -= 1
    sa[freq[key]] = x
  }
}

///|
pub fn get_ra(sa : Array[Int]) -> Array[Int] {
  let n = sa.length()
  let ra = Array::make(n, 0)
  for i in 0..<n {
    ra[sa[i]] = i
  }
  ra
}

///|
pub fn get_height(
  s : String,
  sa : Array[Int],
  ra~ : Array[Int]? = None
) -> Array[Int] {
  let chars = s.iter().collect()
  let n = chars.length()
  let ra = if ra is Some(ra) { ra } else { get_ra(sa) }
  let height = Array::make(n, 0)
  let mut k = 0
  for i in 0..<n {
    if ra[i] == 0 {
      continue // 约定 height[0] == 0
    }
    let j = sa[ra[i] - 1]
    while i + k < n && j + k < n && chars[i + k] == chars[j + k] {
      k += 1
    }
    height[ra[i]] = k
    if k > 0 {
      k -= 1
    }
  }
  height
}

///|
test {
  // Basic test case
  inspect!(solution(["ababc", "cbaab"]), content="2")
  inspect!(solution(["abc", "bcd", "cde"]), content="1")
  solution(["xx", "xxxy"]) |> ignore
}
