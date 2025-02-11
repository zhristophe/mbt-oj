///| 一个序列增加一个等价于另一个序列减少一个
fn solution(dna1 : String, dna2 : String) -> Int {
  let f = []
  for i in 0..=dna1.length() {
    let tmp = []
    for j in 0..=dna2.length() {
      tmp.push(@int.max_value)
    }
    f.push(tmp)
  }
  for i in 0..=dna1.length() {
    f[i][0] = i
  }
  for j in 0..=dna2.length() {
    f[0][j] = j
  }
  for i in 1..=dna1.length() {
    for j in 1..=dna2.length() {
      if dna1[i - 1] == dna2[j - 1] {
        f[i][j] = f[i - 1][j - 1]
      } else {
        f[i][j] = 1 +
          @math.minimum(
            f[i - 1][j - 1], // 替换
            @math.minimum(
              f[i - 1][j], // 删除1
              f[i][j - 1], // 删除2
            ),
          )
      }
    }
  }
  f[dna1.length()][dna2.length()]
}

test {
  inspect!(solution("AGT", "AGCT"), content="1")
  inspect!(solution("AACCGGTT", "AACCTTGG"), content="4")
  inspect!(solution("ACGT", "TGC"), content="3")
  inspect!(solution("A", "T"), content="1")
  inspect!(solution("AGCTTAGC", "AGCTAGCT"), content="2")
  inspect!(solution("AGCCGAGC", "GCTAGCT"), content="4")
}
