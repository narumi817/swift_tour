import UIKit

/*
 A Swift Tour
 https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html
 
 とりあえず一通り写経
*/

print("Hello, world!")

/* Simple values */
// 変数・定数は定義された値から型推論する
// var : 変数を定義する
var myVariable = 42
myVariable = 50
// let : 定数を定義する
let myConstant = 42

// 初期値がないなどで型推論できない場合は型定義が必要
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
let explicitFloat: Float = 4

// 型変換は明示的に！（勝手に変数の型が変わったりはしない）
let label = "The width is "
let width = 94
let widthLabel = label + String(width)

// 値を文字列に含めるとき \([変数]) のように書く
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

let weight: Float = 45
let myWeight = "my weight is \(weight)"

// 文字列が複数行になる場合は、 """ を使う
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces
 of fruit."
"""

// 配列・辞書 : [] を使用する
// 要素を取得する時は list[index] / map[key]
var shoppingList = ["catfish", "water", "tulips"]
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Pablic Relations"

// 配列の要素の追加
shoppingList.append("blue paint")
print(shoppingList)

// 空の配列・辞書の作成は初期化構文を使う
let emptyArray = [String]()
let emptyDictionary = [String: Float]()

// 型情報が推論できる場合(すでにある変数の初期化、関数の引数など)の空の配列の定義
shoppingList = []
occupations = [:]


/* Control Flow **/
// 条件式 : if, switch
// ループ式: for-in, while, repeat-while
// () はなくてもよい
// bodyは {} で囲む
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    // if文の条件式はbool値
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

// optional value : nilが入りうる値
// https://qiita.com/maiki055/items/b24378a3707bd35a31a8
// ? を型の後に記述すると定義できる
var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = nil
var greeting = "Hello!"
// optionalNameがnilの場合はelse句に、それ以外はラップ解除され定数に割り当てる
if let name = optionalName {
    // だからここでラップされていない値が使える
    greeting = "Hello, \(name)"
} else {
    greeting = "No name"
}

// ?? を使うとnilの場合にデフォルト値(??の後ろに指定した値)が使われる
let nickname: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickname ?? fullName)"

// switch文は default節 が必須
// 一致したケースがあったらswitch文から抜けるから、 break は不要
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    // パターン一致した値を定数に割り当ててる
    // case ~ let ~ where : https://sites.google.com/site/ksatohgswiftmemo/kanketsu/case-let-where
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes goos in soup.")
}

// for-in
// 辞書はループさせると順不同
let interestingNumbers = [
    "Prime": [2,3,5,7,11,13],
    "Fibonacci": [1,1,2,3,5,8],
    "Square": [1,4,9,16,25],
    "Over30": [30,31,32,33,34,35]
]
var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

// while
// ループの条件を最後にしてループが少なくとも1回実行されるようにすることもできる
var n = 2
while n < 100 {
    n *= 2
}
print(n)

var m = 2
repeat {
    m *= 2
} while m < 100
print(m)

// ..<(上限値含まない), ...(上限値含む) を使用してインデックスの範囲を作成できる
var total = 0
for i in 0..<4 {
    total += i
}
print(total)


/* Functions and Closures */
// func で関数を宣言
// -> の後ろに戻り値に 型 を定義する
func greet(person: String, lunch: String) -> String {
    return "Hello \(person), today's lunch special is \(lunch)."
}
greet(person: "Bob", lunch: "Salad")

// 関数はパラメータ名をラベルとする
// パラメータ名の前に カスタム引数ラベルを記述 OR _ で引数ラベルを使用しないこともできる
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")

// タプル
// タプルの参照は、名前かindexで可能
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

// 関数は入れ子にできる
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

// 関数は first-class type : 関数は別の関数をその値として返す
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

// 関数は引数に別の関数を取ることもできる
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

// 関数は実際はクロージャ(後で呼び出すことができるコードのブロック)の特別なケース
// コードを {} で囲むことで名前のないクロージャが作成できる
// 引数と戻り値の型を本体から分離するには、in を使用する
numbers.map({ (number: Int) -> Int in
    if number % 2 == 0 {
        return number
    }
    return 0
})

// クロージャのタイプが分かっている場合は、パラメータの型、戻り値に型はどちらも省略可
// 1行のクロージャは値を暗黙的に返す
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

// クロージャは名前じゃなくて数字でも参照できる
// 関数の最後の引数は括弧の直後に表示できる。引数がクロージャだけの場合は、括弧は完全に省略できる
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)


/* オブジェクトとクラス */
class Shape {
    let maxSize = 5
    var numberOfSides = 0
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    
    func description(description: String) -> String {
        return "A shape is \(description)."
    }
}

// インスタンス作成
// インスタンスのプロパティ、メソッドにアクセスするには ドット(.)構文 を使う
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

// init を使って、インスタンス作成時のクラスの設定をする
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        // selfを使って、nameプロパティを設定
        // インスタンス作成時に引数を設定する
        // ※クリーンアップが必要な場合は、 deinit を使用する
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

// サブクラスでは、クラス名の後ろに : で区切られたスーパークラス名が含まれる
// スーパークラスの実装はオーバーライドする時は override を使用する
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

class Circled: NamedShape {
    var radius: Double
    
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
    }
    
    func area() -> Double {
        return radius * radius * 3.14
    }
    
    override func simpleDescription() -> String {
        return "A circle with radius \(radius)."
    }
}
let circle = Circled(radius: 4, name: "my test circle")
circle.area()
circle.simpleDescription()

// setter と getter
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        // サブクラスのプロパティの値の設定
        self.sideLength = sideLength
        // スーパークラスのinitializerを呼び出し
        super.init(name: name)
        // スーパークラスで定義されたプロパティの値を変更
        numberOfSides = 3
    }
    
    // 3辺の長さの合計
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            // setterは newValue を暗黙的に持っている
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)

// 新しい値を計算する必要はないが、値を設定する前後で処理が必要な場合 willSet, didSet を使用する
// initializer 以外で値が変更される度に実行される
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "lager square")
print(triangleAndSquare.triangle.sideLength)

// オプショナル型でプロパティ値にアクセスしたい時は変数の後ろに ? をつける => nilの場合はnilが返ってくる
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength


/* Enumerations and Structures */
// 列挙には enum を使う
enum Rank: Int {
    // rawValueはデフォルト 0 だけど、指定することで変更可能
    // ace = 1 を割り当てると、それ以降は順番にrawValueが割り当てられる
    case ace = 1
    case two, three, four, five, six, seven, wight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
    
    func compare(first: Rank, second: Rank) -> Rank {
        if first.rawValue > second.rawValue {
            return first
        }
        return second
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue

// init?(rawValue:) でrawValueからEnumのインスタンスを作成する
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
    print(threeDescription)
}

// rawValueが必要ない場合は、設定する必要はない
enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades: // self.spades の省略系 (self が Suit なのが既知だから省略できる)
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .hearts, .diamonds:
            return "red"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()
print(hearts.color())

// 列挙型のcaseによって異なるrawValueを持つことも可能
enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure... \(message)")
}

// 構造体を作成するには struct を使用する
// 構造体はコピーで渡されて、クラスは参照によって渡される
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()


/* Protcols and Extensions */
// protcol を使用してプロトコルの宣言ができる
protocol ExampleProtocol {
    var simpleDescription: String { get }
    // mutating を設定することで　struct と enum に対してプロパティが変更できるようになる
    mutating func adjust()
}

// クラス(class)、列挙(enum)、構造体(struct)は全てプロトコルを採用できる
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescriotion = b.simpleDescription

// 拡張機能( extension )を使用する
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)

// プロトコルも他のクラスなど同様に使用できる
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// 型がExampleProtocolだから、SimpleClassで追加したanotherPropertyは参照できない
//print(protocolValue.anotherProperty)


/* Error Handling */
// Error プロトコルを使用してエラーを表すことができる
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

// throw を使用してエラーをスローする
// throws を使用して、エラーをスローする可能性があることを示す
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

// エラー処理
// do-catch
// do ブロック ： エラーをスローする可能性があるコードの前に try を書いてマークする
// catch ブロック　：　エラーには自動的に error という名前がつく
do {
    let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
    print(printerResponse)
} catch {
    print(error)
}

// catch　ブロックは複数定義できる
do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutemberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

// try? を使用すると結果がオプショナル型に変換される
// エラーをスローされた場合、値は nil になる
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")

// defer を使用して、関数内の他の全てのコードのあとで実行するためのブロックを記述する
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
print(fridgeIsOpen)


/* Generics */
// <> 内に名前を記述して、汎用な関数、型を作成する
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes: 4)

// 関数、メソッド、クラス、列挙、構造の一般的な形式を作成できる
// Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)

// ↓ 全く分かってない_:(´ཀ`」 ∠):
// 要件のリストを指定するbody直前に where を使用する
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool where T.Element: Equatable, T.Element == U.Element {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1,2,3], [3])
