///|
enum Operator {
  Add
  Sub
  Mul
  Div
} derive(Show, Eq)

///|
enum Token {
  Number(Int)
  Op(Operator)
  Left_Parenthesis
  Right_Parenthesis
} derive(Show, Eq)

///|
enum Expr {
  Number(Int)
  Op(Expr, Operator, Expr)
} derive(Show, Eq)

///|
type! ParseError  derive(Eq, Show)

///|
fn solution(input : Array[Token]) -> Expr!ParseError {
  parse_expr!(input[:]).0
}

///|
fn parse_expr(input : ArrayView[Token]) -> (Expr, ArrayView[Token])!ParseError {
  let (expr, input) = parse_term!(input)
  let mut expr = expr
  loop input {
    [] => return (expr, input)
    [head, .. last] as input =>
      match head {
        Right_Parenthesis => return (expr, input)
        Op(op) => {
          let (right, last) = parse_term!(last)
          expr = Expr::Op(expr, op, right)
          continue last
        }
        _ => raise ParseError
      }
  }
}

///|
fn parse_term(input : ArrayView[Token]) -> (Expr, ArrayView[Token])!ParseError {
  let (expr, input) = parse_factor!(input)
  let mut expr = expr
  loop input {
    [] => return (expr, [][:])
    [head, .. last] as input =>
      match head {
        Op(op) =>
          match op {
            Mul | Div => {
              let (right, last) = parse_factor!(last)
              expr = Expr::Op(expr, op, right)
              continue last
            }
            Add | Sub => return (expr, input)
          }
        Right_Parenthesis => return (expr, input)
        _ => raise ParseError
      }
  }
}

///|
fn parse_factor(
  input : ArrayView[Token]
) -> (Expr, ArrayView[Token])!ParseError {
  match input {
    [head, .. last] =>
      match head {
        Left_Parenthesis => {
          let (expr, last) = parse_expr!(last)
          match last {
            [] => raise ParseError
            [head, .. last] => {
              guard head == Right_Parenthesis else { raise ParseError }
              return (expr, last)
            }
          }
        }
        Number(n) => (Expr::Number(n), last)
        _ => raise ParseError
      }
    _ => raise ParseError
  }
}

///|
fn parse(input : String) -> Expr!ParseError {
  let tokens = []
  let mut num = None
  input
  .iter()
  .each(fn(c) {
    match c {
      '0'..='9' => {
        let mut tmp = match num {
          Some(n) => n
          _ => 0
        }
        tmp *= 10
        tmp += c - '0'
        num = Some(tmp)
      }
      _ => {
        if num is Some(n) {
          tokens.push(Token::Number(n))
          num = None
        }
        let token : Token = match c {
          '+' => Op(Operator::Add)
          '-' => Op(Operator::Sub)
          '*' => Op(Operator::Mul)
          '/' => Op(Operator::Div)
          '(' => Left_Parenthesis
          ')' => Right_Parenthesis
          ' ' => return
          _ => panic()
        }
        tokens.push(token)
      }
    }
  })
  if num is Some(n) {
    tokens.push(Token::Number(n))
  }
  println("tokens: \{tokens}")
  parse_expr!(tokens[:]).0
}

///|
test {
  try {
    let expr = parse!(" ((1123)) + (2 - 3) /4*4")
    println(expr)
  } catch {
    err => println(err)
  }
}

///|
test {
  assert_eq!(
    solution?([Number(1), Op(Add), Number(2), Op(Mul), Number(3)]),
    Ok(Op(Number(1), Add, Op(Number(2), Mul, Number(3)))),
  )
  assert_eq!(
    solution?([Number(1), Op(Mul), Number(2), Op(Add), Number(3)]),
    Ok(Op(Op(Number(1), Mul, Number(2)), Add, Number(3))),
  )
}

///|
test {
  assert_eq!(
    solution?([
      Left_Parenthesis,
      Number(1),
      Op(Add),
      Number(2),
      Right_Parenthesis,
      Op(Mul),
      Number(3),
    ]),
    Ok(Op(Op(Number(1), Add, Number(2)), Mul, Number(3))),
  )
}

///|
test {
  assert_eq!(solution?([Number(1), Op(Add)]), Err(ParseError))
}
