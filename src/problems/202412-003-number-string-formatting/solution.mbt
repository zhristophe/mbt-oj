///|
fn solution(s : String) -> String {
  // oj 不支持该语法
  // guard let [p0, .. p1] = s.split(".").collect()
  // let p1 = if p1.length() == 0 { "" } else { "." + p1[0] }
  let parts = s.split(".").collect()
  let p0 = parts[0]
  let p1 = if parts.length() == 1 { "" } else { "." + parts[1] }
  let p0 = p0.trim_start("0")
  let p0 = if p0.is_empty() { "0" } else { p0 }
  let p0 = loop "", p0.to_array()[:] {
    res, [] => break res
    res, str => {
      let res = res + str[0].to_string()
      let res = if str.length() % 3 == 1 && str.length() > 1 {
        res + ","
      } else {
        res
      }
      continue res, str[1:]
    }
  }
  p0.to_string() + p1
}

test {
  inspect!(solution("1294512.12412"), content="1,294,512.12412")
  inspect!(solution("0000123456789.99"), content="123,456,789.99")
  inspect!(solution("987654321"), content="987,654,321")
}
